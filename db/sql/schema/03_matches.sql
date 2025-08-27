# matches, stats per match

CREATE TABLE game (
    id INT AUTO_INCREMENT PRIMARY KEY,
    home_team_id INT,
    away_team_id INT,
    away_team_name VARCHAR(255),
    league_id INT,
    home_score INT NOT NULL DEFAULT 0,
    away_score INT NOT NULL DEFAULT 0,
    home_fans INT,
    away_fans INT,
    notes TEXT,
    status ENUM('pregame', 'in_progress', 'postgame', 'finished', 'paused') DEFAULT 'pregame',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (home_team_id) REFERENCES team(id),
    FOREIGN KEY (away_team_id) REFERENCES team(id),
    FOREIGN KEY (league_id) REFERENCES league(id)
);