<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\TeamManager\Shared\StaffController;
use App\Constants\ColumnMaps;
use App\Enums\TeamStatus;
use App\Helpers\TeamHelper;
use App\Models\Team;
use App\Models\Base\SideStaff as SideStaffModel;

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

        $sideStaffData = json_decode($data['team_staff'] ?? '{}', true);
        $team = $this->getSideStaff($team, $sideStaffData);
       
        $teamPositions = json_decode($data['team_positions'] ?? '[]', true);
        $team = $this->addNewPlayersToTeam($team, $teamPositions);
 
        // Update sidestaff
        foreach (SideStaffModel::all() as $sideStaff) {
            $columnName = ColumnMaps::SIDESTAFF_DB[$sideStaff->name];
            $newValue = $sideStaffData[$sideStaff->name] ?? 0;
            $oldValue = (int) $team->{$columnName} ?? 0;

            $difference = $newValue - $oldValue;

            if (TeamStatus::tryFrom($team->status) === TeamStatus::FRESH && $difference < 0) {
                // Refund when reducing staff on a fresh team
                $team->treasury += abs($difference) * $sideStaff->cost;
            } elseif (TeamStatus::tryFrom($team->status) !== TeamStatus::FRESH) {
                if ($difference > 0) {
                    // Cost for adding staff
                    $team->treasury -= $difference * $sideStaff->cost;
                } elseif ($difference < 0) {
                    // Refund for reducing staff
                    $team->treasury += abs($difference) * $sideStaff->cost;
                }
            }

            $team->{$columnName} = $newValue;
        }


        $team->current_team_value = TeamHelper::calculateCurrentTeamValue($team);

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
