<?php
use App\Controllers\MatchGame\MatchGameController;

$app->post('/match/start', MatchGameController::class . ':showStartMatchForm');
$app->post('/match/create', MatchGameController::class . ':startMatch');
$app->post('/match/end', MatchGameController::class . ':endMatch');