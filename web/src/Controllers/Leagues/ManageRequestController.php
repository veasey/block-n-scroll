<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Enums\TeamLeagueRequestStatus;
use App\Controllers\Leagues\Shared\AccessController;
use App\Helpers\UserHelper;
use App\Repositories\TeamLeagueRequestRepository;
use App\Repositories\TeamRepository;
use App\Services\EventLogging\LeagueManagementEventLoggingService;
use Slim\Views\Twig;

class ManageRequestController extends AccessController
{
    protected $teamLeagueRequestRepository;
    protected $eventLogger;
    protected $view;
    protected $userHelper;

    public function __construct(
        TeamLeagueRequestRepository $teamLeagueRequestRepository,
        UserHelper $userHelper,
        LeagueManagementEventLoggingService $eventLogger,
        Twig $view
    ) {
        $this->teamLeagueRequestRepository = $teamLeagueRequestRepository;
        $this->userHelper = $userHelper;
        $this->eventLogger = $eventLogger;
        $this->view = $view;
    }

    protected function handleRequest(
        Request $request,
        Response $response,
        array $args,
        TeamLeagueRequestStatus $newStatus,
        callable $logCallback
    ): Response {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        if (!$this->isAuthorizeToManageLeague($league)) {
            $response->getBody()->write('Unauthorized');
            return $response->withStatus(403);
        }

        $requestId = (int) $args['request_id'];
        $teamLeagueRequest = $this->teamLeagueRequestRepository->findById($requestId);

        if (!$teamLeagueRequest || $teamLeagueRequest->league_id !== $league->id) {
            $response->getBody()->write('Request not found.');
            return $response->withStatus(404);
        }

        if (TeamLeagueRequestStatus::tryFrom($teamLeagueRequest->status) !== TeamLeagueRequestStatus::PENDING) {
            $response->getBody()->write('Request is not pending.');
            return $response->withStatus(400);
        }

        // Perform status change
        if ($newStatus === TeamLeagueRequestStatus::APPROVED) {
            $team = $teamLeagueRequest->team;
            $team->league_id = $league->id;
            $team->save();
        }

        $teamLeagueRequest->status = $newStatus;
        $teamLeagueRequest->save();

        // Log the event
        $logCallback($teamLeagueRequest);

        // Redirect back to manage page
        return $response
            ->withHeader('Location', "/league/manage/{$league->id}")
            ->withStatus(302);
    }

    public function approveRequest(Request $request, Response $response, array $args): Response
    {
        return $this->handleRequest(
            $request,
            $response,
            $args,
            TeamLeagueRequestStatus::APPROVED,
            fn($req) => $this->eventLogger->logApproveRequest($req)
        );
    }

    public function rejectRequest(Request $request, Response $response, array $args): Response
    {
        return $this->handleRequest(
            $request,
            $response,
            $args,
            TeamLeagueRequestStatus::REJECTED,
            fn($req) => $this->eventLogger->logRejectRequest($req)
        );
    }
}
