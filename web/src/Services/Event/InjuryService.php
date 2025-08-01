<?php
namespace App\Services\Event;

use App\Models\Player;
use App\Enums\Player\CasualtyTable;
use App\Enums\Player\PlayerStatus;

class InjuryService
{
    public function record(Player $player, int $roll): mixed
    {
        if ($player->niggling_injury && $roll < 16) {
            $roll += 1;
        }
        $injury = CasualtyTable::fromRoll($roll);

        match ($injury) {
            CasualtyTable::BADLY_HURT => $this->markAsBadlyHurt($player),
            CasualtyTable::SERIOUSLY_HURT => $this->markAsMNG($player),
            CasualtyTable::SERIOUS_INJURY => $this->markAsNIAndMNG($player),
            CasualtyTable::LASTING_INJURY => $this->applyStatLossAndMNG($player),
            CasualtyTable::DEAD => $this->markAsDead($player),
        };

        $player->injuries += 1;
        if ($player->save()) {
            return $injury;
        }

        return false;
    }

    private function markAsBadlyHurt(Player $player) { /* no change */ }

    private function markAsMNG(Player $player) {
        $player->miss_next_game = true;
        $player->status = PlayerStatus::INJURED;
    }

    private function markAsNIAndMNG(Player $player) {
        $player->miss_next_game = true;
        $player->status = PlayerStatus::INJURED;
    }

    private function applyStatLossAndMNG(Player $player) {
        $player->miss_next_game = true;
        $player->status = PlayerStatus::INJURED;
    }

    private function markAsDead(Player $player) {
        $player->dead = true;
        $player->status = PlayerStatus::DEAD;
    }
}
