INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(50, 'Lineman', 'Basic but agile team member', 'standard', 5, 6, 3, 5, 4, 9, 70000, 12, NULL),
(51, 'Runner', 'Fast player with Dump-Off skill', 'standard', 5, 7, 3, 5, 3, 8, 80000, 2, NULL),
(52, 'Blitzer', 'Powerful player with Block skill', 'standard', 5, 7, 3, 5, 4, 9, 100000, 4, NULL),
(53, 'Assassin', 'Stealthy player with Shadowing and Stab', 'special', 5, 7, 3, 5, 5, 8, 85000, 2, 4),
(54, 'Witch Elf', 'Agile and deadly with Dodge, Frenzy, Jump Up', 'special', 5, 7, 3, 5, 5, 8, 110000, 2, 4);

-- Lineman
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(50, 3, 1, 0), -- Agility (AG)
(50, 2, 0, 1); -- Strength (S)

-- Runner
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(51, 3, 1, 0), -- Agility (AG)
(51, 1, 1, 0), -- Passing (P)
(51, 2, 0, 1); -- Strength (S)

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(52, 3, 1, 0), -- Agility (AG)
(52, 2, 1, 0), -- Strength (S)
(52, 1, 0, 1); -- Passing (P)

-- Assassin
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(53, 3, 1, 0), -- Agility (AG)
(53, 2, 1, 0), -- Strength (S)
(53, 1, 0, 1); -- Passing (P)

-- Witch Elf
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(54, 3, 1, 0), -- Agility (AG)
(54, 2, 1, 0), -- Strength (S)
(54, 1, 0, 1); -- Passing (P)


-- Lineman (ID 50) - no starting skills by default

-- Runner (ID 51)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(51, 21); -- Dump-Off

-- Blitzer (ID 52)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(52, 1); -- Block

-- Assassin (ID 53)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(53, 22), -- Shadowing
(53, 23); -- Stab

-- Witch Elf (ID 54)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(54, 11), -- Dodge
(54, 14), -- Frenzy
(54, 24); -- Jump Up

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(5, 2); -- elven kingdom