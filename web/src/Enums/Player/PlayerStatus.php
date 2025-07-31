<?php

namespace App\Enums\Player;

enum PlayerStatus: string
{
    case ACTIVE = 'active';
    case INJURED = 'injured';
    case DEAD = 'dead';
    case RETIRED = 'retired';
}