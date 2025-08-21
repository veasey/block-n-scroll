<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

use App\Enums\UserRole;
use App\Models\Team;

class Coach extends Model
{
    protected $table = 'coach';

    public function isAdmin():bool
    {
        return UserRole::tryFrom($this->role) === UserRole::ADMIN;
    }

    public function isModerator():bool
    {
        return UserRole::tryFrom($this->role) === UserRole::MODERATOR;
    }

    public function teams(): HasMany
    {
        return $this->hasMany(Team::class, 'coach_id');
    }

    public function moderatedLeagues()
    {
        return $this->belongsToMany(League::class, 'league_coach')
                    ->withTimestamps();
    }

    // Playing leagues (via teams.league_id)
    public function playingLeagues()
    {
        return $this->hasManyThrough(
            League::class,
            Team::class,
            'coach_id',   // Foreign key on Team table
            'id',         // Foreign key on League table
            'id',         // Local key on Coach
            'league_id'   // Local key on Team
        )->distinct();
    }
}
