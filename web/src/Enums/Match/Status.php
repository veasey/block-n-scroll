<?php
namespace App\Enums\Match;

enum Status: string
{
    case  PREGAME = 'pregame';
    case  IN_PROGRESS = 'in_progress';
    case  POSTGAME = 'postgame';
    case  FINISHED = 'finished';
    case PAUSED = 'paused';
}
