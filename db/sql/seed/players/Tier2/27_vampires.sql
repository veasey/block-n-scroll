INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(270, 'Thrall Linemen', 'Zombie lineman', 'standard', 27, 6, 4, 2, 5, 9, 40000, 16),
(271, 'Vampire Thrower', 'Thrower', 'standard', 27, 6, 4, 2, 2, 9, 110000, 2),
(272, 'Vampire Blitzer', 'Blitzerr', 'standard', 27, 6, 4, 2, 5, 9, 110000, 2),
(273, 'Vampire Runner', 'Runner', 'standard', 27, 8, 3, 2, 4, 8, 100000, 2),
(274, 'Vargheist', 'Big Guy', 'standard', 27, 5, 5, 4, NULL, 10, 150000, 1);

/* Thrall Linemen - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(270, 1, 1, 0), -- General
(270, 3, 0, 1), -- Agility
(270, 2, 0, 1); -- Strength

/* Vampire Thrower - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(271, 1, 1, 0), -- General
(271, 3, 1, 0), -- Agility
(271, 4, 1, 0), -- Passing
(271, 2, 0, 1); -- Strengths

/* Vampire Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(272, 1, 1, 0), -- General
(272, 3, 1, 0), -- Agility
(272, 2, 1, 0); -- Strengths

/* Vampire Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(273, 1, 1, 0), -- General
(273, 3, 1, 0), -- Agility
(273, 4, 0, 1), -- Passing
(273, 2, 0, 1); -- Strengths

/* Vargheist - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)
VALUES 
(274, 2, 1, 0); -- Strengths
(274, 1, 0, 1), -- General
(274, 3, 0, 1); -- Agility

/* Vampire Thrower - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(271, 71), -- Bloodlust
(271, 80), -- Hypnotic Gaze
(271, 90), -- Regeneration
(271, 37); -- Pass

/* Vampire Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(271, 71), -- Bloodlust
(271, 80), -- Hypnotic Gaze
(271, 90), -- Regeneration
(271, 47); -- Juggernaut

/* Vargheist - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id)
VALUES
(274, 71), -- Bloodlust
(274, 5),  -- Frenzy
(274, 56), -- Claws
(274, 82), -- Loner
(274, 90); -- Regeneration

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(27, 6); -- Sylvanian Spotlight