<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Controllers\MatchGame\Shared\AccessController;
use App\Helpers\PaginationHelper;
use App\Models\MatchGame;
use App\Models\Team;
use App\Repositories\EventLogRepository;
use App\Repositories\TeamRepository;
use App\Repositories\MatchGameRepository;
use App\Services\EventLogging\MatchEventLoggingService;
use App\Services\MatchService;

class MatchController extends AccessController
{
    protected $logRepo;
    protected $teamRepo;
    protected $matchRepo;
    protected $eventLoggerService;
    protected $matchService;
    protected $view;

    public function __construct(
        EventLogRepository $logRepo,
        TeamRepository $teamRepo,
        MatchGameRepository $matchRepo,
        MatchEventLoggingService $eventLoggerService,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->logRepo = $logRepo;
        $this->teamRepo = $teamRepo;
        $this->matchRepo = $matchRepo;
        $this->eventLoggerService = $eventLoggerService;
        $this->matchService = $matchService;
        $this->view = $view;
    }

    public function showStartMatchForm(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'match/start_match.twig', [
            'team' => $team, 
            'eligibleTeams' => $this->teamRepo->getEligableTeams($team)
        ]);
    }

    public function startMatch(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $awayTeamId = (int) $data['opponent_team_id'];
        $awayTeamName = $data['unregistered_name'] ?? '';

        $match = $this->matchService->startOrJoinMatch($team, $awayTeamId, $awayTeamName);
        $this->eventLoggerService->logMatchStart($match);

        // Redirect to weather form
        return $response
        ->withHeader('Location', "/match/{$match->id}/gate")
        ->withStatus(302);
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

        return $this->view->render($response, 'match/end_match.twig', [
            'match' => $currentMatch,
            'user_team_id' => $team->id,
            'recovered_players' => $recoveredPlayers,
            'mvp_players' => $mvpPlayers
        ]);
    }
}