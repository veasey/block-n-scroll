<?php
namespace App\Helpers;
use App\Enums\UserRole;
use App\Models\Coach;
use Exception;

class UserHelper
{
    /**
     * return current logged in user
     * @throws \Exception
     * @return mixed
     */
    public function getCurrentUser()
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

    public function isCurrentUserAdmin(): bool 
    {
        $currentUser = $this->getCurrentUser();
        $userRole = UserRole::tryFrom($currentUser->role);
        return $userRole === UserRole::ADMIN;
    }
}
