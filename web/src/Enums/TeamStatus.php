<?php
namespace App\Enums;

enum TeamStatus: string
{
    case FRESH = 'fresh';
    case PLAYING = 'playing';
    case POST_SEQUENCE = 'post_sequence';
    case IDLE = 'idle';
    case RETIRED = 'retired';
}
