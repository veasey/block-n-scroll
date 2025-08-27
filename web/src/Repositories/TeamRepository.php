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
        $baseQuery =  Team::where('id', '!=', $team->id)
             ->whereNot('status', TeamStatus::PLAYING->value);

        // if team is in league
        if ($team->league_id) {
            $baseQuery = $baseQuery->where(function ($q) use ($team) {
                $q->where('league_id', $team->league_id);
            });
        } 
        
        // If not in league, can only join other teams not in leagues
        else {
            $baseQuery = $baseQuery->whereNull('league_id');
        }
        
        return $baseQuery->get();
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

    public function getTeamsInLeague(int $leagueId, array $params = [], bool $standing = true): mixed
    {
        $baseQuery = Team::where('team.league_id', $leagueId);

        if ($standing) {
            $baseQuery
                ->selectRaw("
                    team.*,
                    COALESCE(SUM(
                        CASE 
                            WHEN g.status = 'finished' 
                            AND (
                                (g.home_team_id = team.id AND g.home_score > g.away_score) 
                                OR 
                                (g.away_team_id = team.id AND g.away_score > g.home_score)
                            ) 
                            THEN 1 ELSE 0 END
                    ), 0) as wins,
                    COALESCE(SUM(
                        CASE 
                            WHEN g.status = 'finished' 
                            AND g.home_score = g.away_score 
                            THEN 1 ELSE 0 END
                    ), 0) as draws,
                    COALESCE(SUM(
                        CASE 
                            WHEN g.status = 'finished' 
                            AND (
                                (g.home_team_id = team.id AND g.home_score < g.away_score) 
                                OR 
                                (g.away_team_id = team.id AND g.away_score < g.home_score)
                            ) 
                            THEN 1 ELSE 0 END
                    ), 0) as losses
                ")
                ->leftJoin('game as g', function ($join) use ($leagueId) {
                    $join->on(function ($q) {
                        $q->on('team.id', '=', 'g.home_team_id')
                        ->orOn('team.id', '=', 'g.away_team_id');
                    })
                    ->where('g.league_id', '=', $leagueId);
                });
        }

        if (isset($params['offset'])) {
            $baseQuery = $baseQuery->skip($params['offset']);
        }
        
        if (isset($params['perPage'])) {
            $baseQuery = $baseQuery->take($params['perPage']);
        }

        if ($standing) {
            $baseQuery->groupBy('team.id')
            ->orderByDesc('wins')
            ->orderByDesc('draws')
            ->orderBy('losses');
        }

        return $baseQuery->get();
    }

    public function getTeamsInLeagueCount(int $leagueId): int
    {
        return Team::where('league_id', $leagueId)
            ->count();
    }
}