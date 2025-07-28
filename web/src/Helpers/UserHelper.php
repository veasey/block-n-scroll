<?php
namespace App\Helpers;
use App\Models\Coach;
use Exception;

class UserHelper
{
    /**
     * return current logged in user
     * @throws \Exception
     * @return mixed
     */
    public static function getCurrentUser()
    {
        if (!isset($_SESSION['user']) || !isset($_SESSION['user']['id'])) {
            return null;
        }

        $user = Coach::find($_SESSION['user']['id']);

        if (!$user) {
            throw new Exception("User not found.");
        }

        return $user;
    }
}
