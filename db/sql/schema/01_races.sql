# races and positions

CREATE TABLE races (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    tier INT,
    race_special_rules_id INT DEFAULT NULL,  -- FK to team_special
    regional_special_rules_id INT DEFAULT NULL,  -- FK to regional_special
);

CREATE TABLE race_special_rules (
    id INT AUTO_INCREMENT PRIMARY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE regional_special_rules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);


CREATE TABLE player_position (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    category ENUM('standard', 'special', 'star') DEFAULT 'standard',
    race_id INT,
    regional_special_rules_id INT DEFAULT NULL,  -- FK to regional_special
    exclusive_group_id INT DEFAULT NULL,  -- FK to player_position_exclusive_group
    ma INT,
    st INT,
    ag INT,
    pa INT,
    av INT,
    primary_skills ENUM('Agility', 'General', 'Mutations', 'Passing', 'Strength') DEFAULT 'General',
    secondary_skills ENUM('Agility', 'General', 'Mutations', 'Passing', 'Strength') DEFAULT 'Agility',
    cost INT,
    max_count INT DEFAULT 0,  -- 0 means unlimited
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (race_id) REFERENCES races(id)
);

/** * This table is used to group player positions that share exclusive characteristics,
 * such as being part of a specific team or having unique abilities.
 * It can be used to enforce rules like "only one player from this group can be on the field at a time".
 */
CREATE TABLE player_position_exclusive_group (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);