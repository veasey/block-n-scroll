<?php
namespace App\Helpers;

use App\Enums\Player\Level;
use App\Constants\SPP\Cost;

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
}
