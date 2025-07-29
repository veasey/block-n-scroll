<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\Players\Shared\AccessController;
use App\Enums\LogType;
use App\Models\EventLog;
use App\Models\Player;
use Slim\Views\Twig;

class ViewLogController extends AccessController
{
    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    private function getPaginationParams(int $perPage = 50): array {
        $page = isset($_GET['page']) ? max((int)$_GET['page'], 1) : 1;
        $offset = ($page - 1) * $perPage;
        return [
            'page' => $page,
            'perPage' => $perPage,
            'offset' => $offset,
        ];
    }

    public function viewInjuries(Request $request, Response $response, array $args): Response
    {
        // get Player
        $playerId = $args['player_id'];
        $player = Player::find($playerId);
        if (!$player) {
            $response->withStatus(400)->write('Player not found');
        }

        // get logs
        $params = $this->getPaginationParams();
        $logs = EventLog::where('event_type', LogType::PLAYER_INJURED->value)
            ->where('player_id', $playerId)
            ->skip($params['offset']) // offset
            ->take($params['perPage']) // limit
            ->get();

        // get totals for pagination
        $total = EventLog::where('event_type', LogType::PLAYER_INJURED->value)
            ->where('player_id', $playerId)
            ->count();
        $totalPages = ceil($total / $params['perPage']);

        // return as JSON 
        $format = $args['format'] ?? 'html';
        if ($format === 'json') {
            $response->getBody()->write($logs->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }       

        return $this->view->render($response, 'player/log/injuries.twig', [
            'player' => $player,
            'logs' => $logs,
            'page' => $params['page'],
            'totalPages' => $totalPages
        ]);
    }
}
