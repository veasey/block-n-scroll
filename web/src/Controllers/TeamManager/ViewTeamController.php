<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Models\Team;
use Slim\Views\Twig;

class ViewTeamController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function listTeams(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';
        $userId = $_SESSION['user_id'] ?? null;

        if ($userId === null) {
            $teams = Team::where('coach_id', $userId)->get();
        } else {
            $teams = Team::all();
        }

        if ($format === 'json') {
            $response->getBody()->write($teams->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }

        $data = [
            'teams' => $teams,
            'user' => [
                'id' => $userId,
                'name' => $_SESSION['user'] ?? 'Guest',
            ],
        ];
        return $this->view->render($response, 'team/list.twig', $data);
    }

    public function viewTeam(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'] ?? null;

        if (!$teamId) {
            $response->getBody()->write('Team ID is required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);

        if (!$team) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

        return $this->view->render($response, 'team/view.twig', ['team' => $team]);
    }
}
