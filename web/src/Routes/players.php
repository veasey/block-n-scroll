<?php
use App\Controllers\Players\ViewController;
use App\Controllers\Players\ViewLogController;
use App\Controllers\Players\UpdateController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');
$app->get('/player/view/{ player_id }/log/{log_type}[.{format}]', ViewLogController::class . ':viewLog');

$app->post('/player/injure', UpdateController::class . ':addInjury');
$app->post('/player/injure/{ player_id }/lasting', UpdateController::class . ':addLastingInjury');

$app->post('/player/casualty', UpdateController::class . ':recordCasualty');

$app->get('/player/retire/{ player_id }', UpdateController::class . ':retireConfirm');
$app->post('/player/retire/{ player_id }', UpdateController::class . ':retire');