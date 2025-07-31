<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Enums\TeamStatus;
use App\Controllers\TeamManager\Shared\AccessController;

use Slim\Views\Twig;

class DeleteTeamController extends AccessController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getConfirmView(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        return $this->view->render($response, 'team/manage/delete/confirm.twig', ['team' => $team]);
    }

    public function delete(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        $teamName = $team->name;

        $team->players()->delete();
        $team->delete();

        return $this->view->render($response, 'team/manage/delete/success.twig', ['teamName' => $teamName]);
    }

    public function retire(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        $team->status = TeamStatus::RETIRED;
        $team->save();

        return $this->view->render($response, 'team/manage/retire/retire_success.twig', ['team' => $team]);
    }

    public function unretire(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        $team->status = TeamStatus::IDLE;
        $team->save();
        
        return $this->view->render($response, 'team/manage/retire/unretire_success.twig', ['team' => $team]);
    }
}
