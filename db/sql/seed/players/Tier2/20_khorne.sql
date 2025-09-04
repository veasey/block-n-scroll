INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(200, 'Bloodborn Marauder Linemen', 'Lineman', 'standard', 20, 6, 3, 3, 4, 8, 50000, 16),
(201, 'Khorngors', 'Blizter', 'standard', 20, 6, 3, 3, 4, 9, 70000, 4),
(202, 'Bloodseekers', 'Blocker', 'special', 20, 5, 4, 4, 6, 10, 110000, 4), 
(203, 'Bloodspawn', 'Big Guy', 'standard', 20, 5, 5, 4, NULL, 9, 160000, 1);

/* Bloodborn Marauder Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(200, 1, 1, 0), -- General
(200, 5, 1, 0), -- Mutations
(200, 2, 0, 1), -- Agility
(200, 3, 0, 1); -- Strength

/* Khorngor - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(201, 1, 1, 0), -- General
(201, 5, 1, 0), -- Mutations
(201, 3, 1, 0), -- Strength
(201, 2, 1, 0), -- Agility
(201, 4, 0, 1); -- Passing

/* Bloodseeker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(202, 1, 1, 0), -- General
(202, 5, 1, 0), -- Mutations
(202, 3, 1, 0), -- Strength
(202, 2, 0, 1); -- Agility

/* Bloodspawn - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(203, 5, 1, 0), -- Mutation
(203, 3, 1, 0), -- Strength
(203, 2, 0, 1), -- Agility
(203, 1, 0, 1); -- General

/* Bloodborn Marauder Linemen - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(200, 5); -- Frenzy

/* Khorngors - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(201, 60), -- Horns
(201, 47); -- Juggernaut

/* Bloodseekers - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(202, 5);  -- Frenzy

/* Bloodspawn - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(203, 56),  -- Claw
(203, 5),   -- Frenzy
(203, 82),  -- Lone
(203, 48),  -- Mighty Blow
(203, 103); -- Unchannelled Fury

/* Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(20, 4); -- Favourd Of Khorne