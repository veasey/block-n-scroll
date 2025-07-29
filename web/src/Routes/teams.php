<?php
use App\Controllers\TeamManager\CreateTeamController;
use App\Controllers\TeamManager\DeleteTeamController;
use App\Controllers\TeamManager\ViewTeamController;
use App\Controllers\TeamManager\EditTeamController;
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

$app->get('/team/view/all', ViewTeamController::class . ':listTeams');
$app->get('/team/view/user/{user_id}', ViewTeamController::class . ':listTeams');
$app->get('/team/view/{team_id}', ViewTeamController::class . ':viewTeam');

$app->get('/team/delete/{team_id}/confirm', DeleteTeamController::class . ':getConfirmView');
$app->get('/team/delete/{team_id}', DeleteTeamController::class . ':delete');

$app->get('/team/edit/{team_id}', EditTeamController::class . ':getForm');
$app->post('/team/edit/{team_id}', EditTeamController::class . ':save');

$app->get('/team/hire/sidestaff/{team_id}', HireTeamController::class . ':getForm');
$app->post('/team/hire/sidestaff/{team_id}', HireTeamController::class . ':hireStaff');
$app->post('/team/fire/sidestaff/{team_id}', HireTeamController::class . ':fireStaff');