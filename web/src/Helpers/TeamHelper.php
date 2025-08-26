<?php
namespace App\Helpers;

use Illuminate\Support\Collection;

use App\Constants\ColumnMaps;
use App\Constants\RaceSpecialRules;
use App\Enums\SideStaff;
use App\Enums\TeamStatus;
use App\Models\Base\BaseTeam as Race;
use App\Models\Base\BaseTeamPlayer as RacePositional;
use App\Helpers\SkillHelper;
use App\Helpers\UserHelper;
use App\Models\Team;
use App\Models\Base\SideStaff as SideStaffModel;
use App\Models\Coach;
use Exception;

class TeamHelper
{
    protected $skillHelper;
    protected $userHelper;

    public function __construct(
        SkillHelper $skillHelper,
        UserHelper $userHelper
    ) {
        $this->skillHelper = $skillHelper;
        $this->userHelper = $userHelper;
    }

    /**
     * return current logged in user
     * @throws \Exception
     * @return mixed
     */
    public function getCurrentPlayingTeam()
    {
        $user = $this->userHelper->getCurrentUser();
        if (!$user) {
            throw new Exception("User not logged in.");
        }
        
        $team = TEAM::where('coach_id', $user->id)
                    ->where('status', TeamStatus::PLAYING)
                    ->orderBy('updated_at', 'desc')
                    ->first();

        if (!$team) {
            throw new Exception("Team not found.");
        }

        return $team;
    }

    public function hydrateRacePositionals(Race $race): Collection
    {    
        return $race->players->map(function ($player) {
            return [
                'player' => $player,
                'primary_skill_initials' => $this->skillHelper->formatSkillCategoryInitials($player->primarySkill()->get()),
                'secondary_skill_initials' => $this->skillHelper->formatSkillCategoryInitials($player->secondarySkill()->get()),
            ];
        });
    }

    public function getSideStaffOptions(Race $race): array
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

    public function calculateCurrentTeamValue(Team $team ): int
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

    public function isLowCostLineman(RacePositional $racePositional, Race $race): bool
    {
        $isLineman = str_contains(strtolower($racePositional->name), 'lineman');

        $hasLowCostLinemanRule = $race->special_rules->contains(function ($rule) {
            return $rule->id === RaceSpecialRules::LOW_COST_LINEMEN;
        });

        return $isLineman && $hasLowCostLinemanRule;
    }
}
