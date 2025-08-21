<?php
use App\Controllers\Leagues\ViewController;

$app->get('/leagues', ViewController::class . ':list');
