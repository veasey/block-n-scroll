<?php
namespace App\Services\EventLogging;

use App\Services\EventLogging\Shared\EventLoggerService;

use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStats;
use App\Enums\LogType;
use App\Models\MatchGame;
use App\Models\Player;

class PlayerEventLoggingService extends EventLoggerService
{
    public function logPlayerInjury(MatchGame $matchGame, Player $player, CasualtyTable $injuryType)
    {
        $this->log(
            LogType::PLAYER_INJURED->value,
            $injuryType->value,
            '',
            '',
            $player->team->coach,
            $player->team,
            $player,
            $matchGame
        );
    }

    public function logPlayerLastingInjury(MatchGame $matchGame, Player $player, PlayerStats $reductionType)
    {
        $this->log(
            LogType::PLAYER_INJURED->value,
            CasualtyTable::LASTING_INJURY->value,
            $reductionType->value,
            $reductionType->value . ' reduced by 1',
            $player->team->coach,
            $player->team,
            $player,
            $matchGame
        );
    }

    public function logPlayerRetirement(Player $player)
    {
        $this->log(
            LogType::PLAYER_RETIRED->value,
            '',
            '',
            '',
            $player->team->coach,
            $player->team,
            $player,
            null
        );
    }

    public function logPlayerCasualty(Player $player, MatchGame $match)
    {
        $this->log(
            LogType::CASUALTY_LOGGED->value,
            '',
            '',
            '',
            $player->team->coach,
            $player->team,
            $player,
            $match
        );
    }
}