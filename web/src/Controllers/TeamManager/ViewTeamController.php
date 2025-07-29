<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\Shared\AccessController;
use App\Helpers\UserHelper;
use App\Models\Coach;
use App\Models\Team;
use App\Models\Player;
use Slim\Views\Twig;

class ViewTeamController extends AccessController
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

        $user = Coach::find($userId);
        $teams = (!$user) ? Team::all() : Team::where('coach_id', $user->id)->get();

        if ($format === 'json') {
            $response->getBody()->write($teams->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }
        
        $data = ['teams' => $teams];
        if ($user) $data['user'] = $user;
        
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
