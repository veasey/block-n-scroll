/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 4;

-- Hobgoblin: ID 40
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(40, 'Hobgoblin', 'Sneaky and expendable slaves for the Chaos Dwarfs.', 'standard', 4, 6, 3, 3, 4, 8, 40000, 16, NULL);

-- Chaos Dwarf Blocker: ID 41
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(41, 'Chaos Dwarf Blocker', 'Stubborn and tough core of the team.', 'standard', 4, 4, 3, 4, 6, 10, 70000, 6, NULL);

-- Bull Centaur: ID 42
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(42, 'Bull Centaur', 'Fast, powerful and resilient hybrid.', 'special', 4, 6, 4, 4, 6, 10, 130000, 2, NULL);

-- Enslaved Minotaur: ID 43
INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(43, 'Enslaved Minotaur', 'Feral big guy under Chaos Dwarf control.', 'special', 4, 5, 5, 4, NULL, 9, 150000, 1, 2);

-- Hobgoblin (ID 40)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(40, 1, 1, 0),  -- General
(40, 2, 0, 1), -- Strength
(40, 3, 0, 1); -- Agility

-- Chaos Dwarf Blocker (ID 41)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(41, 1, 1, 0),  -- General
(41, 2, 1, 0),  -- Strength
(41, 3, 0, 1), -- Agility
(41, 5, 0, 1); -- Mutations

-- Bull Centaur (ID 42)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(42, 1, 1, 0),  -- General
(42, 2, 1, 0),  -- Strength
(42, 3, 0, 1); -- Agility

-- Enslaved Minotaur (ID 43)
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(43, 2, 1, 0),  -- Strength
(43, 1, 0, 1), -- General
(43, 3, 0, 1), -- Agility
(43, 5, 0, 1); -- Mutations

-- Hobgoblin: No starting skills

-- Chaos Dwarf Blocker (ID 41)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(41, 1),  -- Block
(41, 2),  -- Tackle
(41, 3);  -- Thick Skull

-- Bull Centaur (ID 42)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(42, 4),  -- Sprint
(42, 5),  -- Sure Feet
(42, 3);  -- Thick Skull

-- Enslaved Minotaur (ID 43)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(43, 6),  -- Animal Savagery
(43, 7),  -- Frenzy
(43, 8),  -- Horns
(43, 9),  -- Loner (4+)
(43, 10), -- Mighty Blow (+1)
(43, 3);  -- Thick Skull

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(4, 1), -- badlands brawl
(4, 8); -- world's edge

-- Add Team Special Rules
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(4, 4); -- favoured of