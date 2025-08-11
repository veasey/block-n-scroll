<?php
namespace App\Controllers\Players;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Controllers\Players\Shared\AccessController;
use App\Enums\LogType;
use App\Helpers\PaginationHelper;
use App\Models\EventLog;
use App\Models\Player;
use Slim\Views\Twig;

class ViewLogController extends AccessController
{
    protected $paginationHelper;
    protected $view;

    public function __construct(PaginationHelper $paginationHelper, Twig $view)
    {
        $this->paginationHelper = $paginationHelper;
        $this->view = $view;
    }

    public function viewLog(Request $request, Response $response, array $args): Response
    {
        $logType = LogType::tryFrom(strtoupper($args['log_type']));
        if (!$logType) {
            $response->getBody()->write('Log Type "'. $args['log_type'] .'" Unavailable');
            return $response->withStatus(400);
        }

        // get Player
        $playerId = $args['player_id'];
        $player = Player::find($playerId);
        if (!$player) {
            $response->getBody()->write('Player not found');
            return $response->withStatus(400);
        }

        // get logs
        $params = $this->paginationHelper->getPaginationParams();
        $logs = EventLog::where('event_type', $logType->value)
            ->where('player_id', $playerId)
            ->orderBy('created_at', 'desc')
            ->skip($params['offset']) // offset
            ->take($params['perPage']) // limit
            ->get();

        // get totals for pagination
        $total = EventLog::where('event_type', $logType->value)
            ->where('player_id', $playerId)
            ->count();
        $totalPages = ceil($total / $params['perPage']);

        // return as JSON 
        $format = $args['format'] ?? 'html';
        if ($format === 'json') {
            $response->getBody()->write($logs->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }       

        return $this->view->render($response, 'player/view_logs.twig', [
            'player' => $player,
            'log_type' => $logType->value,
            'logs' => $logs,
            'page' => $params['page'],
            'totalPages' => $totalPages
        ]);
    }
}
