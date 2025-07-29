<?php
namespace App\Enums;

enum UserRole: string
{
    case COACH = 'coach';
    case MODERATOR = 'moderator';
    case ADMIN = 'admin';
}