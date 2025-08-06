<?php
namespace App\Helpers;
use App\Enums\Match\Status as MatchStatus;
use App\Models\Team;
use App\Models\MatchGame;

class MatchHelper
{
    public function getCurrentMatchTeamPlayingIn(Team $team): mixed
    {
        return MatchGame::where(function ($query) use ($team) {
                $query->where('home_team_id', $team->id)
                    ->orWhere('away_team_id', $team->id);
            })
            ->where('status', '!=', MatchStatus::FINISHED)
            ->orderByDesc('updated_at')
            ->first();
    }
}
