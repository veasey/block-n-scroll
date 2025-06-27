INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(20, 'Goblin Bruiser', 'Agile goblin with thick skull', 'standard', 2, 6, 2, 3, 4, 8, 45000, 12),
(21, 'Black Orc', 'Strong and tough orc', 'standard', 2, 4, 4, 4, 5, 10, 90000, 6),
(22, 'Trained Troll', 'Big guy with multiple traits', 'special', 2, 4, 5, 5, 5, 10, 115000, 1);

/* Goblin Bruiser - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(20, 2, 1, 0),  -- Agility (Primary)
(20, 1, 0, 1),  -- General (Secondary)
(20, 4, 0, 1),  -- Passing (Secondary)
(20, 3, 0, 1);  -- Strength (Secondary)

/* Black Orc - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(21, 1, 1, 0),  -- General (Primary)
(21, 3, 1, 0),  -- Strength (Primary)
(21, 2, 0, 1),  -- Agility (Secondary)
(21, 4, 0, 1);  -- Passing (Secondary)

/* Trained Troll - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(22, 3, 1, 0),  -- Strength (Primary)
(22, 2, 0, 1),  -- Agility (Secondary)
(22, 1, 0, 1),  -- General (Secondary)
(22, 4, 0, 1);  -- Passing (Secondary)

/* Goblin Bruiser - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(20, 19),  -- Dodge
(20, 91),  -- Right Stuff
(20, 95),  -- Stunty
(20, 54);  -- Thick Skull

/* Black Orc - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(21, 43),  -- Brawler
(21, 45);   -- Grab

/* Trained Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(22, 67),  -- Always Hungry
(22, 42),  -- Loner (3+)
(22, 48),   -- Mighty Blow (+1)
(22, 88),  -- Projectile Vomit
(22, 89),  -- Really Stupid
(22, 90),  -- Regeneration
(22, 99);  -- Throw Team-Mate

/* Add Team to Region */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(2, 1);

/* Add Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(2, 1);