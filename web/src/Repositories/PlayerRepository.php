<?php
namespace App\Repositories;

use Illuminate\Support\Collection;

use App\Enums\Player\PlayerStatus;
use App\Models\Team;
use App\Models\Player;

class PlayerRepository
{
    public function getActiveOrInjuredPlayersInTeam(Team $team): Collection
    {
        return Player::whereIn('status', [
                PlayerStatus::Active->value,
                PlayerStatus::Injured->value,
            ])
            ->where('team_id', $team->id)
            ->get();
    }
}