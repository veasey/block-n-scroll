/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 14;

/* Cannot have an apothecary */
UPDATE base_team SET apothecary_allowed = false WHERE id = 14;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(140, 'Skeleton Linemen', 'Cheap, resilient but a bit slow', 'standard', 14, 5, 3, 4, 6, 8, 40000, 12),
(141, 'Zombie Linemen', 'Bit tougher, bit slower linemen', 'standard', 14, 4, 3, 4, NULL, 9, 40000, 2),
(142, 'Ghoul Runner', 'Ball Handler', 'standard', 14, 7, 3, 3, 4, 8, 75000, 4),
(143, 'Wight Blitzer', 'Blitzer', 'standard', 14, 6, 3, 3, 5, 9, 90000, 2),
(144, 'Mummie', 'Big Guy', 'standard', 14, 3, 5, 5, NULL, 10, 125000, 2);

/* Skeleton Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(140, 3, 1, 0), -- General
(140, 4, 0, 1), -- Agility
(140, 2, 0, 1); -- Strenth

/* Zombie Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(141, 3, 1, 0), -- General
(141, 4, 0, 1), -- Agility
(141, 2, 0, 1); -- Strength

/* Ghoul Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(142, 4, 1, 0), -- Agility
(142, 3, 1, 0), -- General
(142, 1, 0, 1), -- Passing
(142, 2, 0, 1); -- Strength

/* 	Weight Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(143, 3, 1, 0), -- General
(143, 2, 1, 0), -- Strength
(143, 4, 0, 1), -- Agility
(143, 1, 0, 1); -- Passing

/*	Mummies - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(144, 2, 1, 0), -- Strength
(144, 1, 0, 1), -- Agility
(144, 3, 0, 1); -- General

/* Skeleton Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(140, 90), -- Regeneration
(140, 54); -- Thick Skull

/* Zombie Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(141, 90); -- Regeneration

/* Ghoul Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(142, 19); -- Dodge

/* Weight Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(143, 1),  -- Block
(143, 90); -- Regeneration

/* Mummies - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(144, 48), -- Mighty Blow
(144, 90); -- Regeneration

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(14, 3); -- Master of Undeath

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(14, 6); -- Sylvanian Spotlight