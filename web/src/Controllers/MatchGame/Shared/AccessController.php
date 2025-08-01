<?php
namespace App\Controllers\MatchGame\Shared;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

use App\Helpers\UserHelper;

use App\Models\MatchGame;
use App\Models\Team;

abstract class AccessController
{
    protected function isAuthorizeToManageTeam(Team $team): bool
    {
        $user = UserHelper::getCurrentUser();
        if (empty($user)) {
            return false;
        }

        return $user->isAdmin() || $team->coach->id === $user->id;
    }

    protected function getRecognisedTeamOrFail(Request $request, Response $response, array $args)
    {
        $data = $request->getParsedBody();
        $teamId = $data['team_id'] ?? '';

        if (empty($teamId)) {
            $response->getBody()->write('Missing team ID');
            return [null, $response->withStatus(400)];
        }

        $team = Team::find($teamId);
        if (!$team) {
            $response->getBody()->write('Team not found');
            return [null, $response->withStatus(404)];
        }

        return [$team, null];
    }

    protected function getAuthorisedMatchOrFail(Request $request, Response $response, array $args)
    {
        $matchId = $args['match_id'] ?? '';

        if (empty($matchId)) {
            $response->getBody()->write('Missing match ID');
            return [null, $response->withStatus(400)];
        }

        $match = MatchGame::find($matchId);
        if (!$match) {
            $response->getBody()->write('Match not found');
            return [null, $response->withStatus(404)];
        }

        return [$match, null];
    }
}