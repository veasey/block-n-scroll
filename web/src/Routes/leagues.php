<?php
use App\Controllers\Leagues\CreateController;
use App\Controllers\Leagues\ManageController;
use App\Controllers\Leagues\ManageRequestController;
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

$app->get('/leagues/manage/{league_id}', ManageController::class . ':view');
$app->post('/leagues/manage/{league_id}/update_season', ManageController::class . ':submitSeason');

$app->get('/leagues/manage/{league_id}/delete_confirm', ManageController::class . ':getConfirmDelete');
$app->get('/leagues/manage/{league_id}/delete', ManageController::class . ':delete');

$app->post('/leagues/{league_id}/requests/{request_id}/approve', ManageRequestController::class . ':approveRequest');
$app->post('/leagues/{league_id}/requests/{request_id}/reject', ManageRequestController::class . ':rejectRequest');