/* reroll cost */
UPDATE base_team SET reroll_cost = 50000 WHERE id = 16;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(160, 'Wood Elf Lineman', 'Linemen', 'standard', 16, 7, 3, 2, 4, 8, 70000, 12),
(161, 'Wood Elf Thrower', 'Throwey Elf', 'standard', 16, 7, 3, 2, 2, 8, 95000, 2),
(162, 'Wood Elf Catcher', 'Catchy Elf', 'standard', 16, 8, 2, 2, 4, 8, 90000, 4),
(163, 'Wardancer', 'Blitzer', 'standard', 16, 8, 3, 2, 4, 8, 125000, 2),
(164, 'Loren Forest Treeman', 'Big Guy', 'standard', 16, 2, 6, 5, 5, 11, 120000, 1);

/* Wood Elf Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(160, 4, 1, 0), -- Agility
(160, 3, 1, 0), -- General
(160, 2, 0, 1); -- Strength

/* Wood Elf Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(161, 4, 1, 0), -- Agility
(161, 3, 1, 0), -- General
(161, 1, 1, 0), -- Passing
(161, 2, 0, 1); -- Strength

/* Wood Elf Catcher - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(162, 4, 1, 0), -- Agility
(162, 3, 1, 0), -- General
(162, 1, 0, 1), -- Passing
(162, 2, 0, 1); -- Strength

/* Wardancer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(163, 4, 1, 0), -- Agility
(163, 3, 1, 0), -- General
(163, 1, 0, 1), -- Passing
(163, 2, 0, 1); -- Strength

/* Treeman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(164, 2, 1, 0), -- Strength
(164, 1, 0, 1), -- Agility
(164, 3, 0, 1); -- General

/* Wood Elf Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(161, 37); -- Passingass

/* Wood Elf Catcher- Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(162, 19), -- Dodge
(162, 15); -- Catch

/* Wardabcer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(163, 1),  -- Block
(163, 19), -- Dodge
(163, 21); -- Leap

/* Treeman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(164, 82), -- Loner
(164, 48), -- Mighty Blow
(164, 52), -- Stand Firm
(164, 53), -- Strong Arm
(164, 98), -- Take Root
(164, 54), -- Thick Skull
(164, 99); -- Throw Team Mate

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(16, 2); -- Elven Kingdoms League