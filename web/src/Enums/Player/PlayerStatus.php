<?php

namespace App\Enums\Player;

enum PlayerStatus: string
{
    case Active = 'active';
    case Injured = 'injured';
    case Dead = 'dead';
    case Retired = 'retired';
}