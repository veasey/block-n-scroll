<?php

namespace App\Controllers\Leagues\Shared;

use App\Helpers\UserHelper;

use App\Models\League;

abstract class AccessController
{
    protected $userHelper;

    public function __construct(
        UserHelper $userHelper
    )    
    {
        $this->userHelper = $userHelper;
    }

    protected function isAuthorizeToCreateLeagues(): bool
    {
        $user = $this->userHelper->getCurrentUser();
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $user->isModerator();
    }

    protected function isAuthorizeToManageLeague(): bool
    {
        $user = $this->userHelper->getCurrentUser();
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $user->isModerator();
    }
}