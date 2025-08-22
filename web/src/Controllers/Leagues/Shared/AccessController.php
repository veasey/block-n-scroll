<?php

namespace App\Controllers\Leagues\Shared;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

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

    protected function doesLeagueExist(Request $request, Response $response, array $args)
    {
        $leagueId = $args['league_id'] ?? null;
        if (empty($leagueId)) {
            $response->getBody()->write('League ID required');
            return [null, $response->withStatus(404)];
        }

        $league = League::find($leagueId);
        if (!$league) {
            $response->getBody()->write('League not found');
            return [null, $response->withStatus(404)];
        }

        return [$league, null];
    }
}