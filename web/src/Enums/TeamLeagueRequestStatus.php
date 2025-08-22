<?php
namespace App\Enums;

enum TeamLeagueRequestStatus: string
{
    case PENDING = 'pending';
    case APPROVED = 'approved';
    case REJECTED = 'rejected';
}
