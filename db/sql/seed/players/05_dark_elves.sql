INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(50, 'Lineman', 'Basic but agile team member', 'standard', 5, 6, 3, 5, 4, 9, 70000, 12, NULL),
(51, 'Runner', 'Fast player with Dump-Off skill', 'standard', 5, 7, 3, 5, 3, 8, 80000, 2, NULL),
(52, 'Blitzer', 'Powerful player with Block skill', 'standard', 5, 7, 3, 5, 4, 9, 100000, 4, NULL),
(53, 'Assassin', 'Stealthy player with Shadowing and Stab', 'special', 5, 7, 3, 5, 5, 8, 85000, 2, 4),
(54, 'Witch Elf', 'Agile and deadly with Dodge, Frenzy, Jump Up', 'special', 5, 7, 3, 5, 5, 8, 110000, 2, 4);

-- Lineman
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(50, 3, 'primary'), -- Agility (AG)
(50, 2, 'secondary'); -- Strength (S)

-- Runner
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(51, 3, 'primary'), -- Agility (AG)
(51, 1, 'primary'), -- Passing (P)
(51, 2, 'secondary'); -- Strength (S)

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(52, 3, 'primary'), -- Agility (AG)
(52, 2, 'primary'), -- Strength (S)
(52, 1, 'secondary'); -- Passing (P)

-- Assassin
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(53, 3, 'primary'), -- Agility (AG)
(53, 2, 'primary'), -- Strength (S)
(53, 1, 'secondary'); -- Passing (P)

-- Witch Elf
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(54, 3, 'primary'), -- Agility (AG)
(54, 2, 'primary'), -- Strength (S)
(54, 1, 'secondary'); -- Passing (P)


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
INSERT INTO base_team_regional_rule (base_team_id, special_rule_id) VALUES
(5, 2); -- elven kingdom