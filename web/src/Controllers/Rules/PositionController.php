<?php
namespace App\Controllers\Rules;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Helpers\SkillHelper;
use App\Models\Base\BaseTeamPlayer as Position;
use App\Models\Base\BaseTeam;
use Slim\Views\Twig;

class PositionController
{
    protected $skillHelper;

    protected $view;

    public function __construct(
        SkillHelper $skillHelper,
        Twig $view)
    {
        $this->skillHelper = $skillHelper;
        $this->view = $view;
    }

    public function getPosition(Request $request, Response $response, array $args): Response
    {
        $format = $args['format'] ?? 'html';

        $position = Position::find($args['position_id']);
        $team = BaseTeam::find($position->base_team_id);

        if (!$team || $team->is_hidden) {
            return $response->withStatus(404)->write('Team not found');
        }

        $position['skills'] = $position->skills()->get();
        $position['primary_skill_initials'] = $this->skillHelper->formatSkillCategoryInitials($position->primarySkill()->get());
        $position['secondary_skill_initials'] = $this->skillHelper->formatSkillCategoryInitials($position->secondarySkill()->get());

        $data = [
            'team' => $team,
            'position' => $position     
        ];

        if ($format === 'json') {
            $response->getBody()->write(json_encode($data));
            return $response->withHeader('Content-Type', 'application/json');
        }

        return $this->view->render($response, 'rules/position.twig', $data);
    }
}
