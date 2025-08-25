<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Leagues\Shared\AccessController;
use App\Helpers\PaginationHelper;
use App\Helpers\UserHelper;
use App\Models\Coach;
use App\Models\League;
use Slim\Views\Twig;

class ViewController extends AccessController
{
    protected $paginationHelper;
    protected $view;

    public function __construct(
        PaginationHelper $paginationHelper,
        UserHelper $userHelper,
        Twig $view
    ) {
        $this->paginationHelper = $paginationHelper;
        $this->userHelper = $userHelper;
        $this->view = $view;
    }

    /**
     * Shared paginator/renderer for leagues.
     */
    private function renderLeagueList(Response $response, array $args, $baseQuery, ?Coach $coach): Response
    {
        $format = $args['format'] ?? 'html';
        $params = $this->paginationHelper->getPaginationParams();

        $total = $baseQuery->count();
        $totalPages = ceil($total / $params['perPage']);

        $leagues = $baseQuery
            ->orderBy('created_at', 'desc')
            ->skip($params['offset']) // offset
            ->take($params['perPage']) // limit
            ->get();

        if ($format === 'json') {
            $response->getBody()->write($leagues->toJson());
            return $response->withHeader('Content-Type', 'application/json');
        }

        return $this->view->render($response, 'leagues/list.twig', [
            'leagues' => $leagues,
            'page' => $params['page'],
            'totalPages' => $totalPages,
            'isAuthorizeToCreateLeagues' => $this->isAuthorizeToCreateLeagues(),
            'coach' => $coach
        ]);
    }

    public function list(Request $request, Response $response, array $args): Response
    {
        $query = League::query();
        return $this->renderLeagueList($response, $args, $query, null);
    }

    public function listManaged(Request $request, Response $response, array $args): Response
    {
        $coachId = $args['user_id'];
        if (!$coach = Coach::find($coachId)) {
            $response->getBody()->write("Coach ID does not exist.");
            return $response->withStatus(404);
        }
        
        $query = $coach->moderatedLeagues();
        return $this->renderLeagueList($response, $args, $query, $coach);
    }

    public function listPlaying(Request $request, Response $response, array $args): Response
    {
        $coachId = $args['user_id'];
        if (!$coach = Coach::find($coachId)) {
            $response->getBody()->write("Coach ID does not exist.");
            return $response->withStatus(404);
        }
        
        $query = $coach->playingLeagues();
        return $this->renderLeagueList($response, $args, $query, $coach);
    }

    public function view(Request $request, Response $response, array $args): Response
    {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        return $this->view->render($response, 'leagues/view.twig', [
            'league' => $league,
            'coach' => $this->userHelper->getCurrentUser(),
            'isAuthorizeToManageLeague' => $this->isAuthorizeToManageLeague($league)
        ]);
    }
}
