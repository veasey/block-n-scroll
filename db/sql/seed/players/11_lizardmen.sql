/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 11;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(110, 'Skink Linemen', 'Stunty with dodge', 'standard', 11, 8, 2, 3, 4, 8, 60000, 12),
(111, 'Chameleon Skink', 'Stunty to scoop up the loose ball', 'special', 11, 7, 2, 3, 3, 8, 70000, 2),
(112, 'Saurus Blocker', 'Strength 4 blocker', 'special', 11, 6, 4, 5, 6, 10, 85000, 8),
(113, 'Kroxigor', 'A big guy that you cannot dodge away from', 'special', 11, 6, 5, 5, NULL, 10, 140000, 1);

/* Skink Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(110, 4, 1, 0),  -- A
(110, 3, 0, 1),  -- G
(110, 1, 0, 1),  -- P
(110, 2, 0, 1);  -- S

/* Chameleon Skink - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(111, 4, 1, 0),  -- A
(111, 3, 0, 1),  -- G
(111, 1, 0, 1),  -- P
(111, 2, 0, 1);  -- S

/* Saurus Blocker - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(112, 3, 1, 0),  -- G
(112, 2, 1, 0),  -- S
(112, 1, 0, 1);  -- A

/* Kroxigor - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(113, 2, 1, 0),  -- S
(113, 4, 0, 1),  -- A
(113, 3, 0, 1);  -- G

/* Skink Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(110, 19),  -- Dodge
(110, 95);  -- Stunty

/* Chameleon Skink - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(111, 19),  -- Dodge
(111, 10),  -- Shadowing
(111, 36),  -- On the ball
(111, 95);  -- Stunty

/* Saurus Blocker - Starting Skills */
/* NO SKILLS */

/* Kroxigor - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(113, 73),  -- Bone-head
(113, 82),  -- Loner
(113, 48),  -- Mighty Blow
(113, 63),  -- Prehensile Tail
(113, 54);  -- Thick Skull


/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(11, 4);  -- Old World Classic
