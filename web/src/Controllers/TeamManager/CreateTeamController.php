<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Enums\SideStaff;
use App\Helpers\SkillFormatter;
use App\Helpers\SideStaffPruner;
use App\Models\Base\BaseTeam;
use App\Models\DefaultPlayerName;
use App\Models\Team;
use App\Models\Player;
use App\Models\Base\BaseTeamPlayer;
use Slim\Views\Twig;

class CreateTeamController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';

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

        return $this->view->render($response, 'team/create/2_buy_staff.twig', $data);
    }

    private function getSideStaff(Team $team, array $data): Team
    {
        // Initialize side staff properties
        $team->rerolls = 0;
        $team->apothecary = 0;
        $team->assistant_coaches = 0;
        $team->cheerleaders = 0;
        $team->fan_factor = 0;

        // Set side staff based on input data
        if (isset($data[SideStaff::REROLL])) {
            $team->rerolls = (int) $data['team_staff'][SideStaff::REROLL] ?? 0;
        }
        if (isset($data[SideStaff::APOTHECARY])) {
            $team->apothecary = (int) $data['team_staff'][SideStaff::APOTHECARY] ?? 0;
        }
        if (isset($data[SideStaff::ASSISTANT_COACH])) {
            $team->assistant_coaches = (int) $data['team_staff'][SideStaff::ASSISTANT_COACH] ?? 0;
        }
        if (isset($data[SideStaff::CHEERLEADER])) {
            $team->cheerleaders = (int) $data['team_staff'][SideStaff::CHEERLEADER] ?? 0;
        }
        if (isset($data[SideStaff::DEDICATED_FANS])) {
            $team->fan_factor = (int) $data['team_staff'][SideStaff::DEDICATED_FANS] ?? 0;
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

            $player->number = $index + 1;

            // fill in default names
            $player->name = DefaultPlayerName::getRandomFor($baseTeamPlayer->base_team_id, $baseTeamPlayer->name);

            $player->ma = (int) $baseTeamPlayer->ma;
            $player->st = (int) $baseTeamPlayer->st;
            $player->ag = (int) $baseTeamPlayer->ag;
            $player->av = (int) $baseTeamPlayer->av;

            $player->original_coach_id = (int) $_SESSION['user_id'] ?? 0; // Set original coach ID

            $player->save();
        }

        return $team;
    }

    public function saveTeam(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();

        $newTeam = new Team();

        $newTeam->name = $data['team_name'] ?? '';
        $newTeam->description = $data['team_description'] ?? '';
        $newTeam->coach_id = $_SESSION['user_id'] ?? null;
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
