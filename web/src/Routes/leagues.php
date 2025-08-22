<?php
use App\Controllers\Leagues\CreateController;
use App\Controllers\Leagues\RegistrationController;
use App\Controllers\Leagues\ViewController;

$app->get('/leagues/create', CreateController::class . ':getEditForm');
$app->post('/leagues/create', CreateController::class . ':create');

$app->get('/leagues/request/{league_id}', RegistrationController::class . ':getEnterTeamForm');
$app->post('/leagues/request/{league_id}', RegistrationController::class . ':submitEnterTeamForm');

$app->get('/leagues', ViewController::class . ':list');
$app->get('/leagues/view/{league_id}', ViewController::class . ':view');
$app->get('/leagues/view/user/managed/{user_id}', ViewController::class . ':listManaged');
$app->get('/leagues/view/user/playing/{user_id}', ViewController::class . ':listPlaying');
