/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 4;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(40, 'Lineman', 'Basic but agile team member', 'standard', 4, 6, 3, 5, 4, 9, 70000, 12, NULL),
(41, 'Runner', 'Fast player with Dump-Off skill', 'standard', 4, 7, 3, 5, 3, 8, 80000, 2, NULL),
(42, 'Blitzer', 'Powerful player with Block skill', 'standard', 4, 7, 3, 5, 4, 9, 100000, 4, NULL),
(43, 'Assassin', 'Stealthy player with Shadowing and Stab', 'special', 4, 7, 3, 5, 5, 8, 85000, 2, 4),
(44, 'Witch Elf', 'Agile and deadly with Dodge, Frenzy, Jump Up', 'special', 4, 7, 3, 5, 5, 8, 110000, 2, 4);

/* Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(40, 3, 1, 0), -- Agility (AG)
(40, 2, 0, 1); -- Strength (S)

/* Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(41, 3, 1, 0), -- Agility (AG)
(41, 1, 1, 0), -- Passing (P)
(41, 2, 0, 1); -- Strength (S)

/* Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(42, 3, 1, 0), -- Agility (AG)
(42, 2, 1, 0), -- Strength (S)
(42, 1, 0, 1); -- Passing (P)

/* Assassin - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(43, 3, 1, 0), -- Agility (AG)
(43, 2, 1, 0), -- Strength (S)
(43, 1, 0, 1); -- Passing (P)

/* Witch Elf - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(44, 3, 1, 0), -- Agility (AG)
(44, 2, 1, 0), -- Strength (S)
(44, 1, 0, 1); -- Passing (P)


/* Lineman - Starting Skills */
/* No starting skills for Lineman */

/* Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(41, 30); -- Dump-Off

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(42, 1); -- Block

/* Assassin - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(43, 10), -- Shadowing
(43, 93); -- Stab

/* Witch Elf - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(44, 19), -- Dodge
(44, 5),  -- Frenzy
(44, 20); -- Jump Up

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(4, 2); -- elven kingdom