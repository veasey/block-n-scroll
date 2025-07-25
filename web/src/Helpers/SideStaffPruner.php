<?php
namespace App\Helpers;

use App\Models\Base\BaseTeam;
use App\Models\Base\SideStaff as SideStaffModel;
use App\Enums\SideStaff;

class SideStaffPruner
{
    /**
     * 
     * @param BaseTeam $baseTeam
     * @return array
     */
    public static function getSideStaffOptions(BaseTeam $baseTeam): array
    {
        // Fetch side staff options from the database or configuration
        $sideStaff = SideStaffModel::all();

        return $sideStaff->map(function ($staff) use ($baseTeam) {

            // alter cost and max rerolls allowed
            if ($staff->id === SideStaff::REROLL) {
                $staff->cost = $baseTeam->reroll_cost ?? 70000;
                $staff->max_count = $baseTeam->max_rerolls ?? 8; 
            }

            // disable apothecary if not allowed for this team
            if ($staff->id === SideStaff::APOTHECARY && !$baseTeam->apothecary_allowed) {
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
}
