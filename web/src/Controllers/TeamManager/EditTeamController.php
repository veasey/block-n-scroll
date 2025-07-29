<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\TeamManagementBaseController;
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
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'team/manage/edit_team_info.twig', ['team' => $team]);
    }

    public function save(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        $team->name = $data['team_name'] ?? '';
        $team->description = $data['team_bio'] ?? '';        
        $team->save();
        return $response->withHeader('Location', "/team/view/$team->id")->withStatus(302);
    }
}
