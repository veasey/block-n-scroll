<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Players\Shared\AccessController;
use App\Constants\SPPAward;
use App\Enums\TeamStatus;
use App\Helpers\TeamHelper;
use App\Helpers\MatchHelper;
use App\Repositories\MatchGameRepository;
use App\Services\EventLogging\PlayerEventLoggingService;
use App\Services\Event\InjuryService;
use App\Enums\LogType;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStatus;
use App\Enums\Player\PlayerStats;
use Slim\Views\Twig;

class UpdateController extends AccessController
{
    protected $matchHelper;
    protected $teamHelper;
    protected $matchGameRepo;
    protected $eventLogger;
    protected $injuryService;
    protected $view;

    public function __construct(
        MatchHelper $matchHelper,
        TeamHelper $teamHelper,
        MatchGameRepository $matchGameRepo,
        PlayerEventLoggingService $eventLogger, 
        InjuryService $injuryService,
        Twig $view
    )
    {
        $this->teamHelper = $teamHelper;
        $this->matchHelper = $matchHelper;
        $this->matchGameRepo = $matchGameRepo;
        $this->eventLogger = $eventLogger;
        $this->injuryService = $injuryService;
        $this->view = $view;
    }
    
    public function addInjury(Request $request, Response $response, array $args): Response
    {
        $data = $request->getParsedBody();        
        $roll = $data['injury_roll'] ?? null;
        $playerId = $data['player_id'] ?? null;

        [$player, $errorResponse] = $this->getRecognisedPlayerOrFail($request, $response, $args, $playerId);
        if ($errorResponse) return $errorResponse;

        if (!$roll) {
            $response->getBody()->write('Roll Required');
            return $response->withStatus(400);
        }

        if (!$this->isAuthorizeToManagePlayer($player)) {
            $response->getBody()->write('Not authorised');
            return $response->withStatus(403);
        }        

        $injuryType = $this->injuryService->record($player, $roll);

        if ($injuryType == CasualtyTable::LASTING_INJURY) {
            return $this->view->render($response, "player/event/injury/injury_roll_form.twig", ['player' => $player]);
        }

        $match = $this->matchGameRepo->getTeamCurrentMatch($player->team->id) ?? null;
        $this->eventLogger->logPlayerInjury($match, $player, $injuryType);

        return $this->view->render($response, "player/event/injury/result.twig", [
            'player' => $player,
            'injury' => $injuryType
        ]);
    }

    public function addLastingInjury(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $lastingInjuryRoll = (int) $data['injury_roll'] ?? 0;
        $reductionType = null;

        if ($lastingInjuryRoll <= 2) {
            $player->av -= 1;
            $reductionType = PlayerStats::ARMOUR_VALUE;
        }

        if ($lastingInjuryRoll == 3) {
            $player->ma -= 1;
            $reductionType = PlayerStats::MOVEMENT_ALLOWANCE;
        }

        if ($lastingInjuryRoll == 4) {
            $player->pa += 1;
            $reductionType = PlayerStats::PASSING_ABILITY;
        }

        if ($lastingInjuryRoll == 5) {
            $player->ag += 1;
            $reductionType = PlayerStats::AGILITY;
        }

        if ($lastingInjuryRoll == 6) {
            $player->st -= 1;
            $reductionType = PlayerStats::STRENGTH;
        }

        $player->save();

        $match = $this->matchGameRepo->getTeamCurrentMatch($player->team->id) ?? null;

        $this->eventLogger->logPlayerLastingInjury($match, $player, $reductionType);

        return $this->view->render($response, 'player/event/injury/lasting_injury_result.twig', [
            'player' => $player,
            'reductionType' => $reductionType
        ]);
    }

    public function retireConfirm(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'player/retire/confirm.twig', ['player' => $player]);
    }

    public function retire(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getAuthorizedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        if ($player->status == PlayerStatus::RETIRED->value) {
            $response->getBody()->write('Cannot retire a player who is already retired');
            return $response->withStatus(403);
        }

        $team = $player->team;
        if (!$this->teamHelper->isLowCostLineman($player->position, $team->race)) {
            $team->current_team_value -= $player->cost;
        }

        // if  team is still fresh, don't log these adjustments and return cost.
        if (TeamStatus::tryFrom($team->status) == TeamStatus::FRESH) {
            $team->treasury += $player->cost;
        } else {
            $this->eventLogger->logPlayerRetirement($player);
        }
        $team->save(); 

        $player->status = PlayerStatus::RETIRED->value;
        $player->save();

        
        return $this->view->render($response, 'player/retire/success.twig', ['player' => $player]);
    }

    public function recordCasualty(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getRecognisedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $player->casualties += 1;
        $player->spp += SPPAward::CASUALTY;
        $player->save();

        $match = $this->matchHelper->getCurrentMatchTeamPlayingIn($player->team);
        $this->eventLogger->logPlayerMatchEvent($player, $match, LogType::CASUALTY_LOGGED);
        return $this->view->render($response, "player/event/casualty.twig", ['player' => $player]);
    }

    public function recordTouchdown(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getRecognisedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $match = $this->matchHelper->getCurrentMatchTeamPlayingIn($player->team);

        $player->touchdowns += 1;
        $player->spp += SPPAward::TOUCHDOWN;
        $player->save();

        if ($match->homeTeam->id = $player->team->id) {
            $match->home_score += 1;
        } else {
            $match->away_score += 1;
        }
        $match->save();

        $this->eventLogger->logPlayerMatchEvent($player, $match, LogType::TOUCHDOWN_LOGGED);
        return $this->view->render($response, "player/event/touchdown.twig", ['player' => $player]);
    }

    public function recordCompletion(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getRecognisedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $player->completions += 1;
        $player->spp += SPPAward::COMPLETION;
        $player->save();

        $match = $this->matchHelper->getCurrentMatchTeamPlayingIn($player->team);
        $this->eventLogger->logPlayerMatchEvent($player, $match, LogType::COMPLETION_LOGGED);
        return $this->view->render($response, "player/event/completion.twig", ['player' => $player]);
    }
}
