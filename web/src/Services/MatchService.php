<?php
namespace App\Services;

use App\Enums\LogType;
use App\Enums\Match\EventType;
use Illuminate\Database\Eloquent\Collection;

use App\Repositories\MatchGameRepository;
use App\Repositories\TeamRepository;

use App\Enums\TeamStatus;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStatus;
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

    private function filterOutTheDead(Collection $players) {
        return $players->filter(function ($player) {
            return !in_array($player->status, [PlayerStatus::DEAD, PlayerStatus::RETIRED]);
        })->values();    
    }

    public function restorePlayersFromMissNextGame(MatchGame $matchGame): array
    {
        $homePlayers = $matchGame->homeTeam->players;
        $awayPlayers = $matchGame->awayTeam?->players ?? collect();
        $allPlayers = $homePlayers->merge($awayPlayers);
        $allPlayers = $this->filterOutTheDead($allPlayers);  

        $recoveredPlayers = [];

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
            $player->status = PlayerStatus::ACTIVE;
            $player->save();

            $recoveredPlayers[] = $player;
        }

        return $recoveredPlayers;
    }

    public function awardMVP(MatchGame $matchGame): array
    {
        $data = [];

        $teams = [
            'home' => $matchGame->homeTeam,
            'away' => $matchGame->awayTeam
        ];

        foreach ($teams as $side => $team) {
            if (!$team || !$team->players) {
                continue;
            }

            $players = $this->filterOutTheDead($team->players);

            if ($players->isEmpty()) {
                continue;
            }

            $mvp = $players->random();
            $mvp->spp += 4; // Or 6 if you're using official MVP rules
            $mvp->save();

            $data["{$side}_mvp"] = $mvp;
        }

        return $data;
    }

    public function getMatchSetupInfo(MatchGame $matchGame): array
    {
        $events = EventLog::where('match_id', $matchGame->id)
            ->where('event_type', LogType::MATCH_EVENT)
            ->whereIn('event_key', [EventType::WEATHER, EventType::FAN_ATTENDANCE])
            ->get();

        return [
            'weather' => $events->where('event_key', EventType::WEATHER->value)->first() ?? null,
            'fan_factor' => $events->where('event_key', EventType::FAN_ATTENDANCE->value)->first() ?? null
        ];
    }

    public function calculateWinnings(MatchGame $matchGame): array
    {
        $totalFanGold = ($matchGame->home_fans + $matchGame->away_fans) * 10000;

        $homeWinnings = ($totalFanGold / 2) + ($matchGame->home_fans * 10000);
        $awayWinnings = ($totalFanGold / 2) + ($matchGame->away_fans * 10000);

        $this->allocateWinnings($matchGame, $homeWinnings, $awayWinnings);

        return [$homeWinnings, $awayWinnings];      
    }

    public function allocateWinnings(MatchGame $matchGame, int $homeWinnings, int $awayWinnings): bool
    {
        $matchGame->homeTeam->treasury += $homeWinnings;
        $matchGame->homeTeam->save();

        if ($matchGame->awayTeam) {
            $matchGame->awayTeam->treasury += $awayWinnings;
            $matchGame->awayTeam->save();
        }

        return true;
    }
}
