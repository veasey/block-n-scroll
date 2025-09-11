<?php
namespace App\Enums;

enum SideStaff: int
{
    case REROLL = 1;
    case APOTHECARY = 2;
    case ASSISTANT_COACH = 3;
    case CHEERLEADER = 4;
    case DEDICATED_FANS = 5;

     public function cost(): int
    {
        return match($this) {
            self::REROLL => 50,
            self::APOTHECARY => 100,
            self::ASSISTANT_COACH => 40,
            self::CHEERLEADER => 10,
            self::DEDICATED_FANS => 5,
        };
    }
}
