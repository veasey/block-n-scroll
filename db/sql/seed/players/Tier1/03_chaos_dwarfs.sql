/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 3

-- Hobgoblin: ID 40
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(30, 'Hobgoblin', 'Sneaky and expendable slaves for the Chaos Dwarfs.', 'standard', 3, 6, 3, 3, 4, 8, 40000, 16, NULL);

-- Chaos Dwarf Blocker: ID 41
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(31, 'Chaos Dwarf Blocker', 'Stubborn and tough core of the team.', 'standard', 3, 4, 3, 4, 6, 10, 70000, 6, NULL);

-- Bull Centaur: ID 42
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(32, 'Bull Centaur', 'Fast, powerful and resilient hybrid.', 'special', 3, 6, 4, 4, 6, 10, 130000, 2, NULL);

-- Enslaved Minotaur: ID 43
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(33, 'Enslaved Minotaur', 'Feral big guy under Chaos Dwarf control.', 'special', 3, 5, 5, 4, NULL, 9, 150000, 1, 2);

-- Hobgoblin (ID 40)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(30, 1, 1, 0),  -- General
(30, 2, 0, 1), -- Strength
(30, 3, 0, 1); -- Agility

-- Chaos Dwarf Blocker (ID 41)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(31, 1, 1, 0),  -- General
(31, 2, 1, 0),  -- Strength
(31, 3, 0, 1), -- Agility
(31, 5, 0, 1); -- Mutations

-- Bull Centaur (ID 42)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(32, 1, 1, 0),  -- General
(32, 2, 1, 0),  -- Strength
(32, 3, 0, 1); -- Agility

-- Enslaved Minotaur (ID 43)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(33, 2, 1, 0),  -- Strength
(33, 1, 0, 1), -- General
(33, 3, 0, 1), -- Agility
(33, 5, 0, 1); -- Mutations

-- Hobgoblin: No starting skills

-- Chaos Dwarf Blocker (ID 41)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(31, 1),    -- Block
(31, 13),   -- Tackle
(31, 54);   -- Thick Skull

-- Bull Centaur (ID 42)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(32, 25),   -- Sprint
(32, 26),   -- Sure Feet
(32, 54);   -- Thick Skull

-- Enslaved Minotaur (ID 43)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(33, 68),   -- Animal Savagery
(33, 5),    -- Frenzy
(33, 60),   -- Horns
(33, 82),   -- Loner (4+)
(33, 48),   -- Mighty Blow (+1)
(33, 54);   -- Thick Skull

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(3, 1), -- badlands brawl
(3, 8); -- world's edge

-- Add Team Special Rules
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(3, 4); -- favoured of