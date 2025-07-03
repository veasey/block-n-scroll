/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 15;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(150, 'Skaven Lineman', 'Cheap, fast, weak', 'standard', 15, 7, 3, 3, 4, 8, 50000, 16),
(151, 'Skaven Thrower', 'Sometimes brought to throw to handoff to gutter runner', 'standard', 15, 7, 3, 4, 2, 8, 85000, 2),
(152, 'Skaven Gutter Runner', 'Touchdown Scorer', 'standard', 15, 9, 2, 2, 4, 8, 85000, 4),
(153, 'Skaven Blitzer', 'Blitzer', 'standard', 15, 7, 3, 3, 5, 9, 90000, 2),
(154, 'Rat Ogre', 'Big Guy', 'standard', 15, 6, 5, 4, NULL, 9, 150000, 1);

/* Skaven Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(150, 3, 1, 0), -- General
(150, 4, 0, 1), -- Agility
(150, 5, 0, 1), -- Mutation
(150, 2, 0, 1); -- Strength

/* Skaven Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(151, 3, 1, 0), -- General
(151, 1, 1, 0), -- Passing
(151, 4, 0, 1), -- Agility
(151, 5, 0, 1), -- Mutation
(151, 2, 0, 1); -- Strength

/* Skaven Gutter Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(152, 4, 1, 0), -- Agility
(152, 3, 1, 0), -- General
(152, 1, 0, 1), -- Passing
(152, 5, 0, 1), -- Mutation
(152, 2, 0, 1); -- Strength

/* 	Skaven Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(153, 3, 1, 0), -- General
(153, 2, 1, 0), -- Strength
(153, 4, 0, 1), -- Agility
(153, 5, 0, 1), -- Mutation
(153, 1, 0, 1); -- Passing

/*	Rat Ogre - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(154, 2, 1, 0), -- Strength
(154, 1, 0, 1), -- Agility
(154, 3, 0, 1), -- General
(154, 5, 0, 1); -- Mutation

/* Skaven Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(151, 37), -- Passingass
(151, 12); -- Strengthure Hands

/* Skaven Gutter Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(152, 19); -- Dodge

/* Skaven Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(153, 1);  -- Block

/* Rat Ogre - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(154, 68), -- Agilitynimal Savagery
(154, 5),  -- Frenzy
(154, 82), -- Loner
(154, 48), -- Mutationighty Blow
(154, 63); -- Passingrehensile Tail

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(15, 7); -- Underworld Challenge