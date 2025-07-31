<?php
namespace App\Enums;

enum TeamStatus: string
{
    case FRESH = 'fresh';
    case PLAYING = 'playing';
    case IDLE = 'idle';
    case RETIRED = 'retired';
}
