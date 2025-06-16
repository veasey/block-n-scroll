INSERT INTO base_team_player
(id, name, description, category, base_team_id, category_regional_special_rule_id, ma, st, ag, pa, av, primary_skills, secondary_skills, cost, max_count)
VALUES
(4, 'Black Orc', 'Tough and strong standard player', 'standard', 1, 1, 5, 5, 2, 2, 9, 'Strength', 'General', 140, 6),
(5, 'Black Orc Thrower', 'Specialized thrower with strength', 'special', 1, 1, 5, 5, 2, 4, 9, 'Passing', 'Strength', 170, 1),
(6, 'Black Orc Blitzer', 'Blitz-focused Black Orc', 'special', 1, 1, 5, 6, 2, 2, 10, 'Strength', 'General', 180, 2);

-- Assuming IDs assigned as 1, 2, 3 for Black Orc, Thrower, Blitzer respectively:

-- Black Orc starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(4, 1),  -- Block
(4, 2),  -- Mighty Blow
(4, 4);  -- Tackle

-- Black Orc Thrower starting skills
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(5, 1),  -- Block
(5, 2),  -- Mighty Blow
(5, 12); -- Pass

INSERT INTO base_team_player
(id, name, description, category, base_team_id, category_regional_special_rule_id, ma, st, ag, pa, av, primary_skills, secondary_skills, cost, max_count)
VALUES
(7, 'Goblin', 'Nimble but fragile support players', 'standard', 1, 1, 6, 2, 3, 4, 7, 'Agility', 'General', 40, 12);

-- Assuming this is the 4th inserted position (ID = 4):
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(6, 11),  -- Dodge
(6, 20),  -- Right Stuff
(6, 44);  -- Stunty
