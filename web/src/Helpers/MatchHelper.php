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

    // Is team currently playing in match?
    public function isParticipant(?Team $team, ?MatchGame $match) 
    {
        if (!$team || !$match) {
            return false;
        }

        if ($match->homeTeam && $match->homeTeam->id === $team->id) {
            return true;
        }

        if ($match->awayTeam && $match->awayTeam->id === $team->id) {
            return true;
        }

        return false;
    }
}
