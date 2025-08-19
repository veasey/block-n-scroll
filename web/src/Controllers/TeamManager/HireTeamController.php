<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\TeamManager\Shared\StaffController;
use App\Constants\ColumnMaps;
use App\Helpers\UserHelper;
use App\Helpers\TeamHelper;
use App\Models\Team;

use Slim\Views\Twig;

/**
 * Hiring and Firing of Side-Staff and Players
 */
class HireTeamController extends StaffController
{

    protected $view;
    protected $teamHelper;

    public function __construct(
        Twig $view,
        UserHelper $userHelper,
        TeamHelper $teamHelper
    )
    {
        $this->view = $view;
        $this->userHelper = $userHelper;
        $this->teamHelper = $teamHelper;
    }

    /**
     * Add existing number of bought sidestaff to side staff list
     * @param \App\Models\Team $team
     * @param array $sideStaff
     * @return array
     */
    private function addExistingCountToSideStaff(Team $team, array $sideStaff): Array
    {
        $hydratedSideStaffList = [];

        foreach($sideStaff as $staff) {
            $columnName = ColumnMaps::SIDESTAFF_DB[$staff['name']];
            $staff['existing_count'] = $team->$columnName;
            $hydratedSideStaffList[] = $staff;
        }

        return $hydratedSideStaffList;
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;

        $sideStaff = $this->teamHelper->getSideStaffOptions($team->race);

        return $this->view->render($response, 'team/manage/hire_staff.twig', [
            'team' => $team,
            'side_staff' => $this->addExistingCountToSideStaff($team, $sideStaff),
            'positions' => $this->teamHelper->hydrateRacePositionals($team->race)
        ]);
    }

    public function save(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();

        $sideStaffData = json_decode($data['team_staff'] ?? '{}', true);
        $team = $this->getSideStaff($team, $sideStaffData);
       
        $teamPositions = json_decode($data['team_positions'] ?? '[]', true);
        $team = $this->addNewPlayersToTeam($team, $teamPositions);

        $team->current_team_value = $this->teamHelper->calculateCurrentTeamValue($team);

        if(!$team->save()) {
            $response->getBody()->write('Unable to save team');
            return $response->withStatus(500);
        }

        // Redirect to list or detail view
        return $response
            ->withHeader('Location', '/team/view/' . $team->id)
            ->withStatus(302);        
    }
}
