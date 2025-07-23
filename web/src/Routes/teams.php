<?php
use App\Controllers\TeamManager\CreateTeamController;
use App\Middleware\AuthMiddleware;
use App\Models\Base\BaseTeam;
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/team', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'team.twig');
});
$app->get('/team/create', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'team/create/1_race_picker.twig', ['teams' => BaseTeam::all()]);
});
$app->get('/team/create/{team_id}', CreateTeamController::class . ':getForm');
$app->post('/team/create/save', CreateTeamController::class . ':saveTeam')->add(new AuthMiddleware());


/*
$app->get('/team/view/all[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $teams = BaseTeam::all();

    if ($format === 'json') {
        $response->getBody()->write($teams->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/teams.twig', ['teams' => $teams]);
});

$app->get('/team/view/{team_id}[.{format}]', function (Request $request, Response $response, array $args) use ($app) {
    $format = $args['format'] ?? 'html';
    $teams = BaseTeam::all();

    if ($format === 'json') {
        $response->getBody()->write($teams->toJson());
        return $response->withHeader('Content-Type', 'application/json');
    }

    return Twig::fromRequest($request)->render($response, 'rules/teams.twig', ['teams' => $teams]);
});*/