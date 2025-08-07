<?php
use App\Controllers\TeamManager\CreateTeamController;
use App\Controllers\TeamManager\DeleteTeamController;
use App\Controllers\TeamManager\ViewTeamController;
use App\Controllers\TeamManager\EditTeamController;
use App\Controllers\TeamManager\HireTeamController;
use App\Controllers\TeamManager\QuickButtonController;
use App\Controllers\TeamManager\ApiController;
use App\Middleware\AuthMiddleware;
use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app->get('/team', function (Request $request, Response $response) use ($app) {
    return Twig::fromRequest($request)->render($response, 'team.twig');
});

$app->get('/team/create', CreateTeamController::class . ':getFormSelectRace')->add(new AuthMiddleware());
$app->get('/team/create/{team_id}', CreateTeamController::class . ':getFormHireStaff')->add(new AuthMiddleware());
$app->post('/team/create', CreateTeamController::class . ':save')->add(new AuthMiddleware());
$app->get('/api/team/check-name', ApiController::class . ':checkName')->add(new AuthMiddleware());

$app->get('/team/view/all', ViewTeamController::class . ':listTeams');
$app->get('/team/view/user/{user_id}', ViewTeamController::class . ':listTeams');
$app->get('/team/view/{team_id}', ViewTeamController::class . ':viewTeam');

$app->get('/team/delete/{team_id}/confirm', DeleteTeamController::class . ':getConfirmView');
$app->get('/team/delete/{team_id}', DeleteTeamController::class . ':delete');
$app->get('/team/retire/{team_id}', DeleteTeamController::class . ':retire');
$app->get('/team/unretire/{team_id}', DeleteTeamController::class . ':unretire');

$app->get('/team/edit/{team_id}', EditTeamController::class . ':getForm');
$app->post('/team/edit/{team_id}', EditTeamController::class . ':save');

$app->get('/team/quick/{team_id}/{event_type}', QuickButtonController::class . ':getForm');

$app->get('/team/hire/{team_id}', HireTeamController::class . ':getForm');
$app->post('/team/hire/{team_id}', HireTeamController::class . ':save');