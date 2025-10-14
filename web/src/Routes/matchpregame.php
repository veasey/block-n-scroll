<?php

use App\Controllers\MatchGame\PreGameController;
use App\Controllers\MatchGame\PreGame\GateController;
use App\Controllers\MatchGame\PreGame\WeatherController;
use App\Controllers\MatchGame\PreGame\JourneymenController;
use App\Controllers\MatchGame\PreGame\InducementsController;

$app->post('/match/start', PreGameController::class . ':showStartMatchForm');
$app->post('/match/create', PreGameController::class . ':createMatch');

$app->get('/match/continue-pregame-setup', PreGameController::class . ':continuePregameSetup');

$app->get('/match/{match_id}/gate', GateController::class . ':showForm');
$app->post('/match/{match_id}/gate', GateController::class . ':submit');

$app->get('/match/{match_id}/weather', WeatherController::class . ':showWeatherForm');
$app->post('/match/{match_id}/weather', WeatherController::class . ':submitWeather');

$app->get('/match/{match_id}/journeymen', JourneymenController::class . ':showJourneymenForm');
$app->post('/match/{match_id}/journeymen', JourneymenController::class . ':submitJourneymen');

$app->get('/match/{match_id}/inducements', InducementsController::class . ':showInducementsForm');
$app->post('/match/{match_id}/inducements', InducementsController::class . ':submitInducements');

$app->get('/match/{match_id}/kickoff', PreGameController::class . ':kickOff');
