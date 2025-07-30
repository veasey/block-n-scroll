<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

use App\Enums\TeamStatus;

use App\Models\Base\BaseTeam;
use App\Models\Coach;
use App\Models\League;
use App\Models\Player;
use App\Models\MatchGame;

class Team extends Model
{
    protected $table = 'team';

    public function race(): BelongsTo
    {
        return $this->belongsTo(BaseTeam::class, 'base_team_id');
    }

    public function coach(): BelongsTo
    {
        return $this->belongsTo(Coach::class, 'coach_id');
    }

    public function league(): BelongsTo
    {
        return $this->belongsTo(League::class, 'league_id');
    }

    public function players(): HasMany
    {
        return $this->hasMany(Player::class, 'team_id');
    }

    public function homeMatches(): HasMany
    {
        return $this->hasMany(MatchGame::class, 'home_team_id');
    }

    public function awayMatches(): HasMany
    {
        return $this->hasMany(MatchGame::class, 'away_team_id');
    }

    public function getAllMatches(): mixed
    {
        return MatchGame::where('home_team_id', $this->id)
                    ->orWhere('away_team_id', $this->id)
                    ->get();
    }

    public function getCurrentMatch(): mixed
    {
        if ($this->status != TeamStatus::PLAYING->value) {
            return false;
        }

        return MatchGame::where('home_team_id', $this->id)
            ->orWhere('away_team_id', $this->id)
            ->orderByDesc('updated_at')
            ->first();
    }
}
