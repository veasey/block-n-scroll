<?php
use App\Controllers\Leagues\CreateController;
use App\Controllers\Leagues\ViewController;

$app->get('/leagues', ViewController::class . ':list');
$app->get('/leagues/create', CreateController::class . ':getEditForm');
$app->post('/leagues/create', CreateController::class . ':create');

$app->get('/leagues/view/user/managed/{user_id}', ViewController::class . ':listManaged');
$app->get('/leagues/view/user/playing/{user_id}', ViewController::class . ':listPlaying');