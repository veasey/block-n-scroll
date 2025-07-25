<?php
use App\Controllers\TeamManager\CreateTeamController;
use App\Controllers\TeamManager\ViewTeamController;
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
})->add(new AuthMiddleware());
$app->get('/team/create/{team_id}', CreateTeamController::class . ':getForm')->add(new AuthMiddleware());
$app->post('/team/create/save', CreateTeamController::class . ':saveTeam')->add(new AuthMiddleware());

$app->get('/team/view/all', ViewTeamController::class . ':listTeams');
$app->get('/team/view/user/{user_id}', ViewTeamController::class . ':listTeams');
$app->get('/team/view/{team_id}', ViewTeamController::class . ':viewTeam');