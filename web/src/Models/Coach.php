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
        return $this->role === UserRole::ADMIN;
    }

    public function isModerator():bool
    {
        return $this->role === UserRole::MODERATOR;
    }

    public function teams(): HasMany
    {
        return $this->hasMany(Team::class, 'coach_id');
    }
}
