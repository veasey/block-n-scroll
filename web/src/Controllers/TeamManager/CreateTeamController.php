<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Controllers\TeamManager\Shared\StaffController;
use App\Enums\TeamStatus;
use App\Helpers\UserHelper;
use App\Helpers\TeamHelper;
use App\Models\Base\BaseTeam;
use App\Models\Team;
use Slim\Views\Twig;

class CreateTeamController extends StaffController
{
    protected $userHelper;
    protected $teamHelper;

    protected $view;

    public function __construct(
        UserHelper $userHelper,
        TeamHelper $teamHelper,
        Twig $view
    )
    {
        $this->userHelper = $userHelper;
        $this->teamHelper = $teamHelper;
        $this->view = $view;
    }

    public function getFormSelectRace(Request $request, Response $response, array $args): Response
    {
        // if user has too many teams
        $max = 50;
        if (Team::where('coach_id', $this->userHelper->getCurrentUser()->id)->count() >= $max) {
            return $this->view->render($response, 'team/create/too_many_teams.twig', ['max' => $max]);
        }

        return $this->view->render($response, 'team/create/select_race.twig', ['teams' => BaseTeam::all()]);
    }

    public function getFormHireStaff(Request $request, Response $response, array $args): Response
    {
        $baseTeam = BaseTeam::find($args['team_id']);

        if (!$baseTeam || $baseTeam->is_hidden) {
            return $response->withStatus(404)->write('Team not found');
        }

        // Here is where you can add your data presentation logic
        $data = [
            'base_team' => $baseTeam,
            'special_rules' => $baseTeam->special_rules,
            'regional_rules' => $baseTeam->regional_rules,
            'apothecary_allowed' => $baseTeam->apothecary_allowed,
            'side_staff' => $this->teamHelper->getSideStaffOptions($baseTeam),
            'positions' => $this->teamHelper->hydrateRacePositionals($baseTeam)
        ];

        return $this->view->render($response, 'team/create/hire_staff.twig', $data);
    }


    public function save(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();
        $user = $this->userHelper->getCurrentUser();

        $newTeam = new Team();
        $newTeam->status = TeamStatus::FRESH->value;
        $newTeam->name = $data['team_name'] ?? '';
        $newTeam->description = $data['team_bio'] ?? '';
        $newTeam->coach_id = $user->id;
        $newTeam->base_team_id = $data['base_team_id'] ?? null;
        $newTeam->current_team_value = $data['current_team_value'];
        $newTeam->treasury = $data['max_cost'] - $data['current_team_value'];

        $sideStaff = json_decode($data['team_staff'] ?? '{}', true);
        $newTeam = $this->getSideStaff($newTeam, $sideStaff);
        
        if(!$newTeam->save()) {

            // For now, just redirect back to the team creation page
            return $response->withHeader('Location', '/team/create')->withStatus(302);
        }

        // save and add players
        $teamPositions = json_decode($data['team_positions'] ?? '[]', true);
        $newTeam = $this->addNewPlayersToTeam($newTeam, $teamPositions);

        // Redirect to list or detail view
        return $response
            ->withHeader('Location', '/team/view/' . $newTeam->id)
            ->withStatus(302);        
    }
}
