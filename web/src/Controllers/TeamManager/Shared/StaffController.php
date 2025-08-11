<?php
namespace App\Controllers\TeamManager\Shared;

use App\Controllers\TeamManager\Shared\AccessController;
use App\Constants\ColumnMaps;
use App\Enums\SideStaff;
use App\Enums\TeamStatus;
use App\Helpers\UserHelper;
use App\Models\Base\BaseTeamPlayer;
use App\Models\DefaultPlayerName;
use App\Models\Player;
use App\Models\Base\SideStaff as SideStaffModel;
use App\Models\Team;

/**
 * Common Functions for Hiring and Firing of Side-Staff and Players
 */
class StaffController extends AccessController
{
    protected $userHelper;

    public function __construct(
        UserHelper $userHelper
    ) {
        $this->userHelper = $userHelper;
    }

    protected function getSideStaff(Team $team, array $data): Team
    {
        foreach($data as $row) {
            $sideStaffId = SideStaff::tryFrom($row['id']);
            $sideStaff = SideStaffModel::find($sideStaffId);
            $columnName = ColumnMaps::SIDESTAFF_DB[$sideStaff->name];

            $difference = $row['count'] - $team->$columnName;
            $team->$columnName = $row['count'];           

            if (TeamStatus::tryFrom($team->status) === TeamStatus::FRESH && $difference < 0) {
                // Refund when reducing staff on a fresh team
                $team->treasury += abs($difference) * $sideStaff->cost;
            } elseif ($difference > 0) {
                // Cost for adding staff
                $team->treasury -= $difference * $sideStaff->cost;
            }          
        }

        return $team;
    }

    protected function addNewPlayersToTeam(Team $team, array $teamPositions): Team
    {
        $totalCost = 0;

        // Get existing player numbers for the team
        $existingNumbers = $team->players->pluck('number')->toArray();
        $nextNumber = 1;

        foreach ($teamPositions ?? [] as $positionId) {
            $baseTeamPlayer = BaseTeamPlayer::find($positionId);
            if (!$baseTeamPlayer) {
                continue; // Skip if the base team player does not exist
            }

            // Find the next available player number
            while (in_array($nextNumber, $existingNumbers)) {
                $nextNumber++;
            }

            $player = new Player();
            $player->team_id = (int) $team->id;
            $player->base_team_id = (int) $baseTeamPlayer->base_team_id;
            $player->base_team_player_id = (int) $positionId;
            $player->cost = (int) $baseTeamPlayer->cost;

            $player->number = $nextNumber;
            $existingNumbers[] = $nextNumber; // Mark this number as used

            // fill in default names
            $player->name = DefaultPlayerName::getRandomFor($baseTeamPlayer->base_team_id, $baseTeamPlayer->name);

            $player->ma = (int) $baseTeamPlayer->ma;
            $player->st = (int) $baseTeamPlayer->st;
            $player->ag = (int) $baseTeamPlayer->ag;
            $player->av = (int) $baseTeamPlayer->av;
            $player->pa = (int) $baseTeamPlayer->pa;

            $player->original_coach_id = (int) $this->userHelper->getCurrentUser()->id ?? 0;

            $player->save();

            $totalCost += $baseTeamPlayer->cost;
            
            $nextNumber++;
        }

        $team->treasury -= $totalCost;

        return $team;
    }
}