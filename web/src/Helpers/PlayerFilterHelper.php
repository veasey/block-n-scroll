<?php
namespace App\Helpers;

use Illuminate\Database\Eloquent\Collection;
use App\Enums\Player\PlayerStatus;

class PlayerFilterHelper
{
    public function notDead(Collection $players) {
        return $players->filter(function ($player) {
            return !$player->dead;
        })->values();    
    }

    public function notIndisposed(Collection $players) {
        return $players->filter(function ($player) {
            return !$player->dead && !$player->miss_next_game;
        })->values();    
    }   
}
