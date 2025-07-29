<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\TeamManager\Shared\AccessController;
use App\Models\Team;
use App\Services\EventLogger;
use App\Services\Event\InjuryService;
use App\Enums\EventType;
use App\Enums\CasualtyTable;
use App\Enums\LogType;
use Slim\Views\Twig;

class QuickButtonController extends AccessController
{
    protected $injuryService;
    protected $eventLogger;
    protected $view;

    public function __construct(
        InjuryService $injuryService,
        EventLogger $eventLogger,
        Twig $view,
    )
    {
        $this->injuryService = $injuryService;
        $this->eventLogger = $eventLogger;
        $this->view = $view;
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
            return [null, $response->withStatus(404)];
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
            ->get();

        $eventType = $eventEnum->value;
        return $this->view->render($response, "team/quick_button/{$eventType}_form.twig", [
            'team' => $team, 
            'players' => $players
        ]);
    }

    public function submit(Request $request, Response $response, array $args): Response
    {
        [$team, $eventEnum, $errorResponse] = $this->authorizeAndValidate($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $data = $request->getParsedBody();
        
        if ($eventEnum === EventType::INJURY) {
            return $this->submitInjuryResult($data, $team, $response);
        }

        $response->getBody()->write('Unknown Event Type');
        return $response->withStatus(404);
    }

    private function submitInjuryResult(array $data, Team $team, Response $response): Response
    {
        $roll = $data['injury_roll'] ?? null;
        $playerId = $data['player_id'] ?? null;

        if (!$roll) {
            $response->getBody()->write('Roll Required');
            return $response->withStatus(400);
        }

        if (!$playerId) {
            $response->getBody()->write('Player ID Required');
            return $response->withStatus(400);
        }

        // Find player in team by ID
        $player = $team->players->find($playerId);

        if (!$player) {
            $response->getBody()->write('Player does not exist');
            return $response->withStatus(404);
        }

        $injuryType = $this->injuryService->record($player, $roll);

        if ($injuryType == CasualtyTable::LASTING_INJURY) {
            return $this->view->render($response, "event/injury/injury_roll_form.twig", ['player' => $player]);
        }

        $this->eventLogger->log(
            LogType::PLAYER_INJURED->value,
            $injuryType->value,
            'Quick Button Entry',
            '',
            $player->team->coach,
            $player->team,
            $player,
            null
        );

        return $this->view->render($response, "event/injury/result.twig", [
            'player' => $player,
            'injury' => $injuryType
        ]);
    }
}
