<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\Shared\AccessController;
use App\Enums\MatchEventType;
use App\Enums\Player\PlayerStatus;
use Slim\Views\Twig;

class QuickButtonController extends AccessController
{
    protected $view;

    public function __construct(
        Twig $view,
    )
    {
        $this->view = $view;
    }

    private function authorizeAndValidate(Request $request, Response $response, array $args): array
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        $eventType = $args['event_type'] ?? null;
        $eventEnum = MatchEventType::tryFrom($eventType);
        if (!$eventEnum) {
            $response->getBody()->write('Invalid event type');
            return [null, null, $response->withStatus(404)];
        }

        return [$team, $eventEnum, null];
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        [$team, $eventEnum, $errorResponse] = $this->authorizeAndValidate($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        // eligable players
        $players = $team->players()
            ->where('dead', false)
            ->where('miss_next_game', false)
            ->where('status', PlayerStatus::ACTIVE)
            ->get();

        $eventType = $eventEnum->value;
        return $this->view->render($response, "team/quick_button/{$eventType}_form.twig", [
            'team' => $team, 
            'players' => $players
        ]);
    }
}
