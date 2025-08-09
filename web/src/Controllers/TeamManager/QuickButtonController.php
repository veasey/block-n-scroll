<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\Shared\AccessController;
use App\Enums\Match\EventType;
use App\Enums\Player\PlayerStatus;
use App\Helpers\MatchHelper;
use Slim\Views\Twig;

class QuickButtonController extends AccessController
{
    protected $view;
    protected $matchHelper;

    public function __construct(
        Twig $view,
        MatchHelper $matchHelper
    )
    {
        $this->view = $view;
        $this->matchHelper = $matchHelper;
    }

    private function authorizeAndValidate(Request $request, Response $response, array $args): array
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) {
            return [null, $errorResponse];
        }

        $eventType = $args['event_type'] ?? null;
        $eventEnum = EventType::tryFrom($eventType);
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
            'players' => $players,
            'match' => $this->matchHelper->getCurrentMatchTeamPlayingIn($team)
        ]);
    }
}
