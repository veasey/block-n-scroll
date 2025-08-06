<?php
namespace App\Repositories;

use App\Enums\Match\Status as MatchStatus;
use App\Enums\TeamStatus;
use App\Models\Team;
use App\Models\MatchGame;

class MatchGameRepository
{
    /**
     * Find away game already setup
     */
    public function getExistingMatch(Team $team, ?Team $opponent): mixed
    {
        $existingMatch = MatchGame::where('away_team_id', $team->id)
            ->whereHas('homeTeam', function ($query) {
                $query->where('status', 'playing');
            });

        if ($opponent) {
            $existingMatch->where('home_team_id', $opponent->id);
        }
            
        return $existingMatch->where('home_score', 0)
            ->where('away_score', 0)
            ->where('status', '!=', MatchStatus::FINSIHED)
            ->orderBy('updated_at', 'desc')
            ->first();
    }

    /**
     * get team's current match
     * @param int
     * @return mixed
     */
    public function getTeamCurrentMatch(int $teamId): mixed
    {
        $team = Team::find($teamId);

        if (!$team) {
            return false;
        }

        $teamStatus = TeamStatus::tryFrom($team->status);
        if ($teamStatus != TeamStatus::PLAYING &&
            $teamStatus != TeamStatus::POST_SEQUENCE) {
            return false;
        }

        return MatchGame::where('home_team_id', $team->id)
            ->orWhere('away_team_id', $team->id)
            ->where('status', '!=', MatchStatus::FINSIHED)
            ->orderByDesc('updated_at', 'desc')
            ->first();
    }
}