<?php
use App\Controllers\MatchGame\MatchController;
use App\Controllers\MatchGame\PreGameController;
use App\Controllers\MatchGame\ViewController;

$app->post('/match/start', MatchController::class . ':showStartMatchForm');
$app->post('/match/create', MatchController::class . ':startMatch');

$app->get('/match/{match_id}/gate', PreGameController::class . ':showGateForm');
$app->post('/match/{match_id}/gate', PreGameController::class . ':submitGate');

$app->get('/match/{match_id}/weather', PreGameController::class . ':showWeatherForm');
$app->post('/match/{match_id}/weather', PreGameController::class . ':submitWeather');

$app->get('/match/{match_id}/kickoff', PreGameController::class . ':kickOff');
$app->post('/match/end', MatchController::class . ':endMatch');

$app->get('/match/view/all', ViewController::class . ':listAll');
$app->get('/match/view/{match_id}', ViewController::class . ':view');
$app->get('/match/view/team/{team_id}', ViewController::class . ':listTeamMatches');