CREATE TABLE event_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    coach_id INT,                  -- who triggered the event
    team_id INT,                  -- which team it involved (if any)
    player_id INT,                -- which player it involved (if any)
    match_id INT,                 -- which match it relates to (if any)
    league_id INT NULL,            -- which league it relates to (if any)
    event_type VARCHAR(50) NOT NULL,               -- e.g. 'INJURY', 'coach_UPDATE', 'MATCH_SCORE'
    event_key VARCHAR(100) NULL,                   -- optional specific key like 'email_updated' or 'injury_roll'
    event_value TEXT NULL,                         -- optional JSON string or value
    notes TEXT NULL,                               -- optional admin/debug notes
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    -- Indexes for performance
    INDEX idx_event_type (event_type),
    INDEX idx_team_id (team_id),
    INDEX idx_player_id (player_id),
    INDEX idx_match_id (match_id),
    INDEX idx_coach_id (coach_id),
    INDEX idx_league_id (league_id),

    FOREIGN KEY (coach_id) REFERENCES coach(id) ON DELETE SET NULL,
    FOREIGN KEY (team_id) REFERENCES team(id) ON DELETE SET NULL,
    FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE SET NULL,
    FOREIGN KEY (match_id) REFERENCES `match`(id) ON DELETE SET NULL
);
