<?php

namespace App\Controller;

use App\Database\Database;

class ApiController
{
    private $db;

    public function __construct()
    {
        $this->db = new Database();
    }

    public function getData()
    {
        $data = $this->db->query("SELECT * FROM your_table_name"); // Replace with your actual table name
        header('Content-Type: application/json');
        echo json_encode($data);
    }
}