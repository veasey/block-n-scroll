<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\SkillFormatter;
use App\Helpers\SideStaffPruner;
use App\Models\Base\BaseTeam;
use Slim\Views\Twig;

class CreateTeamController
{

    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function getForm(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';

        $baseTeam = BaseTeam::find($args['team_id']);

        if (!$baseTeam || $baseTeam->is_hidden) {
            return $response->withStatus(404)->write('Team not found');
        }

        // Here is where you can add your data presentation logic
        $data = [
            
            'base_team' => $baseTeam,
            'special_rules' => $baseTeam->special_rules,
            'regional_rules' => $baseTeam->regional_rules,
            'apothecary_allowed' => $baseTeam->apothecary_allowed,
            // Fetch side staff options
            'side_staff' => SideStaffPruner::getSideStaffOptions($baseTeam),

            // pre-format primary and secondary skills for all players
            'positions' => $baseTeam->players->map(function ($player) {
                return [
                    'player' => $player,
                    'primary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->primarySkill()->get()),
                    'secondary_skill_initials' => SkillFormatter::formatSkillCategoryInitials($player->secondarySkill()->get()),
                ];
            }),
        ];

        return $this->view->render($response, 'team/create/2_buy_staff.twig', $data);
    }

    public function saveTeam(Request $request, Response $response): Response
    {
        $data = $request->getParsedBody();

        echo '<pre>'; die(print_r($data, true));

        // Example: validate and collect data
        $teamName = trim($data['team_name'] ?? '');
        $race = $data['race'] ?? '';
        $isNew = true;

        if (!$teamName || !$race) {
            // Optionally store error in session or flash bag
            return $response
                ->withHeader('Location', '/team/create?error=1')
                ->withStatus(302);
        }

        $userId = $_SESSION['user_id'] ?? null;

        if (!$userId && empty($_SESSION['guest_id'])) {
            // Create a guest session ID if not logged in
            $_SESSION['guest_id'] = bin2hex(random_bytes(8));
        }

        $ownerId = $userId ?? $_SESSION['guest_id'];

        // Save to DB
        $stmt = $this->db->prepare('
            INSERT INTO teams (name, race, owner_id, is_new)
            VALUES (:name, :race, :owner_id, :is_new)
        ');
        $stmt->execute([
            'name' => $teamName,
            'race' => $race,
            'owner_id' => $ownerId,
            'is_new' => $isNew,
        ]);

        // Redirect to list or detail view
        return $response
            ->withHeader('Location', '/teams')
            ->withStatus(302);

        // For now, just redirect back to the team creation page
        return $response->withHeader('Location', '/team/create')->withStatus(302);
    }
}
