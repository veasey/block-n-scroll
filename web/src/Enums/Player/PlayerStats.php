<?php
namespace App\Enums\Player;

enum PlayerStats: string
{
    case  ARMOUR_VALUE = 'AV';
    case  MOVEMENT_ALLOWANCE = 'MA';
    case  AGILITY = 'AG';
    case  PASSING_ABILITY = 'PA';
    case STRENGTH = 'ST';
}
