INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(170, 'Chosen Blocker', 'Core strength-focused warrior', 'standard', 17, 5, 4, 3, 5, 10, 100000, 4, NULL),
(171, 'Chaos Beastman', 'Versatile player with horns', 'standard', 17, 6, 3, 3, 4, 9, 60000, 16, NULL),
(172, 'Chaos Minotaur', 'Ferocious big guy with Frenzy', 'special', 17, 5, 5, 4, NULL, 9, 150000, 1, 1), 
(173, 'Chaos Troll', 'Massive, regenerating brute with Really Stupid', 'special', 17, 4, 5, 5, 5, 10, 115000, 1, 1),
(174, 'Chaos Ogre', 'Big guy with Bone Head and solid armour', 'special', 17, 5, 5, 4, 5, 10, 140000, 1, 1);

INSERT INTO base_team_player_exclusive_group
(id, name, description)
VALUES
(1, 'Chaos Big Guys', 'Group for Chaos big guys like Minotaur, Troll, and Ogre');

-- Chosen Blocker skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(170, 2, 1, 0),  -- Strength
(170, 1, 0, 1), -- General
(170, 3, 0, 1); -- Agility

-- Chaos Beastman skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(171, 1, 1, 0),  -- General
(171, 2, 0, 1), -- Strength
(171, 3, 0, 1), -- Agility
(171, 4, 0, 1); -- Passing

-- Chaos Minotaur skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(172, 2, 1, 0),  -- Strength
(172, 5, 0, 1), -- Mutations
(172, 3, 0, 1), -- Agility
(172, 1, 0, 1); -- General

-- Chaos Troll skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(173, 2, 1, 0),  -- Strength
(173, 5, 0, 1), -- Mutations
(173, 3, 0, 1), -- Agility
(173, 1, 0, 1); -- General

-- Chaos Ogre skill categories
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(174, 2, 1, 0),  -- Strength
(174, 5, 0, 1), -- Mutations
(174, 3, 0, 1), -- Agility
(174, 1, 0, 1); -- General

-- Beastman starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(171, 60);  -- Horns

-- Minotaur starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(172, 5),    -- Frenzy
(172, 48),   -- Mighty Blow
(172, 54),   -- Thick Skull
(172, 82),   -- Loner
(172, 60),   -- Horns
(172, 103);  -- Unchannelled Fury

-- Troll starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(173, 90),   -- Regeneration
(173, 48),   -- Mighty Blow
(173, 54),   -- Thick Skull
(173, 82),   -- Loner
(173, 89),   -- Really Stupid
(173, 67),   -- Always Hungry
(173, 88);   -- Projectile Vomit

-- Ogre starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(174, 48),   -- Mighty Blow
(174, 54),   -- Thick Skull
(174, 82),   -- Loner
(174, 73),   -- Bone Head
(174, 99);   -- Throw Team-Mate

-- Add Team Special Rules
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(17, 4);