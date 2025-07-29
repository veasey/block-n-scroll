<?php
use App\Controllers\Players\ViewController;

$app->get('/player/view/{ player_id }[.{format}]', ViewController::class . ':view');