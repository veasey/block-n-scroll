<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Leagues\Shared\AccessController;
use App\Helpers\PaginationHelper;
use App\Helpers\UserHelper;
use App\Repositories\TeamLeagueRequestRepository;
use Slim\Views\Twig;

class ManageController extends AccessController
{
    protected $teamLeagueRequestRepository;
    protected $paginationHelper;
    protected $view;

    public function __construct(
        TeamLeagueRequestRepository $teamLeagueRequestRepository,
        PaginationHelper $paginationHelper,
        UserHelper $userHelper,
        Twig $view
    ) {
        $this->teamLeagueRequestRepository = $teamLeagueRequestRepository;
        $this->paginationHelper = $paginationHelper;
        $this->userHelper = $userHelper;
        $this->view = $view;
    }

    public function view(Request $request, Response $response, array $args): Response
    {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        if (!$this->isAuthorizeToManageLeague($league)) {
            $response->getBody()->write('Unauthorized');
            return $response->withStatus(403);
        }

        $params = $this->paginationHelper->getPaginationParams();
        $totalCount = $this->teamLeagueRequestRepository->getNewRequestsTotalCount($league);
        $requests = $this->teamLeagueRequestRepository->getNewRequests($league, $params);
        $totalPages = ceil($totalCount / $params['perPage']);

        return $this->view->render($response, 'leagues/moderation/manage.twig', [
            'requests' => $requests,
            'totalPages' => $totalPages,
            'page' => $params['page'],
            'league' => $league
        ]);
    }

    public function submitSeason(Request $request, Response $response, array $args): Response
    {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        if (!$this->isAuthorizeToManageLeague($league)) {
            $response->getBody()->write('Unauthorized');
            return $response->withStatus(403);
        }

        $data = (array) $request->getParsedBody();
        $season = (int) $data['season'];

        if (empty($season)) {
            // No season provided
            $response->getBody()->write('Season is required.');
            return $response->withStatus(400);
        }

        $seasonChangeType = null;
        if ($league->season !== $season) {
            if ($season > $league->season) {
                $seasonChangeType = 'increment';
            } elseif ($season > ($league->season+1)) {
                $seasonChangeType = 'skip';
            } else {
                $seasonChangeType = 'decrement';
            }
        }

        // Update season
        $league->season = $season;
        $league->save();

        return $this->view->render($response, 'leagues/moderation/update_season_success.twig', [
            'seasonChangeType' => $seasonChangeType,
            'league' => $league
        ]);
    }
}
