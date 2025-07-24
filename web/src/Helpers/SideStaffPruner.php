<?php
namespace App\Helpers;

use App\Models\Base\BaseTeam;
use App\Models\Base\SideStaff;

class SideStaffPruner
{
    
    private CONST SIDESTAFF_RE_ROLLS = 1;
    private CONST SIDESTAFF_APOTHECARY = 2;

    /**
     * 
     * @param BaseTeam $baseTeam
     * @return array
     */
    public static function getSideStaffOptions(BaseTeam $baseTeam): array
    {
        // Fetch side staff options from the database or configuration
        $sideStaff = SideStaff::all();

        return $sideStaff->map(function ($staff) use ($baseTeam) {

            // alter cost and max rerolls allowed
            if ($staff->id === self::SIDESTAFF_RE_ROLLS) {
                $staff->cost = $baseTeam->reroll_cost ?? 70000;
                $staff->max = $baseTeam->max_rerolls ?? 8; 
            }

            // disable apothecary if not allowed for this team
            if ($staff->id === self::SIDESTAFF_APOTHECARY && !$baseTeam->apothecary_allowed) {
                return null; // Skip this staff if not allowed
            }

            return [
                'id' => $staff->id,
                'name' => $staff->name,
                'type' => $staff->type,
                'cost' => $staff->cost,
                'max' => $staff->max,
            ];

        })->toArray();
    }
}
