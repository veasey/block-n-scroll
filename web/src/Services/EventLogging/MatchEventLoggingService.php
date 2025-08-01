<?php
namespace App\Services\EventLogging;

use App\Services\EventLogging\Shared\EventLoggerService;

use App\Enums\LogType;
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
}