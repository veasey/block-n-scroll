<?php
namespace App\Enums\Match;

enum Status: string
{
    case  PREGAME = 'pregame';
    case  IN_PROGRESS = 'in_progress';
    case  POSTGAME = 'postgame';
    case  FINSIHED = 'finished';
    case PAUSED = 'paused';
}
