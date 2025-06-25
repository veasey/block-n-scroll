/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 16;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(160, 'Skaven Lineman', 'Cheap, fast, weak', 'standard', 
16, 7, 3, 3, 4, 8, 50000, 16),
(161, 'Skaven Thrower', 'Sometimes brought to throw to handoff to gutter runner', 'standard', 
16, 7, 3, 4, 2, 8, 85000, 2),
(162, 'Skaven Gutter Runner', 'Touchdown Scorer', 'standard', 
16, 9, 2, 2, 4, 8, 85000, 4),
(163, 'Skaven Blitzer', 'Blitzer', 'standard', 
16, 7, 3, 3, 5, 9, 90000, 2),
(164, 'Rat Ogre', 'Big Guy', 'standard', 
16, 6, 5, 4, NULL, 9, 150000, 1);

/* Skaven Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(160, 3, 1, 0),  -- G
(160, 4, 0, 1),  -- A
(160, 5, 0, 1),  -- M
(160, 2, 0, 1);  -- S

/* Skaven Thrower - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(161, 3, 1, 0),  -- G
(161, 1, 1, 0),  -- P
(161, 4, 0, 1),  -- A
(161, 5, 0, 1),  -- M
(161, 2, 0, 1);  -- S

/* Skaven Gutter Runner - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(162, 4, 1, 0),  -- A
(162, 3, 1, 0),  -- G
(162, 1, 0, 1),  -- P
(162, 5, 0, 1),  -- M
(162, 2, 0, 1);  -- S

/* 	Skaven Blitzer - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(163, 3, 1, 0),  -- G
(163, 2, 1, 0),  -- S
(163, 4, 0, 1),  -- A
(163, 5, 0, 1),  -- M
(163, 1, 0, 1);  -- P

/*	Rat Ogre - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(164, 2, 1, 0),  -- S
(164, 1, 0, 1),  -- A
(164, 3, 0, 1),  -- G
(164, 5, 0, 1);  -- M

/* Skaven Linemen - Starting Skills */
/* No skills */

/* Skaven Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(161, 37),  -- Pass
(161, 12);  -- Sure Hands

/* Skaven Gutter Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(162, 19); -- Dodge

/* Skaven Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(163, 1);  -- Block

/* Rat Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(164, 68),  -- Animal Savagery
(164, 5),   -- Frenzy
(164, 82),  -- Loner
(164, 48),  -- Mighty Blow
(164, 63);  -- Prehensile Tail

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(16, 7); -- Underworld Challenge