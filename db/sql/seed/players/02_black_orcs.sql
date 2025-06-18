-- Goblin Bruiser
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(20, 'Goblin Bruiser', 'Agile goblin with thick skull', 'standard', 2, 6, 2, 3, 4, 8, 45, 12);

INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, primary, secondary) VALUES
(20, 2, 1, 0),  -- Agility (Primary)
(20, 1, 0, 1),  -- General (Secondary)
(20, 4, 0, 1),  -- Passing (Secondary)
(20, 3, 0, 1);  -- Strength (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(20, 11),  -- Dodge
(20, 20),  -- Right Stuff
(20, 67),  -- Stunty
(20, 9);   -- Thick Skull

-- Black Orc
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(21, 'Black Orc', 'Strong and tough orc', 'standard', 2, 4, 4, 4, 5, 10, 90, 6);

INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, primary, secondary) VALUES
(21, 1, 1, 0),  -- General (Primary)
(21, 3, 1, 0),  -- Strength (Primary)
(21, 2, 0, 1),  -- Agility (Secondary)
(21, 4, 0, 1);  -- Passing (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(21, 54),  -- Brawler
(21, 3);   -- Grab

-- Trained Troll
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(22, 'Trained Troll', 'Big guy with multiple traits', 'special', 2, 4, 5, 5, 5, 10, 115, 1);

INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, primary, secondary) VALUES
(22, 3, 1, 0),  -- Strength (Primary)
(22, 2, 0, 1),  -- Agility (Secondary)
(22, 1, 0, 1),  -- General (Secondary)
(22, 4, 0, 1);  -- Passing (Secondary)

INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(22, 49),  -- Always Hungry
(22, 42),  -- Loner (3+)
(22, 2),   -- Mighty Blow (+1)
(22, 63),  -- Projectile Vomit
(22, 43),  -- Really Stupid
(22, 41),  -- Regeneration
(22, 46);  -- Throw Team-Mate

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, special_rule_id) VALUES
(2, 1);

-- Add Team Special Rules
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(2, 1);