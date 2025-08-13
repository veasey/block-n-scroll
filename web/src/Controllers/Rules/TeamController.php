<?php
namespace App\Controllers\Rules;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\SkillHelper;
use App\Models\Base\BaseTeam;
use Slim\Views\Twig;

class TeamController
{
    protected $skillHelper;
    protected $view;

    public function __construct(
        SkillHelper $skillHelper,
        Twig $view
    )
    {
        $this->skillHelper = $skillHelper;
        $this->view = $view;
    }

    public function getTeam(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';

        $team = BaseTeam::find($args['team_id']);

        if (!$team || $team->is_hidden) {
            return $response->withStatus(404)->write('Team not found');
        }

        // Here is where you can add your data presentation logic
        $data = [
            
            'team' => $team,
            'special_rules' => $team->special_rules,
            'regional_rules' => $team->regional_rules,

            // pre-format primary and secondary skills for all players
            'positions' => $team->players->map(function ($player) {
                return [
                    'player' => $player,
                    'primary_skill_initials' => $this->skillHelper->formatSkillCategoryInitials($player->primarySkill()->get()),
                    'secondary_skill_initials' => $this->skillHelper->formatSkillCategoryInitials($player->secondarySkill()->get()),
                ];
            }),
        ];

        if ($format === 'json') {
            $response->getBody()->write(json_encode($data));
            return $response->withHeader('Content-Type', 'application/json');
        }

        return $this->view->render($response, 'rules/team.twig', $data);
    }
}
