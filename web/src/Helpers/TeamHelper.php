<?php
namespace App\Helpers;
use App\Enums\TeamStatus;
use App\Models\Team;
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
}
