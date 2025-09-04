/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 28;

/* Cannot have an apothecary */
UPDATE base_team SET apothecary_allowed = false WHERE id = 28;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(280, 'Skeleton Linemen', 'Cheap, resilient but a bit slow', 'standard', 28, 5, 3, 4, 6, 8, 40000, 16),
(281, 'Anointed Thrower', 'Ball Handler', 'standard', 28, 6, 3, 4, 3, 8, 70000, 2),
(282, 'Anointed Blitzer', 'Blitzer', 'standard', 28, 6, 3, 4, 6, 9, 90000, 2),
(283, 'Tomb Guardian', 'Reliable Big Guy', 'standard', 28, 4, 5, 5, NULL, 10, 100000, 4);

/* Skeleton Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(280, 1, 1, 0), -- General
(280, 2, 0, 1), -- Agility
(280, 3, 0, 1); -- Strength

/* Anointed Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(281, 1, 1, 0), -- General
(281, 4, 1, 0), -- Passing
(281, 2, 0, 1); -- Agility

/* Anointed Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(282, 1, 1, 0), -- General
(282, 3, 1, 0), -- Strength
(282, 2, 0, 1), -- Agility
(282, 4, 0, 1); -- Passing

/* Tomb Guardian - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(283, 3, 1, 0), -- Strength
(283, 2, 0, 1), -- Agility
(283, 1, 1, 0); -- General

/* Skeleton Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(280, 90), -- Regeneration
(280, 54); -- Thick Skull

/* Anointed Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(281, 90), -- Regeneration
(281, 54), -- Thick Skull
(281, 12), -- Sure Hands
(281, 37); -- Pass

/* Anointed Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(282, 90), -- Regeneration
(282, 54), -- Thick Skull
(282, 1);  -- Block

/* Mummies - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(283, 90), -- Regeneration
(283, 76); -- Decay

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(28, 6); -- Sylvanian Spotlight