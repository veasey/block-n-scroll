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
use App\Services\EventLoggerService;
use App\Services\MatchService;

class MatchGameController extends AccessController
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
        EventLoggerService $eventLoggerService,
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

    public function view(Request $request, Response $response, array $args): mixed
    {
        $matchId = $args['match_id'] ?? '';
        $match = MatchGame::find($matchId);
        if (!$match) {
            $response->getBody()->write('Match not found');
            $response->withStatus(404);
        }

        $params = PaginationHelper::getPaginationParams();
        $logs = $this->logRepo->getMatchEventLogs($match);

        $logPage = $logs->slice($params['offset'], $params['perPage']);
        $totalPages = ceil($logs->count() / $params['perPage']);

        return $this->view->render($response, 'match/view.twig', [
            'match' => $match,
            'logs' => $logPage,
            'totalPage' => $totalPages
        ]);
    }

    public function listAll(Request $request, Response $response, array $args): mixed
    {
        $data = $request->getParsedBody();
        return $this->view->render($response, 'match/list.twig', ['matches' => MatchGame::all()]);
    }

    public function listTeamMatches(Request $request, Response $response, array $args): mixed
    {
        $teamId = $args['team_id'] ?? null;
        $matches = MatchGame::where('home_team_id', $teamId)
                    ->orWhere('away_team_id', $teamId)
                    ->get();

        return $this->view->render($response, 'match/list.twig', [
            'matches' => $matches,
            'team' => Team::find($teamId)
        ]);
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

        return $response->withHeader('Location', '/team/view/' . $team->id)->withStatus(302);
    }

    public function endMatch(Request $request, Response $response, array $args)
    {
        [$team, $errorResponse] = $this->getRecognisedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $currentMatch = $this->matchRepo->getTeamCurrentMatch($team->id);
        $this->matchService->endMatch($currentMatch);

        // unmark and MNG - use event logs to wake up those that were not MNG this match
        //$this->matchService->restorePlayersFromMissNextGame($currentMatch);

        // award MVP spp

        // calculate winnings

        return $this->view->render($response, 'match/end_match.twig', [
            'match' => $currentMatch
        ]);
    }    
}