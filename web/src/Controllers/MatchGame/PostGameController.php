<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Controllers\MatchGame\Shared\AccessController;
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
            $response->getBody()->write('No valid match in progress to end.');
            return $response->withStatus(409);
        }

        $this->matchService->endMatch($currentMatch);
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
        
        // update fans
        $this->matchService->updatePopularity($currentMatch);

        return $this->view->render($response, 'match/end/end_match.twig', [
            'match' => $currentMatch,
            'user_team_id' => $team->id,
            'recovered_players' => $recoveredPlayers,
            'mvp_players' => $mvpPlayers,
            'winnings' => ['home' => $homeWinnings, 'away' => $awayWinnings]
        ]);
    }
}