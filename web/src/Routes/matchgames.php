<?php
use App\Controllers\MatchGame\MatchGameController;

$app->post('/match/start', MatchGameController::class . ':showStartMatchForm');
$app->post('/match/create', MatchGameController::class . ':startMatch');
$app->post('/match/end', MatchGameController::class . ':endMatch');

$app->get('/match/view/all', MatchGameController::class . ':listAll');
$app->get('/match/view/{match_id}', MatchGameController::class . ':view');
$app->get('/match/view/team/{team_id}', MatchGameController::class . ':listTeamMatches');