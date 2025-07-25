<?php
use App\Controllers\Rules\TeamController;
use App\Controllers\Rules\PositionController;
use App\Models\Base\BaseTeam;
use App\Models\Base\Skill;
use App\Models\Base\SideStaff;
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

$app->get('/rules/teams/{team_id}[.{format}]', TeamController::class . ':getTeam');

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
    $skillId = $args['skill_id'];

    $skill = Skill::find($skillId);
    if (!$skill) {
        return $response->withStatus(404)->write('Skill not found');
    }

    if ($format === 'json') {
        $response->getBody()->write(json_encode($skill));
        return $response->withHeader('Content-Type', 'application/json');
    }

    $category = strtolower($skill->category);
    $matchingTemplate = null;
    $templateDir = __DIR__ . "/../../templates/rules/skills/";

    foreach (glob("{$templateDir}/{$category}/{$skillId}_*.twig") as $filePath) {
        $basename = basename($filePath);

        $matchingTemplate = "rules/skills/{$category}/$basename";
        break;
    }

    $template = $matchingTemplate ?? 'rules/skill.twig';

    return Twig::fromRequest($request)->render($response, $template, ['skill' => $skill]);
});

$app->get('/rules/position/{position_id:\d+}[.{format}]', PositionController::class . ':getPosition');

$app->get('/rules/side-staff/{side_staff_id}[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    
    $format = $args['format'] ?? 'html';
    $staffId = $args['side_staff_id'];
    $staff = SideStaff::find($staffId);
    
    if (!$staff) {
        return $response->withStatus(404)->write('I don\'t know that side staff');
    }

    if ($format === 'json') {
        $response->getBody()->write(json_encode($staff));
        return $response->withHeader('Content-Type', 'application/json');
    }

    $template = 'rules/side_staff.twig';
    $templateDir = __DIR__ . '/../../templates/rules/side_staff/';
    $matches = glob("{$templateDir}{$staffId}_*.twig");

    if (!empty($matches)) {
        $template = 'rules/side_staff/' . basename($matches[0]);
    }

    return Twig::fromRequest($request)->render($response, $template, [
        'side_staff' => $staff,
    ]);
});