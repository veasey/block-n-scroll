<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Enums\UserRole;
use App\Models\Team;
use Slim\Views\Twig;

class DeleteTeamController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getConfirmView(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'];

        if (!$teamId) {
            $response->getBody()->write('Team ID is required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);
        if (!$team) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

        if (!$this->canDeleteTeam($team->coach_id)) {
            $response->getBody()->write('Not authorised!');
            return $response->withStatus(404);
        }

        return $this->view->render($response, 'team/manage/delete_team_confirm.twig', ['team' => $team]);
    }

    public function delete(Request $request, Response $response, array $args): Response
    {
        $teamId = $args['team_id'];

        if (!$teamId) {
            $response->getBody()->write('Team ID is required');
            return $response->withStatus(404);
        }

        $team = Team::find($teamId);

        if (!$team) {
            $response->getBody()->write('Team not found');
            return $response->withStatus(404);
        }

         if (!$this->canDeleteTeam($team->coach_id)) {
            $response->getBody()->write('Not authorised!');
            return $response->withStatus(404);
        }

        $teamName = $team->name;

        $team->players()->delete();
        $team->delete();

        return $this->view->render($response, 'team/manage/delete_team_success.twig', ['teamName' => $teamName]);
    }

    /**
     * Can current user delete this team?
     * @param int $coachId
     * @return bool
     */
    private function canDeleteTeam(int $coachId): bool
    {
        if (empty($_SESSION['user'])) {
            return false;
        }

        if (isset($_SESSION['user']) && $_SESSION['user']['id'] == $coachId) {
            return true;
        }

        if (isset($_SESSION['user']) && $_SESSION['user']['role'] == UserRole::ADMIN) {
            return true;
        }
 
        return false;
    }
}
