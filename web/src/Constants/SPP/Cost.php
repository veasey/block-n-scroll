<?php
namespace App\SPP\Constants;

class Cost
{
    public CONST UPDGRADE_THRESHOLD = [
        'Experienced'   => [
            'primary_random'   => 3,
            'primary_selected' => 6,
            'secondary_random' => 12,
            'secondary_selected' => 18,
        ],
        'Veteran'       => [
            'primary_random'   => 4,
            'primary_selected' => 8,
            'secondary_random' => 14,
            'secondary_selected' => 20,
        ],
        'Emerging Star' => [
            'primary_random'   => 6,
            'primary_selected' => 10,
            'secondary_random' => 16,
            'secondary_selected' => 24,
        ],
        'Star'          => [
            'primary_random'   => 8,
            'primary_selected' => 12,
            'secondary_random' => 18,
            'secondary_selected' => 28,
        ],
        'Super Star'    => [
            'primary_random'   => 10,
            'primary_selected' => 14,
            'secondary_random' => 20,
            'secondary_selected' => 32,
        ],
        'Legend'        => [
            'primary_random'   => 15,
            'primary_selected' => 30,
            'secondary_random' => 40,
            'secondary_selected' => 50,
        ],
    ];
}