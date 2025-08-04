<?php
namespace App\Services\EventLogging;

use App\Services\EventLogging\Shared\EventLoggerService;

use App\Enums\LogType;
use App\Enums\Match\EventType;
use App\Enums\Match\WeatherTable;
use App\Models\MatchGame;
use App\Models\Player;

class MatchEventLoggingService extends EventLoggerService
{

    public function logMatchStart(MatchGame $matchGame)
    {
        $this->log(
            LogType::MATCH_STARTED->value,
            '',
            '',
            '',
            null,
            null,
            null,
            $matchGame
        );
    }

    public function logMatchEnd(MatchGame $matchGame)
    {
        $this->log(
            LogType::MATCH_ENDED->value,
            '',
            '',
            '',
            null,
            null,
            null,
            $matchGame
        );
    }

    public function logMatchEndAwardMVP(MatchGame $matchGame, Player $player)
    {
        $this->log(
            LogType::PLAYER_AWARDED_MVP->value,
            '',
            '',
            '',
            $player->team->coach,
            $player->team,
            $player,
            $matchGame
        );
    }

    public function logMatchFanAttendance(MatchGame $matchGame, int $dedicatedAwayFans)
    {
        $homeTeamName = $matchGame->homeTeam->name;
        $homeFanFactor = $matchGame->home_fans + $matchGame->homeTeam->fan_factor;

        if (!empty($matchGame->awayTeam)) {
            $awayFanFactor = $matchGame->away_fans + $matchGame->awayTeam->fan_factor;
            $awayTeamName = $matchGame->awayTeam->name;
        } else {
            $awayFanFactor = $matchGame->away_fans + $dedicatedAwayFans;
            $awayTeamName = $matchGame->away_team_name;
        }
        
        $totalFans = $matchGame->away_fans + $matchGame->home_fans;
        $fameText = "{$homeTeamName} fans = {$homeFanFactor}, {$awayTeamName} fans = {$awayFanFactor}.";

        if ($homeFanFactor > $awayFanFactor * 2) {
            $fameText .= "{$homeTeamName} has +2 FAME";
        } elseif ($homeFanFactor > $awayFanFactor) {
            $fameText .= "{$homeTeamName} has +1 FAME";
        } elseif ($awayFanFactor > $homeFanFactor * 2) {
            $fameText .= "{$awayTeamName} has +2 FAME";
        } elseif ($awayFanFactor > $homeFanFactor) {
            $fameText .= "{$awayTeamName} has +1 FAME";
        }

        $this->log(
            LogType::MATCH_EVENT->value,
            "Total Fans: {$totalFans}",
            EventType::FAN_ATTENDANCE->value,
            $fameText,
            null,
            null,
            null,
            $matchGame
        );
    }

    public function logMatchWeather(MatchGame $matchGame, WeatherTable $weather)
    {
        $this->log(
            LogType::MATCH_EVENT->value,
            $weather->value,
            EventType::WEATHER->value,
            '',
            null,
            null,
            null,
            $matchGame
        );
    }

    public function logKickOff(MatchGame $matchGame)
    {
        $this->log(
            LogType::MATCH_EVENT->value,
            '',
            EventType::KICK_OFF->value,
            '',
            null,
            null,
            null,
            $matchGame
        );
    }

    public function logMatchEndWinningsAwarded(MatchGame $matchGame, int $homeWinnings, int $awayWinnings) {
        
        // log home team winnings
        $this->log(
            LogType::MATCH_EVENT->value,
            "$homeWinnings Gold",
            EventType::WINNINGS->value,
            '',
            $matchGame->homeTeam->coach,
            $matchGame->homeTeam,
            null,
            $matchGame
        );

        // log away team winnings
        $this->log(
            LogType::MATCH_EVENT->value,
            "$awayWinnings Gold",
            EventType::WINNINGS->value,
            '',
            ($matchGame->awayTeam) ? $matchGame->awayTeam->coach : null,
            ($matchGame->awayTeam) ? $matchGame->awayTeam : null,
            null,
            $matchGame
        );
    }
}