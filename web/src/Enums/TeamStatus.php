<?php
namespace App\Enums;

enum TeamStatus: string
{
    case FRESH = 'FRESH';
    case PLAYING = 'PLAYING';
    case IDLE = 'IDLE';
    case RETIRED = 'RETIRED';
}
