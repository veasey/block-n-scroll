<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\Players\Shared\AccessController;
use Slim\Views\Twig;

class ViewController extends AccessController
{
    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function view(Request $request, Response $response, array $args): Response
    {
        [$player, $errorResponse] = $this->getRecognisedPlayerOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        if ($args['format'] === 'json') {
            $response->getBody()->write($player->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }

        return $this->view->render($response, 'player/view.twig', [
            'player' => $player,
            'canManagePlayer' => $this->isAuthorizeToManagePlayer($player)
        ]);
    }
}
