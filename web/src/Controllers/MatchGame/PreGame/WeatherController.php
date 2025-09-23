<?php
namespace App\Controllers\MatchGame\PreGame;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use InvalidArgumentException;

use Slim\Views\Twig;

use App\Enums\Match\PreGameStatus;
use App\Enums\Match\WeatherTable;
use App\Controllers\MatchGame\Shared\AccessController;
use App\Services\EventLogging\MatchEventLoggingService;

class WeatherController extends AccessController
{
    protected $eventLoggerService;
    protected $view;

    public function __construct(
        MatchEventLoggingService $eventLoggerService,
        Twig $view
    )    
    {
        $this->eventLoggerService = $eventLoggerService;
        $this->view = $view;
    }

    public function showWeatherForm(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        return $this->view->render($response, 'match/start/4_weather.twig', ['match' => $match]);
    }

    public function submitWeather(Request $request, Response $response, array $args)
    {
        [$match, $errorResponse] = $this->getAuthorisedMatchOrFail($request, $response, $args);
        if ($errorResponse) return $errorResponse;
        
        $data = $request->getParsedBody();
        $weatherRoll = (int)($data['weather_roll'] ?? 2);

        try {
            $weather = WeatherTable::fromRoll($weatherRoll);
        } catch (InvalidArgumentException $e) {
            // Handle invalid roll (e.g., redirect back with error)
            return $response->withStatus(400)->write("Invalid weather roll: $weatherRoll");
        }

        // Log the weather (you can store the enum name or value)
        $this->eventLoggerService->logMatchWeather($match, $weather);

        $match->pregame_status = PreGameStatus::JOURNEYMEN;
        $match->save();

        // Redirect to next step
        $url = "/match/{$match->id}/journeymen";
        return $response
            ->withHeader('Location', $url)
            ->withStatus(302);
    }
}