<?php

namespace App\Controllers\Players\Shared;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Helpers\UserHelper;

use App\Models\User;
use App\Models\Player;

abstract class AccessController
{
    /**
     * show team management controls?
     * @param User
     * @param Team
     * @return bool
     */
    protected function isAuthorizeToManagePlayer(Player $player): bool
    {
        $user = UserHelper::getCurrentUser();
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $player->team->coach->id === $user->id;
    }

    protected function getRecognisedPlayerOrFail(Request $request, Response $response, array $args)
    {
        $playerId = $args['player_id'] ?? null;
        if (empty($playerId)) {
            return [null, $response->withStatus(404)->write('Player ID required')];
        }

        $player = Player::find($playerId);
        if (!$player) {
            return [null, $response->withStatus(404)->write('Player not found')];
        }


        return [$player, null];
    }
}