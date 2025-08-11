<?php

namespace App\Controllers\TeamManager\Shared;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Helpers\UserHelper;

use App\Models\User;
use App\Models\Team;

abstract class AccessController
{
    protected $userHelper;

    public function __construct(UserHelper $userHelper)    
    {
        $this->userHelper = $userHelper;
    }
    
    /**
     * show team management controls?
     * @param User
     * @param Team
     * @return bool
     */
    protected function isAuthorizeToModifyTeam(Team $team): bool
    {
        $user = $this->userHelper->getCurrentUser();
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $team->coach->id === $user->id;
    }

    protected function getAuthorizedTeamOrFail(Request $request, Response $response, array $args)
    {
        $teamId = $args['team_id'] ?? null;
        if (empty($teamId)) {
            return [null, $response->withStatus(404)->write('Team ID required')];
        }

        $team = Team::find($teamId);
        if (!$team) {
            return [null, $response->withStatus(404)->write('Team not found')];
        }

        if (!$this->isAuthorizeToModifyTeam($team)) {
            return [null, $response->withStatus(404)->write('Not authorised')];
        }

        return [$team, null];
    }
}