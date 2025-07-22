<?php
namespace App\Controllers\TeamManager;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\SkillFormatter;
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
}
