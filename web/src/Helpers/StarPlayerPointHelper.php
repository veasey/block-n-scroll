<?php
namespace App\Helpers;

use App\Enums\Player\Level;
use App\Constants\SPP\Cost;
use App\Models\Player;

class StarPlayerPointHelper
{
    public function nextSkillCost(Level $level): mixed
    {
        return Cost::UPDGRADE_THRESHOLD[$level->value];
    }

    public function getSppCost(Level $level, string $upgradeType) {
        if (isset( Cost::UPDGRADE_THRESHOLD[$level->value][$upgradeType] )) {
            return  Cost::UPDGRADE_THRESHOLD[$level->value][$upgradeType];
        }

        return false;
    }

    public function getRandomCharacteristicsStatFromRoll(int $improvementRoll, Player $player): array
    {
        $characteristic = [];

        // 1‑7 Improve either MA or AV by 1 (or choose a Secondary skill).
        if ($improvementRoll >= 1 && $improvementRoll <= 7) {
            if ($player->ma < $player->position->ma + 2) $characteristic[] = 'MA';
            if ($player->av < $player->position->av + 2) $characteristic[] = 'AV';
        }

        // 8‑13 Improve either MA, PA, or AV by 1 (or choose a Secondary skill).
        else if ($improvementRoll >= 8 && $improvementRoll <= 13) {
            if ($player->ma < $player->position->ma + 2) $characteristic[] = 'MA';
            if ($player->av < $player->position->av + 2) $characteristic[] = 'AV';
            if ($player->pa > $player->position->pa - 2) $characteristic[] = 'PA';
        }

        // 14 Improve either AG or PA by 1 (or choose a Secondary skill).
        else if ($improvementRoll == 14) {
            if ($player->ag > $player->position->ag - 2) $characteristic[] = 'AG';
            if ($player->ma > $player->position->pa - 2) $characteristic[] = 'PA';
        }

        // 15 Improve either ST or AG by 1 (or choose a Secondary skill).
        else if ($improvementRoll == 15) {
            if ($player->ag > $player->position->ag - 2) $characteristic[] = 'AG';
            if ($player->st > $player->position->st + 2) $characteristic[] = 'ST';
        }

        // 16 Improve a characteristic of your choice by 1.
        else if ($improvementRoll == 16) {
            if ($player->ma < $player->position->ma + 2) $characteristic[] = 'MA';
            if ($player->av < $player->position->av + 2) $characteristic[] = 'AV';
            if ($player->pa > $player->position->pa - 2) $characteristic[] = 'PA';
            if ($player->ag > $player->position->ag - 2) $characteristic[] = 'AG';
            if ($player->st > $player->position->st + 2) $characteristic[] = 'ST';
        }
        
        return $characteristic;
    }

    public function getGoldCostForCharacteristic(string $stat): int
    {
        if ($stat = 'MA') return Cost::COST_MA;
        if ($stat = 'AV') return Cost::COST_AV;
        if ($stat = 'PA') return Cost::COST_PA;
        if ($stat = 'AG') return Cost::COST_AG;
        if ($stat = 'ST') return Cost::COST_ST;

        return 0;
    }
}
