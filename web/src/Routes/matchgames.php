<?php
use App\Controllers\MatchGame\PreGameController;
use App\Controllers\MatchGame\PostGameController;
use App\Controllers\MatchGame\ViewController;
use App\Controllers\MatchGame\NoteController;

$app->post('/match/start', PreGameController::class . ':showStartMatchForm');
$app->post('/match/create', PreGameController::class . ':startMatch');

$app->get('/match/{match_id}/gate', PreGameController::class . ':showGateForm');
$app->post('/match/{match_id}/gate', PreGameController::class . ':submitGate');

$app->get('/match/{match_id}/weather', PreGameController::class . ':showWeatherForm');
$app->post('/match/{match_id}/weather', PreGameController::class . ':submitWeather');

$app->get('/match/{match_id}/kickoff', PreGameController::class . ':kickOff');
$app->post('/match/end', PostGameController::class . ':endMatch');
$app->post('/match/{match_id}/update_popularity', PostGameController::class . ':updatePopularity');

$app->get('/match/view/all', ViewController::class . ':listAll');
$app->get('/match/view/{match_id}', ViewController::class . ':view');
$app->get('/match/view/team/{team_id}', ViewController::class . ':listTeamMatches');
$app->get('/match/view/leagues/{league_id}', ViewController::class . ':listLeagueMatches');

$app->post('/match/{match_id}/note', NoteController::class . ':addNote');