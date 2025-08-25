<?php
namespace App\Services\EventLogging;

use App\Services\EventLogging\Shared\EventLoggerService;

use App\Enums\LogType;
use App\Models\MatchGame;
use App\Models\League;
use App\Models\Coach;

class LeagueManagementEventLoggingService extends EventLoggerService
{
    public function logLeagueCreation(Coach $coach, League $league)
    {
        $this->log(
            LogType::LEAGUE_MANAGEMENT->value,
            'League Created',
            '',
            '',
            $coach,
            null,
            null,
            null,
            $league
        );
    }

    public function logLeagueUpdate(Coach $coach, League $league, $eventValue = '', $note = '')
    {
        $this->log(
            LogType::LEAGUE_MANAGEMENT->value,
            $eventValue,
            '',
            $note,
            $coach,
            null,
            null,
            null,
            $league
        );
    }
}