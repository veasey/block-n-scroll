INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(30, 'Chosen Blocker', 'Core strength-focused warrior', 'standard', 3, 5, 4, 3, 5, 10, 100, 4, NULL),
(31, 'Chaos Beastman', 'Versatile player with horns', 'standard', 3, 6, 3, 3, 4, 9, 60, 16, NULL),
(32, 'Chaos Minotaur', 'Ferocious big guy with Frenzy', 'special', 3, 5, 5, 4, NULL, 9, 150, 1, 1), 
(33, 'Chaos Troll', 'Massive, regenerating brute with Really Stupid', 'special', 3, 4, 5, 5, 5, 10, 115, 1, 1),
(34, 'Chaos Ogre', 'Big guy with Bone Head and solid armour', 'special', 3, 5, 5, 4, 5, 10, 140, 1, 1);

INSERT INTO base_team_player_exclusive_group
(id, name, description)
VALUES
(1, 'Chaos Big Guys', 'Group for Chaos big guys like Minotaur, Troll, and Ogre');

-- Chosen Blocker skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(30, 2, 1, 0),  -- Strength
(30, 1, 0, 1), -- General
(30, 3, 0, 1); -- Agility

-- Chaos Beastman skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(31, 1, 1, 0),  -- General
(31, 2, 0, 1), -- Strength
(31, 3, 0, 1), -- Agility
(31, 4, 0, 1); -- Passing

-- Chaos Minotaur skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(32, 2, 1, 0),  -- Strength
(32, 5, 0, 1), -- Mutations
(32, 3, 0, 1), -- Agility
(32, 1, 0, 1); -- General

-- Chaos Troll skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(33, 2, 1, 0),  -- Strength
(33, 5, 0, 1), -- Mutations
(33, 3, 0, 1), -- Agility
(33, 1, 0, 1); -- General

-- Chaos Ogre skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(34, 2, 1, 0),  -- Strength
(34, 5, 0, 1), -- Mutations
(34, 3, 0, 1), -- Agility
(34, 1, 0, 1); -- General

-- Beastman starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(31, 14);  -- Horns

-- Minotaur starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(32, 5),   -- Frenzy
(32, 2),   -- Mighty Blow
(32, 6),   -- Thick Skull
(32, 33),  -- Loner
(32, 14),  -- Horns
(32, 46);  -- Unchannelled Fury

-- Troll starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(33, 3),   -- Regeneration
(33, 2),   -- Mighty Blow
(33, 6),   -- Thick Skull
(33, 33),  -- Loner
(33, 42),  -- Really Stupid
(33, 40),  -- Always Hungry
(33, 41);  -- Projectile Vomit

-- Ogre starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(34, 2),   -- Mighty Blow
(34, 6),   -- Thick Skull
(34, 33),  -- Loner
(34, 43),  -- Bone Head
(34, 41);  -- Throw Team Mate

-- Add Team Special Rules
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(3, 4);