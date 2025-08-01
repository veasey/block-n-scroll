<?php
namespace App\Enums;

enum MatchEventType: string
{
    case  INJURY = 'injury';
    case  CASUALTY = 'casualty';
    case  TOUCHDOWN = 'touchdown';
    case  COMPLETION = 'completion';
}
