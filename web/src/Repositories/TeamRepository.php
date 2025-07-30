<?php
namespace App\Repositories;

use App\Enums\TeamStatus;
use App\Models\Team;

class TeamRepository
{
    /**
     * Get teams that are available to join a match
     * @param Team $team
     * @return mixed
     */
    public function getEligableTeams(Team $team): mixed     
    {
        return Team::where('id', '!=', $team->id)
            ->where(function ($q) use ($team) {
                $q->whereNull('league_id')
                ->orWhere('league_id', $team->league_id);
            })
            ->whereNot('status', TeamStatus::PLAYING->value)
            ->get();
    }

    public function findTeamByIdOrName(int $teamId, string $teamName): mixed
    {
        if ($teamId) {
            if ($team = Team::find($teamId)) {
                return $team;
            }
        }

        if (!empty($teamName)) {
            if ($team = Team::where('name', $teamName)->first()) {
                return $team;
            }
        }

        return null;
    }
}