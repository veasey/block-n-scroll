<?php
namespace App\Services\Event;

use App\Models\Player;
use App\Enums\CasualtyTable;

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

        if ($player->save()) {
            return $injury;
        }

        return false;
    }

    private function markAsBadlyHurt(Player $player) { /* no change */ }

    private function markAsMNG(Player $player) {
        $player->miss_next_game = true;
    }

    private function markAsNIAndMNG(Player $player) {
        $player->miss_next_game = true;
        // optional: add injury record
    }

    private function applyStatLossAndMNG(Player $player) {
        $player->miss_next_game = true;
        // randomly reduce a stat here
    }

    private function markAsDead(Player $player) {
        $player->dead = true;
    }
}
