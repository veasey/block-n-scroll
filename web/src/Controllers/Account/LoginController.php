<?php
namespace App\Controllers\Account;

use Slim\Views\Twig;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Models\Coach;

class LoginController
{
    protected $view;

    public function __construct(Twig $view)
    {
        $this->view = $view;
    }

    public function showLoginForm(Request $request, Response $response, array $args = []): Response
    {
        return $this->view->render($response, 'account/login.twig');
    }

    public function login(Request $request, Response $response, array $args = []): Response
    {
        $data = $request->getParsedBody();
        $username = $data['username'] ?? '';
        $password = $data['password'] ?? '';

        // Validate input
        if (empty($username) || empty($password)) {
            usleep(500000); // 0.5 second delay
            return $this->view->render($response, 'account/login.twig', [
                'error' => 'Username and password are required.',
                'username' => $username
            ]);
        }

        // Find coach by username
        $coach = Coach::where('name', $username)->first();

        // Check if coach exists and password matches
        if ($coach && password_verify($password, $coach->password_hash)) {
            $_SESSION['user_id'] = $coach->id;
            $_SESSION['username'] = $coach->name;
            $_SESSION['successes'][] = 'Welcome '. $coach->name . '!';           
            
            $redirectUrl = $request->getServerParams()['HTTP_REFERER'] ?? '/';
            // Avoid redirecting back to the login page itself
            if (strpos($redirectUrl, '/account/login') !== false) {
                $redirectUrl = '/';
            }
            return $response->withHeader('Location', $redirectUrl)->withStatus(302);
        }

        // Delay to prevent user enumeration
        usleep(500000); // 0.5 second delay

        // On failure, show form with error
        return $this->view->render($response, 'account/login.twig', [
            'error' => 'Invalid username or password.',
            'username' => $username
        ]);
    }

    public function logout(Request $request, Response $response): Response
    {
        unset($_SESSION['user_id']);
        unset($_SESSION['username']);
        return $response->withHeader('Location', '/account/login')->withStatus(302);
    }
}