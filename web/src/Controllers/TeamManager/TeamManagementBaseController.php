<?php

namespace App\Controllers\TeamManager;

use App\Models\User;
use App\Models\Team;

// BaseController.php
abstract class TeamManagementBaseController
{
    /**
     * show team management controls?
     * @param User
     * @param Team
     * @return bool
     */
    protected function isAuthorizeToModifyTeam($user, Team $team): bool
    {
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $team->coach->id === $user->id;
    }
}