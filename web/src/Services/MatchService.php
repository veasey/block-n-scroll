<?php
namespace App\Services;

use App\Repositories\MatchGameRepository;
use App\Repositories\TeamRepository;

use App\Enums\TeamStatus;
use App\Enums\Player\CasualtyTable;
use App\Models\EventLog;
use App\Models\Team;
use App\Models\MatchGame;

class MatchService
{
    public function __construct(
        private MatchGameRepository $matchRepo,
        private TeamRepository $teamRepo
    ) {}

    public function startOrJoinMatch(Team $team, ?int $awayTeamId, ?string $awayTeamName): MatchGame
    {
        $opponent = $this->teamRepo->findTeamByIdOrName($awayTeamId, $awayTeamName);

        $match = $this->matchRepo->getExistingMatch($team, $opponent);

        if ($match) {
            $match->away_team_id = $team->id;
        } else {
            $match = new MatchGame();
            $match->home_team_id = $team->id;
            
            if ($team->league) {
                $match->league_id = $team->league->id;
            }            
            
            if ($opponent) {
                $match->away_team_id = $opponent->id;
            } else {
                $match->away_team_name = $awayTeamName;
            }
        }

        $match->save();

        if ($opponent) {
            $opponent->status = TeamStatus::PLAYING;
            $opponent->save();
        }
        $team->status = TeamStatus::PLAYING;
        $team->save();

        return $match;
    }

    public function endMatch(MatchGame $matchGame): MatchGame
    {
        if ($matchGame->homeTeam) {
            $matchGame->homeTeam->status = TeamStatus::IDLE;
            $matchGame->homeTeam->save();
        }

        if ($matchGame->awayTeam) {
            $matchGame->awayTeam->status = TeamStatus::IDLE;
            $matchGame->awayTeam->save();
        }

        return $matchGame;
    }

    public function restorePlayersFromMissNextGame(MatchGame $matchGame): bool
    {
        $homePlayers = $matchGame->homeTeam->players;
        $awayPlayers = $matchGame->awayTeam?->players ?? collect();
        $allPlayers = $homePlayers->merge($awayPlayers);

        foreach ($allPlayers as $player) {
            if (!$player->miss_next_game) {
                continue;
            }

            // Check if this player has a 'PLAYER_INJURED' event this match, excluding BADLY_HURT injuries
            $missNextGameInjuryThisMatch = EventLog::where('event_type', 'PLAYER_INJURED')
                ->where('event_key', '!=', CasualtyTable::BADLY_HURT)
                ->where('match_id', $matchGame->id)
                ->where('player_id', $player->id)
                ->first();

            if ($missNextGameInjuryThisMatch) {
                continue;
            }

            $player->miss_next_game = false;
            $player->save();
        }

        return true;
    }
}
