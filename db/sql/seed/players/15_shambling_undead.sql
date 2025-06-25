/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 15;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(150, 'Skeleton Linemen', 'Cheap, resilient but a bit slow', 'standard', 
15, 5, 3, 4, 6, 8, 40000, 12),
(151, 'Zombie Linemen', 'Bit tougher, bit slower linemen', 'standard', 
15, 4, 3, 4, NULL, 9, 40000, 2),
(152, 'Ghoul Runner', 'Ball Handler', 'standard', 
15, 7, 3, 3, 4, 8, 75000, 4),
(153, 'Wight Blitzer', 'Blitzer', 'standard', 
15, 6, 3, 3, 5, 9, 90000, 2),
(154, 'Mummie', 'Big Guy', 'standard', 
15, 3, 5, 5, NULL, 10, 125000, 2);

/* Skeleton Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(150, 3, 1, 1),  -- G
(150, 4, 0, 1),  -- A
(150, 2, 0, 1);  -- S

/* Zombie Linemen - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(151, 3, 1, 1),  -- G
(151, 4, 0, 1),  -- A
(151, 2, 0, 1);  -- S


/* Ghoul Runner - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(152, 4, 1, 0),  -- A
(152, 3, 1, 0),  -- G
(152, 1, 0, 1),  -- P
(152, 2, 0, 1);  -- S

/* 	Weight Blitzer - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(153, 3, 1, 0),  -- G
(153, 2, 1, 0),  -- S
(153, 4, 0, 1),  -- A
(153, 1, 0, 1);  -- P

/*	Mummies - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(154, 2, 1, 0),  -- S
(154, 1, 0, 1),  -- A
(154, 3, 0, 1);  -- G

/* Skeleton Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(150, 90),  -- Regeneration
(150, 54);  -- Thick Skull

/* Zombie Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(151, 90);  -- Regeneration

/* Ghoul Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(152, 19);

/* Weight Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(153, 1),  -- Block
(153, 90); -- Regeneration

/* Mummies - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(154, 48),  -- Mighty Blow
(154, 90);  -- Regeneration

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(15, 3); -- Master of Undeath

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(15, 6); -- Sylvanian Spotlight