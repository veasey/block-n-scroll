<?php

use App\Controllers\Players\EditController;
use App\Controllers\Players\StarPlayerPointsController;
use App\Controllers\Players\StarPlayerPoints\SkillsController;
use App\Controllers\Players\StarPlayerPoints\CharacteristicsController;
use App\Controllers\Players\UpdateController;
use App\Controllers\Players\ViewController;
use App\Controllers\Players\ViewLogController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');
$app->get('/player/view/{ player_id }/log/{log_type}[.{format}]', ViewLogController::class . ':viewLog');

$app->get('/player/spp/{ player_id }', StarPlayerPointsController::class . ':getStarPlayerPointsForm');
$app->get('/player/spp/{ player_id }/select_primary', SkillsController::class . ':getPrimarySkillSelectForm');
$app->get('/player/spp/{ player_id }/select_secondary', SkillsController::class . ':getSecondarySkillSelectForm');
$app->get('/player/spp/{ player_id }/random_primary', SkillsController::class . ':getPrimarySkillRandomForm');
$app->post('/player/spp/{ player_id }/random_primary', SkillsController::class . ':submitRandomPrimarySkill');
$app->get('/player/spp/{ player_id }/random_secondary', SkillsController::class . ':getSecondarySkillRandomForm');
$app->post('/player/spp/{ player_id }/random_secondary', SkillsController::class . ':submitRandomSecondarySkill');
$app->get('/player/spp/{ player_id }/purchase_primary/{ skill_id }', SkillsController::class . ':submitSelectedPrimarySkill');
$app->get('/player/spp/{ player_id }/purchase_secondary/{ skill_id }', SkillsController::class . ':submitSelectedSecondarySkill');
$app->get('/player/spp/{ player_id }/characteristic', CharacteristicsController::class . ':getCharacteristicForm');

$app->post('/player/injure', UpdateController::class . ':addInjury');
$app->post('/player/injure/{ player_id }/lasting', UpdateController::class . ':addLastingInjury');

$app->get('/player/edit/{player_id}', EditController::class . ':getForm');
$app->post('/player/edit/{player_id}', EditController::class . ':save');

$app->post('/player/casualty', UpdateController::class . ':recordCasualty');
$app->post('/player/touchdown', UpdateController::class . ':recordTouchdown');
$app->post('/player/completion', UpdateController::class . ':recordCompletion');

$app->get('/player/retire/{ player_id }', UpdateController::class . ':retireConfirm');
$app->post('/player/retire/{ player_id }', UpdateController::class . ':retire');