/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 17;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(170, 'Wood Elf Lineman', 'Linemen', 'standard', 
17, 7, 3, 2, 4, 8, 70000, 12),
(171, 'Wood Elf Thrower', 'Throwey Elf', 'standard', 
17, 7, 3, 2, 2, 8, 95000, 2),
(172, 'Wood Elf Catcher', 'Catchy Elf', 'standard', 
17, 8, 2, 2, 4, 8, 90000, 4),
(173, 'Wardancer', 'Blitzer', 'standard', 
17, 8, 3, 2, 4, 8, 125000, 2),
(174, 'Loren Forest Treeman', 'Big Guy', 'standard', 
17, 2, 6, 5, 5, 11, 120000, 1);

/* Wood Elf Lineman - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(170, 4, 1, 0),  -- A
(170, 3, 1, 0),  -- G
(170, 2, 0, 1);  -- S

/* Wood Elf Thrower - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(171, 4, 1, 0),  -- A
(171, 3, 1, 0),  -- G
(171, 1, 1, 0),  -- P
(171, 2, 0, 1);  -- S

/* Wood Elf Catcher - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(172, 4, 1, 0),  -- A
(172, 3, 1, 0),  -- G
(172, 1, 0, 1),  -- P
(172, 2, 0, 1);  -- S

/* Wardancer - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(173, 4, 1, 0),  -- A
(173, 3, 1, 0),  -- G
(173, 1, 0, 1),  -- P
(173, 2, 0, 1);  -- S

/* Treeman - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(174, 2, 1, 0),  -- S
(174, 1, 0, 1),  -- A
(174, 3, 0, 1);  -- G

/* Wood Elf Linemen - Starting Skills */
/* No skills */

/* Wood Elf Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(171, 37);  -- Pass

/* Wood Elf Catcher- Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(172, 19), -- Dodge
(172, 15); -- Catch

/* Wardabcer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(173, 1),  -- Block
(173, 19), -- Dodge
(173, 21); -- Leap

/* Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(174, 82),  -- Loner
(174, 48),  -- Mighty Blow
(174, 52),  -- Stand Firm
(174, 53),  -- Strong Arm
(174, 98),  -- Take Root
(174, 54),  -- Thick Skull
(174, 99);  -- Throw Team Mate

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(17, 2); -- Elven Kingdoms League