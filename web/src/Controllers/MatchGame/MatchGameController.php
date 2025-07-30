<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use Slim\Views\Twig;

use App\Controllers\MatchGame\Shared\AccessController;
use App\Repositories\TeamRepository;
use App\Services\MatchService;

class MatchGameController extends AccessController
{
    protected $teamRepo;
    protected $matchService;
    protected $view;

    public function __construct(
        TeamRepository $teamRepo,
        MatchService $matchService,
        Twig $view
    )    
    {
        $this->teamRepo = $teamRepo;
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
}