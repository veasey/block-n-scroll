/* Hide Team */
update base_team SET is_hidden = true WHERE id = 19;

/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 19;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(190, 'Pit Fighters', 'Human lineman', 'standard', 19, 6, 3, 3, 4, 9, 60000, 16),
(191, 'Bloodletter', 'Blizter', 'standard', 19, 6, 3, 3, 4, 8, 80000, 4),
(192, 'Khorne Heralds', 'Blocker', 'special', 19, 5, 3, 4, 5, 9, 90000, 4), 
(193, 'Bloodthirster', 'Big Guy', 'standard', 19, 6, 5, 5, NULL, 10, 180000, 1);

/* Pit Fighters - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(190, 1, 1, 0), -- General
(190, 3, 0, 1), -- Agility
(190, 2, 0, 1); -- Strength

/* Bloodletter - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES 
(191, 3, 1, 0), -- Agility
(191, 1, 1, 0), -- General
(191, 2, 1, 0), -- Strength
(191, 4, 0, 1); -- Passing

/* Khorne Herald - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(192, 3, 1, 0), -- Agility
(192, 1, 1, 0), -- General
(192, 5, 0, 1), -- Mutations
(192, 2, 0, 1), -- Strength
(192, 4, 0, 1); -- Passing

/* Bloodthirster - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(193, 2, 1, 0), -- Strength
(193, 5, 0, 1), -- Mutation
(193, 1, 0, 1); -- General

/* Pit Fighter - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(190, 5); -- Frenzy

/* Bloodletter - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(191, 60), -- Horns
(191, 47), -- Juggernaut
(191, 90); -- Regeneration

/* Khorne Herald - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(192, 60), -- Horns
(192, 47), -- Juggernaut
(192, 5);  -- Frenzy

/* Renegade Troll - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(193, 56),  -- Claw
(193, 5),   -- Frenzy
(193, 60),  -- Horns
(193, 47),  -- Juggernaut
(193, 82),  -- Loner
(193, 103), -- Unchannelled Fury
(193, 90);  -- Regeneration

/* Team Special Rules */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(19, 4); -- Favourd Of… (choose either): Undivided, Khorne, Nurgle, Slaanesh, Tzeentch