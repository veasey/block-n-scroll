<?php
namespace App\Controllers\TeamManager;

use BaseController;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\TeamManagementBaseController;
use App\Helpers\UserHelper;
use App\Models\Team;
use App\Models\Player;
use Slim\Views\Twig;

class ViewTeamController extends TeamManagementBaseController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function listTeams(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';
        $userId = $args['user_id'] ?? null;

        $teams = (!$userId) ? Team::all() : Team::where('coach_id', $userId)->get();

        if ($format === 'json') {
            $response->getBody()->write($teams->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }

        $data['teams'] = $teams;
        if ($userId) {
           $data['user'] = [
                'id' => $userId,
                'name' => $_SESSION['user'] ?? 'Guest',
            ];
        }

        return $this->view->render($response, 'team/list.twig', $data);
    }

    public function viewTeam(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'] ?? null;
        $format = $args['format'] ?? 'html';

        if (!$teamId) {
            $response->getBody()->write('Team ID is required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);
        $players = Player::where('team_id', $team->id)->get();

        if ($format === 'json') {
            $response->getBody()->write(json_encode($team));
            return $response->withHeader('Content-Type', 'application/json');
        }

        if (!$team) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

        $user = UserHelper::getCurrentUser();

        return $this->view->render($response, 'team/view.twig', [
            'team' => $team, 
            'players' => $players,
            'showManagementButtons' => $this->isAuthorizeToModifyTeam($user, $team)
        ]);
    }

    
}
