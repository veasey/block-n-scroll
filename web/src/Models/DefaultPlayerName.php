<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DefaultPlayerName extends Model
{
    protected $table = 'default_player_name';

    public static function getRandomFor(int $baseTeamId = 1, ?string $position = null): ?string
    {
        $query = self::query()
            ->where('base_team_id', $baseTeamId);

        if ($position !== null) {
            $query->where('position', $position);
        }

        $result = $query->inRandomOrder()->first();

        if (!$result && $position !== null) {
            // Retry with only base_team_id
            $result = self::query()
                ->where('base_team_id', $baseTeamId)
                ->inRandomOrder()
                ->first();
        }

        if (!$result) {
            // Fallback to any human name
            $result = self::inRandomOrder()->where('base_team_id', 8)->first();
        }

        return $result?->name;
    }
}
