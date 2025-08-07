<?php
namespace App\Helpers;

use Illuminate\Support\Collection;

use App\Constants\ColumnMaps;
use App\Constants\RaceSpecialRules;
use App\Enums\SideStaff;
use App\Enums\TeamStatus;
use App\Models\Base\BaseTeam as Race;
use App\Models\Base\BaseTeamPlayer as RacePositional;
use App\Models\Team;
use App\Models\Base\SideStaff as SideStaffModel;
use App\Models\Coach;
use Exception;

class TeamHelper
{
    /**
     * return current logged in user
     * @throws \Exception
     * @return mixed
     */
    public static function getCurrentPlayingTeam()
    {
        if (!isset($_SESSION['user']) || !isset($_SESSION['user']['id'])) {
            return null;
        }

        $user = Coach::find($_SESSION['user']['id']);
        
        $team = TEAM::where('coach_id', $user->id)
                    ->where('status', TeamStatus::PLAYING)
                    ->orderBy('updated_at', 'desc')
                    ->first();

        if (!$team) {
            throw new Exception("Team not found.");
        }

        return $team;
    }

    public static function hydrateRacePositionals(Race $race): Collection
    {    
        return $race->players->map(function ($player) {
            return [
                'player' => $player,
                'primary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->primarySkill()->get()),
                'secondary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->secondarySkill()->get()),
            ];
        });
    }

    public static function getSideStaffOptions(Race $race): array
    {
        // Fetch side staff options from the database or configuration
        $sideStaff = SideStaffModel::all();

        return $sideStaff->map(function ($staff) use ($race) {

            // alter cost and max rerolls allowed
            if ($staff->id === SideStaff::REROLL) {
                $staff->cost = $baseTeam->reroll_cost ?? 70000;
                $staff->max_count = $baseTeam->max_rerolls ?? 8; 
            }

            // disable apothecary if not allowed for this team
            if ($staff->id === SideStaff::APOTHECARY && !$race->apothecary_allowed) {
                return null; // Skip this staff if not allowed
            }

            return [
                'id' => $staff->id,
                'name' => $staff->name,
                'type' => $staff->type,
                'cost' => $staff->cost,
                'max' => $staff->max_count,
            ];

        })->toArray();
    }

    public static function calculateCurrentTeamValue(Team $team ): int
    {
        $currentTeamValue = 0;
        foreach($team->players as $player) {
            $currentTeamValue += $player->cost;
        }

        foreach(SideStaffModel::all() as $sideStaff) {
            $columnName = ColumnMaps::SIDESTAFF_DB[$sideStaff->name];
            $currentTeamValue += $sideStaff->cost * $team->$columnName;
        }

        return $currentTeamValue;
    }

    public static function isLowCostLineman(RacePositional $racePositional, Race $race): bool
    {
        $isLineman = str_contains(strtolower($racePositional->name), 'lineman');

        $hasLowCostLinemanRule = $race->special_rules->contains(function ($rule) {
            return $rule->id === RaceSpecialRules::LOW_COST_LINEMEN;
        });

        return $isLineman && $hasLowCostLinemanRule;
    }
}
