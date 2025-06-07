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

CREATE TABLE player_match_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    touchdowns INT DEFAULT 0,
    casualties INT DEFAULT 0,
    completions INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    mvps INT DEFAULT 0,
    spp_earned INT DEFAULT 0,
    injuries_sustained TEXT,
    FOREIGN KEY (match_id) REFERENCES matches(id),
    FOREIGN KEY (player_id) REFERENCES players(id)
);