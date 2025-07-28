<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\TeamManagementBaseController;
use App\Helpers\UserHelper;
use App\Models\Team;
use Slim\Views\Twig;

class EditTeamController extends TeamManagementBaseController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'] ?? null;
        if (empty($teamId)) {
            $response->getBody()->write('Team ID required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);
        if (empty($teamId)) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

        $user = UserHelper::getCurrentUser();
        if ($this->isAuthorizeToModifyTeam($user, $team)) {
            return $this->view->render($response, 'team/manage/edit_team_info.twig', ['team' => $team]);
        }

        $response->getBody()->write('Not authorised');
        return $response->withStatus(404);
    }

    public function save(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'] ?? null;

        if (empty($teamId)) {
            $response->getBody()->write('Team ID required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);
        if (empty($teamId)) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

        $data = $request->getParsedBody();
        $team->name = $data['team_name'] ?? '';
        $team->description = $data['team_bio'] ?? '';        

        $user = UserHelper::getCurrentUser();
        if ($this->isAuthorizeToModifyTeam($user, $team)) {
            $team->save();
            return $response->withHeader('Location', "/team/view/$team->id")->withStatus(302);
        }

        $response->getBody()->write('Not authorised');
        return $response->withStatus(404);
    }
}
