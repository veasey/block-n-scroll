CREATE TABLE default_player_name (
    id INT AUTO_INCREMENT PRIMARY KEY,
    base_team_id INT,
    name VARCHAR(100),
    position VARCHAR(50) NOT NULL,
    FOREIGN KEY (base_team_id) REFERENCES base_team(id)
);

