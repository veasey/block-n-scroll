<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\Players\Shared\AccessController;
use App\Repositories\MatchGameRepository;
use App\Services\EventLoggerService;
use App\Services\Event\InjuryService;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStats;
use App\Enums\LogType;
use Slim\Views\Twig;

class UpdateController extends AccessController
{
    protected $matchGameRepo;
    protected $eventLogger;
    protected $injuryService;
    protected $view;

    public function __construct(
        MatchGameRepository $matchGameRepo,
        EventLoggerService $eventLogger, 
        InjuryService $injuryService,
        Twig $view
    )
    {
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
            return $this->view->render($response, "event/injury/injury_roll_form.twig", ['player' => $player]);
        }

        $match = $this->matchGameRepo->getTeamCurrentMatch($player->team->id) ?? null;

        $this->eventLogger->log(
            LogType::PLAYER_INJURED->value,
            $injuryType->value,
            '',
            '',
            $player->team->coach,
            $player->team,
            $player,
            $match
        );

        return $this->view->render($response, "event/injury/result.twig", [
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
            $player->pa -= 1;
            $reductionType = PlayerStats::PASSING_ABILITY;
        }

        if ($lastingInjuryRoll == 5) {
            $player->ag -= 1;
            $reductionType = PlayerStats::AGILITY;
        }

        if ($lastingInjuryRoll == 6) {
            $player->st -= 1;
            $reductionType = PlayerStats::STRENGTH;
        }

        $player->save();

        $match = $this->matchGameRepo->getTeamCurrentMatch($player->team->id) ?? null;

        $this->eventLogger->log(
            LogType::PLAYER_INJURED->value,
            CasualtyTable::LASTING_INJURY->value,
            $reductionType->value,
            $reductionType->value . ' reduced by 1',
            $player->team->coach,
            $player->team,
            $player,
            $match
        );

        return $this->view->render($response, 'event/injury/lasting_injury_result.twig', [
            'player' => $player,
            'reductionType' => $reductionType
        ]);
    }
}
