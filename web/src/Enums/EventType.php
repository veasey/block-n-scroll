<?php
namespace App\Enums;

enum EventType: string
{
    case  INJURY = 'injury';
    case  CASUALTY = 'casualty';
    case  TOUCHDOWN = 'touchdown';
    case  COMPLETION = 'completion';
}
