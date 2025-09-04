/* reroll cost */
UPDATE base_team SET reroll_cost = 70000 WHERE id = 10;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(100, 'Skink Linemen', 'Stunty with dodge', 'standard', 10, 8, 2, 3, 4, 8, 60000, 12),
(101, 'Chameleon Skink', 'Stunty to scoop up the loose ball', 'special', 10, 7, 2, 3, 3, 8, 70000, 2),
(102, 'Saurus Blocker', 'Strength 4 blocker', 'special', 10, 6, 4, 5, 6, 10, 85000, 8),
(103, 'Kroxigor', 'A big guy that you cannot dodge away from', 'special', 10, 6, 5, 5, NULL, 10, 140000, 1);

/* Skink Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(100, 2, 1, 0), -- Agility
(100, 1, 0, 1), -- General
(100, 4, 0, 1), -- Passing
(100, 3, 0, 1); -- Strength

/* Chameleon Skink - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(101, 2, 1, 0), -- Agility
(101, 1, 0, 1), -- General
(101, 4, 0, 1), -- Passing
(101, 3, 0, 1); -- Strength

/* Saurus Blocker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(102, 1, 1, 0), -- General
(102, 3, 1, 0), -- Strength
(102, 2, 0, 1); -- Agility

/* Kroxigor - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(103, 3, 1, 0), -- Strength
(103, 2, 0, 1), -- Agility
(103, 1, 0, 1); -- General

/* Skink Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(100, 19), -- Dodge
(100, 95); -- Strengthtunty

/* Chameleon Skink - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(101, 19), -- Dodge
(101, 10), -- Strengthhadowing
(101, 36), -- On the ball
(101, 95); -- Strengthtunty

/* Kroxigor - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(103, 73), -- Bone-head
(103, 82), -- Loner
(103, 48), -- Mighty Blow
(103, 63), -- Passingrehensile Tail
(103, 54); -- Thick Skull

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(10, 4); -- Lustrian SuperLeague
