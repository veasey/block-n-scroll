# matches, stats per match

CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    home_team_id INT,
    away_team_id INT,
    league_id INT,
    date_played DATE,
    home_score INT,
    away_score INT,
    notes TEXT,
    FOREIGN KEY (home_team_id) REFERENCES teams(id),
    FOREIGN KEY (away_team_id) REFERENCES teams(id),
    FOREIGN KEY (league_id) REFERENCES leagues(id)
);