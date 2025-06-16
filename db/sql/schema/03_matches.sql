# matches, stats per match

CREATE TABLE `match` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    home_team_id INT,
    away_team_id INT,
    league_id INT,
    date_played DATE,
    home_score INT,
    away_score INT,
    notes TEXT,
    FOREIGN KEY (home_team_id) REFERENCES team(id),
    FOREIGN KEY (away_team_id) REFERENCES team(id),
    FOREIGN KEY (league_id) REFERENCES league(id)
);