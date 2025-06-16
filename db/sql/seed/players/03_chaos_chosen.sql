INSERT INTO base_team_player
(id, name, description, category, base_team_id, category_regional_special_rule_id, ma, st, ag, pa, av, primary_skills, secondary_skills, secondary_skills_additional, cost, max_count, exclusive_group_id)
VALUES
(8, 'Chosen Blocker', 'Core strength-focused warrior', 'standard', 3, NULL, 5, 4, 3, NULL, 10, 'Strength', 'General', 'Mutations', 100, 12, NULL),
(9, 'Chaos Beastman', 'Versatile player with horns', 'standard', 3, NULL, 6, 3, 3, NULL, 9, 'General', 'Strength', 'Mutations', 60, 16, NULL),
(10, 'Chaos Minotaur', 'Ferocious big guy with Frenzy', 'special', 3, NULL, 5, 5, 4, NULL, 9, 'Strength', 'Mutations', NULL, 150, 1, 1), 
(11, 'Chaos Troll', 'Massive, regenerating brute with really stupid', 'special', 3, NULL, 4, 5, 5, NULL, 10, 'Strength', 'Mutations', NULL, 115, 1, 1),
(12, 'Chaos Ogre', 'Big guy with bone head and solid armour', 'special', 3, NULL, 5, 5, 4, NULL, 10, 'Strength', 'Mutations', NULL, 140, 1, 1);

INSERT INTO base_team_player_exclusive_group
(id, name, description)
VALUES
(1, 'Chaos Big Guys', 'Group for Chaos big guys like Minotaur, Troll, and Ogre');

-- Chosen Blocker starting skills (typically none, but optional mutation available)
-- No default skills

-- Chaos Beastman starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(8, 14);  -- Horns

-- Chaos Minotaur starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(9, 5),   -- Frenzy
(9, 2),   -- Mighty Blow
(9, 6),   -- Thick Skull
(9, 33),  -- Loner (Big Guy trait, if used)
(9, 14);  -- Horns


-- Chaos Troll
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(10, 3),   -- Regeneration
(10, 2),   -- Mighty Blow
(10, 6),   -- Thick Skull
(10, 33),  -- Loner

(10, 42);  -- Really Stupid

-- Chaos Ogre
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(11, 2),   -- Mighty Blow
(11, 6),   -- Thick Skull
(11, 33),  -- Loner
(11, 43);  -- Bone Head