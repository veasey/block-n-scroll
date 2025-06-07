CREATE TABLE default_player_names (
    id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    name VARCHAR(100),
    position VARCHAR(50) NOT NULL,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

