<?php
use App\Controllers\Players\ViewController;
use App\Controllers\Players\ViewLogController;
use App\Controllers\Players\UpdateController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');
$app->get('/player/view/{ player_id }/log/injuries[.{format}]', ViewLogController::class . ':viewInjuries');

$app->post('/player/injure', UpdateController::class . ':addInjury');
$app->post('/player/injure/{ player_id }/lasting', UpdateController::class . ':addLastingInjury');