<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Controllers\MatchGame\Shared\AccessController;
use App\Enums\Match\Status as MatchStatus;
use App\Enums\TeamStatus;
use App\Repositories\EventLogRepository;
use App\Repositories\MatchGameRepository;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\MatchService;

class PostGameController extends AccessController
{
    protected $logRepo;
    protected $matchRepo;
    protected $eventLoggerService;
    protected $matchService;
    protected $view;

    public function __construct(
        EventLogRepository $logRepo,
        MatchGameRepository $matchRepo,
        MatchEventLoggingService $eventLoggerService,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->logRepo = $logRepo;
        $this->matchRepo = $matchRepo;
        $this->eventLoggerService = $eventLoggerService;
        $this->matchService = $matchService;
        $this->view = $view;
    }

    public function endMatch(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $currentMatch = $this->matchRepo->getTeamCurrentMatch($team->id);
        if (!$currentMatch) {
            // @todo: send to view match with a notice>
            $response->getBody()->write('No valid match in progress to end.');
            return $response->withStatus(409);
        }

        $this->matchService->setStatus($currentMatch, TeamStatus::POST_SEQUENCE);
        $this->eventLoggerService->logMatchEnd($currentMatch);

        // unmark and MNG - use event logs to wake up those that were not MNG this match
        $recoveredPlayers = $this->matchService->restorePlayersFromMissNextGame($currentMatch);

        // award MVP spp
        $mvpPlayers = $this->matchService->awardMVP($currentMatch);
        foreach ($mvpPlayers as $player) {
            $this->eventLoggerService->logMatchEndAwardMVP($currentMatch, $player);
        }

        // calculate winnings - send to form to enter D6
        [$homeWinnings, $awayWinnings] = $this->matchService->calculateWinnings($currentMatch);
        $this->eventLoggerService->logMatchEndWinningsAwarded($currentMatch, $homeWinnings, $awayWinnings);
        
        $currentMatch->status = MatchStatus::POSTGAME;
        $currentMatch->save();

        return $this->view->render($response, 'match/end/end_match.twig', [
            'match' => $currentMatch,
            'recovered_players' => $recoveredPlayers,
            'mvp_players' => $mvpPlayers,
            'winnings' => ['home' => $homeWinnings, 'away' => $awayWinnings],
            'team' => $team
        ]);
    }

    public function updatePopularity(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $currentMatch = $this->matchRepo->getTeamCurrentMatch($team->id);
        if (!$currentMatch) {
            // @todo: send to view match with a notice>
            $response->getBody()->write('No valid match in progress to end.');
            return $response->withStatus(409);
        }

        $data = $request->getParsedBody();
        $homeRoll = $data['home_roll'] ?? 1;
        $awayRoll = $data['away_roll'] ?? 1;

        // update fans
        $adjustment = $this->matchService->updatePopularity($currentMatch, $homeRoll, $awayRoll);
        $this->eventLoggerService->logMatchEndUpdatePopularity($currentMatch, $adjustment);
        $this->matchService->setStatus($currentMatch, TeamStatus::IDLE);

        $currentMatch->status = MatchStatus::FINSIHED;
        $currentMatch->save();

        return $this->view->render($response, 'match/end/fan_factor_result.twig', [
            'match' => $currentMatch,
            'adjustment' => $adjustment,
            'team' => $team
        ]);
    }
}