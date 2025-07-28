<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Enums\UserRole;

class Coach extends Model
{
    protected $table = 'coach';

    public function isAdmin():bool
    {
        return $this->role === UserRole::ADMIN;
    }
}
