<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\TeamManager\Shared\StaffController;
use App\Constants\ColumnMaps;
use App\Helpers\TeamHelper;
use App\Models\Team;

use Slim\Views\Twig;

/**
 * Hiring and Firing of Side-Staff and Players
 */
class HireTeamController extends StaffController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
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

        $sideStaff = TeamHelper::getSideStaffOptions($team->race);

        return $this->view->render($response, 'team/manage/hire_staff.twig', [
            'team' => $team,
            'side_staff' => $this->addExistingCountToSideStaff($team, $sideStaff),
            'positions' => TeamHelper::hydrateRacePositionals($team->race)
        ]);
    }

    public function save(Request $request, Response $response, array $args): Response
    {
        [$team, $errorResponse] = $this->getAuthorizedTeamOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();

        $team->treasury = $team->treasury - ($team->current_team_value - (int) $data['current_team_value']);
        $team->current_team_value = $data['current_team_value'];

        $sideStaff= json_decode($data['team_staff'] ?? '{}', true);
        $team = $this->getSideStaff($team, $sideStaff);
       
        $teamPositions = json_decode($data['team_positions'] ?? '[]', true);
        $team = $this->getPlayers($team, $teamPositions);

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
