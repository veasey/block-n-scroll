<?php
namespace App\Helpers;

class PaginationHelper {

    public function getPaginationParams(int $perPage = 10): array {
        $page = isset($_GET['page']) ? max((int)$_GET['page'], 1) : 1;
        $offset = ($page - 1) * $perPage;
        return [
            'page' => $page,
            'perPage' => $perPage,
            'offset' => $offset,
        ];
    }
}