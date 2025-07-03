DELETE FROM base_team_player;
DELETE FROM base_team_player_skill;
DELETE FROM base_team_player_skill_category;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(1, 'Eagle Warrior Linewomen', 'Basic agile female warriors', 'standard', 1, 6, 3, 3, 4, 8, 70000, 16),
(2, 'Python Warrior Throwers', 'Specialist who throws the ball', 'special', 1, 6, 3, 3, 3, 8, 90000, 2),
(3, 'Piranha Warrior Blitzers', 'Stronger player skilled in blitzing', 'special', 1, 7, 3, 3, 5, 8, 110000, 4),
(4, 'Jaguar Warrior Blockers', 'Tough players who protect the team', 'special', 1, 6, 4, 3, 5, 9, 110000, 4);

/* Amazon Linewoman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(1, 1, 1, 0), -- General
(1, 2, 0, 1), -- Agility
(1, 3, 0, 1); -- Strength

/* Amazon Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(2, 1, 1, 0), -- General
(2, 4, 0, 1), -- Passing
(2, 2, 0, 1), -- Agility
(2, 3, 0, 1); -- Strength

/* Amazon Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(3, 2, 1, 0), -- Agility
(3, 1, 1, 0), -- General
(3, 3, 0, 1); -- Strength

/* Amazon Blocker - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(4, 1, 1, 0), -- General
(4, 3, 1, 0), -- Strength
(4, 2, 0, 1); -- Agility

/* Amazon Linewoman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(1, 19); -- Dodge

/* Amazon Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(2, 19), -- Dodge
(2, 36), -- On The Ball
(2, 37), -- Pass
(2, 40); -- Safe Throw

/* Amazon Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(3, 19), -- Dodge
(3, 79), -- Hit and Run (added to skills import)
(3, 20); -- Jump Up

/* Amazon Blocker - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(4, 46), -- Guard
(4, 16); -- Defensive

/* Add Team to Region */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(1, 4); -- Lustrian League