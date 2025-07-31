<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Enums\SideStaff;
use App\Helpers\UserHelper;
use App\Helpers\SkillFormatter;
use App\Helpers\SideStaffPruner;
use App\Models\Base\BaseTeam;
use App\Models\Base\BaseTeamPlayer;
use App\Models\DefaultPlayerName;
use App\Models\Team;
use App\Models\Player;
use Slim\Views\Twig;

class CreateTeamController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getFormSelectRace(Request $request, Response $response, array $args): Response
    {
        // if user has too many teams
        $max = 50;
        if (Team::where('coach_id', UserHelper::getCurrentUser()->id)->count() >= $max) {
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
            // Fetch side staff options
            'side_staff' => SideStaffPruner::getSideStaffOptions($baseTeam),

            // pre-format primary and secondary skills for all players
            'positions' => $baseTeam->players->map(function ($player) {
                return [
                    'player' => $player,
                    'primary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->primarySkill()->get()),
                    'secondary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->secondarySkill()->get()),
                ];
            }),
        ];

        return $this->view->render($response, 'team/create/hire_staff.twig', $data);
    }

    private function getSideStaff(Team $team, array $data): Team
    {
        $defaults = [
            'rerolls' => SideStaff::REROLL->value,
            'apothecary' => SideStaff::APOTHECARY->value,
            'assistant_coaches' => SideStaff::ASSISTANT_COACH->value,
            'cheerleaders' => SideStaff::CHEERLEADER->value,
            'fan_factor' => SideStaff::DEDICATED_FANS->value,
        ];

        foreach ($defaults as $property => $key) {
            $team->$property = isset($data[$key]) ? (int) $data[$key] : 0;
        }

        return $team;
    }


    private function getPlayers(Team $team, array $teamPositions): Team
    {
        // Loop through player data and create Player models
        foreach ($teamPositions ?? [] as $index => $positionId) {

            $baseTeamPlayer = BaseTeamPlayer::find($positionId);
            if (!$baseTeamPlayer) {
                continue; // Skip if the base team player does not exist
            }

            $player = new Player();
            $player->team_id = (int) $team->id;
            $player->base_team_id = (int) $baseTeamPlayer->base_team_id;
            $player->base_team_player_id = (int) $positionId;
            $player->cost = (int) $baseTeamPlayer->cost;

            $player->number = $index + 1;

            // fill in default names
            $player->name = DefaultPlayerName::getRandomFor($baseTeamPlayer->base_team_id, $baseTeamPlayer->name);

            $player->ma = (int) $baseTeamPlayer->ma;
            $player->st = (int) $baseTeamPlayer->st;
            $player->ag = (int) $baseTeamPlayer->ag;
            $player->av = (int) $baseTeamPlayer->av;
            $player->pa = (int) $baseTeamPlayer->pa;

            $player->original_coach_id = (int) $_SESSION['user']['id'] ?? 0; // Set original coach ID

            $player->save();
        }

        return $team;
    }

    public function save(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();
        $user = UserHelper::getCurrentUser();

        $newTeam = new Team();
        $newTeam->name = $data['team_name'] ?? '';
        $newTeam->description = $data['team_bio'] ?? '';
        $newTeam->coach_id = $user->id;
        $newTeam->base_team_id = $data['base_team_id'] ?? null;
        $newTeam->treasury = $data['max_cost'] - $data['current_team_value'];

        $sideStaff= json_decode($data['team_staff'] ?? '{}', true);
        $newTeam = $this->getSideStaff($newTeam, $sideStaff);
        
        if(!$newTeam->save()) {

            // For now, just redirect back to the team creation page
            return $response->withHeader('Location', '/team/create')->withStatus(302);
        }

        // save and add players
        $teamPositions = json_decode($data['team_positions'] ?? '[]', true);
        $newTeam = $this->getPlayers($newTeam, $teamPositions);

        // Redirect to list or detail view
        return $response
            ->withHeader('Location', '/team/view/' . $newTeam->id)
            ->withStatus(302);        
    }
}
