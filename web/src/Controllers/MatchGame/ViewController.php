<?php
namespace App\Controllers\MatchGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Helpers\PaginationHelper;
use App\Helpers\MatchHelper;
use App\Helpers\TeamHelper;
use App\Helpers\UserHelper;

use App\Repositories\EventLogRepository;
use App\Models\MatchGame;
use App\Models\Team;

use Slim\Views\Twig;

class ViewController
{
    protected $paginationHelper;
    protected $matchHelper;
    protected $teamHelper;
    protected $userHelper;
    protected $logRepo;
    protected $view;

    public function __construct(
        PaginationHelper $paginationHelper,
        MatchHelper $matchHelper,
        TeamHelper $teamHelper,
        UserHelper $userHelper,
        EventLogRepository $logRepo,
        Twig $view)    
    {
        $this->paginationHelper = $paginationHelper;
        $this->matchHelper = $matchHelper;
        $this->teamHelper = $teamHelper;
        $this->userHelper = $userHelper;
        $this->logRepo = $logRepo;
        $this->view = $view;
    }

    public function view(Request $request, Response $response, array $args): mixed
    {
        $matchId = $args['match_id'] ?? '';
        $match = MatchGame::find($matchId);
        if (!$match) {
            $response->getBody()->write('Match not found');
            $response->withStatus(404);
        }

        $params = $this->paginationHelper->getPaginationParams();
        $logs = $this->logRepo->getMatchEventLogs($match);

        $logPage = $logs->slice($params['offset'], $params['perPage']);
        $totalPages = ceil($logs->count() / $params['perPage']);
        
        $data = [
            'match' => $match,
            'logs' => $logPage,
            'totalPage' => $totalPages,
            'isAdmin' => $this->userHelper->isCurrentUserAdmin()
        ];

        return $this->view->render($response, 'match/view.twig', $data);
    }

    public function listAll(Request $request, Response $response, array $args): mixed
    {
        $params = $this->paginationHelper->getPaginationParams();
        
        $totalCount = MatchGame::count();

        // Use query builder with offset and limit (skip and take)
        $matchPage = MatchGame::query()
            ->orderBy('created_at', 'desc')
            ->skip($params['offset'])
            ->take($params['perPage'])
            ->get();

        $totalPages = ceil($totalCount / $params['perPage']);

        return $this->view->render($response, 'match/list.twig', [
            'matches' => $matchPage,
            'totalPages' => $totalPages,
            'page' => $params['page'],
        ]);
    }

    public function listTeamMatches(Request $request, Response $response, array $args): mixed
    {
        $params = $this->paginationHelper->getPaginationParams();
        
        $teamId = $args['team_id'] ?? null;

        $totalCount = MatchGame::where('home_team_id', $teamId)
            ->orWhere('away_team_id', $teamId)
            ->count();

        $matches = MatchGame::where('home_team_id', $teamId)
            ->orWhere('away_team_id', $teamId)
            ->skip($params['offset'])
            ->take($params['perPage'])
            ->orderBy('created_at', 'desc')
            ->get();

        $totalPages = ceil($totalCount / $params['perPage']);

        return $this->view->render($response, 'match/list.twig', [
            'matches' => $matches,
            'totalPages' => $totalPages,
            'page' => $params['page'],
            'team' => Team::find($teamId)
        ]);
    }
}