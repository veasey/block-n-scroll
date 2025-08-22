<?php
namespace App\Controllers\Leagues;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\Leagues\Shared\AccessController;
use App\Enums\TeamStatus;
use App\Enums\TeamLeagueRequestStatus;
use App\Helpers\PaginationHelper;
use App\Helpers\UserHelper;
use App\Models\TeamLeagueRequest;
use App\Models\Team;
use Slim\Views\Twig;

class RegistrationController extends AccessController
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

    public function getEnterTeamForm(Request $request, Response $response, array $args): Response
    {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $teams = $this->userHelper->getCurrentUser()->teams
            ->where('league_id', null)
            ->where('status', '!=', TeamStatus::RETIRED)
            ->filter(function($team) {
                // If the team has any pending league requests, skip it
                return $team->leagueRequests()
                    ->where('status', 'pending')
                    ->count() === 0;
            });

        if ($teams->isEmpty()) {
            // No eligible teams
            return $this->view->render($response, 'leagues/request_no_eligible_teams.twig', ['league' => $league]);
        }

        return $this->view->render($response, 'leagues/request.twig', [
            'league' => $league,
            'coach' => $this->userHelper->getCurrentUser(),
            'teams' => $teams
        ]);
    }

    public function submitEnterTeamForm(Request $request, Response $response, array $args): Response
    {
        [$league, $errorResponse] = $this->doesLeagueExist($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $teamLeagueRequest = new TeamLeagueRequest();
        $teamLeagueRequest->league_id = $league->id;
        $teamLeagueRequest->team_id = $request->getParsedBody()['team_id'] ?? null;
        $teamLeagueRequest->status = TeamLeagueRequestStatus::PENDING;
        $teamLeagueRequest->save();

        return $this->view->render($response, 'leagues/request_success.twig', [
            'league' => $league,
            'teams' => Team::find($teamLeagueRequest->team_id)
        ]);
    }
}
