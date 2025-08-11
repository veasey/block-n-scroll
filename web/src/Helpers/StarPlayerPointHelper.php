<?php
namespace App\Helpers;

use App\Constants\SPP\Cost;
use App\Models\Player;

class StarPlayerPointHelper
{
    public function nextSkillCost(Player $player): mixed
    {
        return Cost::UPDGRADE_THRESHOLD[$player->level];
    }
}
