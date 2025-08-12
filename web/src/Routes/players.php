<?php

use App\Controllers\Players\EditController;
use App\Controllers\Players\StarPlayerPointsController;
use App\Controllers\Players\UpdateController;
use App\Controllers\Players\ViewController;
use App\Controllers\Players\ViewLogController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');
$app->get('/player/view/{ player_id }/log/{log_type}[.{format}]', ViewLogController::class . ':viewLog');

$app->get('/player/spp/{ player_id }', StarPlayerPointsController::class . ':getStarPlayerPointsForm');
$app->get('/player/spp/{ player_id }/select_primary', StarPlayerPointsController::class . ':getPrimarySkillSelectForm');
$app->get('/player/spp/{ player_id }/random_primary', StarPlayerPointsController::class . ':getPrimarySkillRandomForm');
$app->post('/player/spp/{ player_id }/purchase/{ skill_id }', StarPlayerPointsController::class . ':submitSelectedSkill');

$app->post('/player/injure', UpdateController::class . ':addInjury');
$app->post('/player/injure/{ player_id }/lasting', UpdateController::class . ':addLastingInjury');

$app->get('/player/edit/{player_id}', EditController::class . ':getForm');
$app->post('/player/edit/{player_id}', EditController::class . ':save');

$app->post('/player/casualty', UpdateController::class . ':recordCasualty');
$app->post('/player/touchdown', UpdateController::class . ':recordTouchdown');
$app->post('/player/completion', UpdateController::class . ':recordCompletion');

$app->get('/player/retire/{ player_id }', UpdateController::class . ':retireConfirm');
$app->post('/player/retire/{ player_id }', UpdateController::class . ':retire');