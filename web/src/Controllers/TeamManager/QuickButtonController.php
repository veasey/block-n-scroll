<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\Shared\AccessController;
use App\Enums\EventType;
use Slim\Views\Twig;

class QuickButtonController extends AccessController
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

        $eventType = $args['event_type'];

        if (!EventType::tryFrom($eventType)) {
             return [null, $response->withStatus(404)->write('Invalid Event Type')];
        }

        return $this->view->render($response, "team/quick_button/$eventType.twig", ['team' => $team]);
    }
}
