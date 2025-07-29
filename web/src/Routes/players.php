<?php
use App\Controllers\Players\ViewController;
use App\Controllers\Players\ViewLogController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');
$app->get('/player/view/{ player_id }/log/injuries[.{format}]', ViewLogController::class . ':viewInjuries');