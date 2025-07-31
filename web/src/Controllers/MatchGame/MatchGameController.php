<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Controllers\MatchGame\Shared\AccessController;
use App\Models\Team;
use App\Repositories\TeamRepository;
use App\Repositories\MatchGameRepository;
use App\Services\EventLoggerService;
use App\Services\MatchService;

class MatchGameController extends AccessController
{
    protected $teamRepo;
    protected $matchRepo;
    protected $eventLoggerService;
    protected $matchService;
    protected $view;

    public function __construct(
        TeamRepository $teamRepo,
        MatchGameRepository $matchRepo,
        EventLoggerService $eventLoggerService,
        MatchService $matchService,
        Twig $view
    )    
    {
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