# races and positions

CREATE TABLE base_team (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    tier INT,
    category_race_special_rule_id INT DEFAULT NULL,  -- FK to team_special
    category_regional_special_rule_id INT DEFAULT NULL,  -- FK to regional_special
    reroll_cost INT DEFAULT 0,  -- Cost of a team reroll
    max_rerolls INT DEFAULT 8,  -- Maximum number of rerolls a team can have
    is_hidden BOOLEAN DEFAULT FALSE,  -- Whether the team is hidden
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE category_race_special_rule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE category_regional_special_rule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);


CREATE TABLE base_team_player (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    category ENUM('standard', 'special', 'star') DEFAULT 'standard',
    base_team_id INT,
    exclusive_group_id INT DEFAULT NULL,  -- FK to player_position_exclusive_group
    ma INT,
    st INT,
    ag INT,
    pa INT,
    av INT,
    primary_skills ENUM('Agility', 'General', 'Mutations', 'Passing', 'Strength') DEFAULT 'General',
    secondary_skills ENUM('Agility', 'General', 'Mutations', 'Passing', 'Strength') DEFAULT 'Agility',
    secondary_skills_additional ENUM('Agility', 'General', 'Mutations', 'Passing', 'Strength') DEFAULT NULL,
    cost INT,
    category_regional_special_rule_id INT DEFAULT NULL,  -- FK to regional_special_rule, added for star players
    max_count INT DEFAULT 0,  -- 0 means unlimited
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (base_team_id) REFERENCES base_team(id)
);

/** * This table is used to group player positions that share exclusive characteristics,
 * such as being part of a specific team or having unique abilities.
 * It can be used to enforce rules like "only one player from this group can be on the field at a time".
 */
CREATE TABLE base_team_player_exclusive_group (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);