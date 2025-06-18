<?php
use App\Models\Base\BaseTeam;
use App\Models\Base\Skill;
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/rules', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'rules.twig');
});

$app->get('/rules/teams[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $teams = BaseTeam::all();

    if ($format === 'json') {
        $response->getBody()->write($teams->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/teams.twig', ['teams' => $teams]);
});

$app->get('/rules/teams/{team_id}[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';

    $teamModel = new BaseTeam();
    $team = $teamModel->find($args['team_id']);
    if (!$team || $team->is_hidden) {
        return $response->withStatus(404)->write('Team not found');
    }
    
    $data = [
        'team' => $team,
        'positions' => $team->players,
        'special_rules' => $team->special_rules,
        'regional_rules' => $team->regional_rules
    ];

    if ($format === 'json') {
        $response->getBody()->write(json_encode($data));
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/team.twig', $data);
});

$app->get('/rules/skills[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $skills = Skill::all();

    if ($format === 'json') {
        $response->getBody()->write($skills->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/skills.twig', ['skills' => $skills]);
});

$app->get('/rules/skill/{skill_id}[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';

    $skill = Skill::find($args['skill_id']);
    if (!$skill) {
        return $response->withStatus(404)->write('Skill not found');
    }

    if ($format === 'json') {
        $response->getBody()->write(json_encode($skill));
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/skill.twig', ['skill' => $skill]);
});