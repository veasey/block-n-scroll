/* reroll cost */
UPDATE base_team SET reroll_cost = 70000 WHERE id = 11;

/* Cannot have an apothecary */
UPDATE base_team SET apothecary_allowed = false WHERE id = 11;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count) VALUES
(110, 'Zombie', 'Slow with poor ball handling', 'standard', 11, 4, 3, 4, NULL, 9, 40000, 16),
(111, 'Ghoul Runners', 'Fast ball carrier', 'standard', 11, 7, 3, 3, 4, 8, 75000, 2),
(112, 'Wraith', 'A no hands blitzer', 'standard', 11, 6, 3, 3, NULL, 9, 95000, 2),
(113, 'Werewolf', 'Good allrounder with claws', 'standard', 11, 8, 3, 3, 4, 9, 125000, 2),
(114, 'Flesh Golem', 'Reliable strength on the LOS', 'special', 11, 4, 4, 4, NULL, 10, 115000, 2);

/* Zombie - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(110, 3, 1, 0), -- General
(110, 4, 0, 1), -- Agility
(110, 2, 0, 1); -- Strength

/* Ghoul Runners - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(111, 4, 1, 0), -- Agility
(111, 3, 0, 1), -- General
(111, 1, 0, 1), -- Passing
(111, 2, 0, 1); -- Strength

/* Wraith - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(112, 3, 1, 0), -- General
(112, 2, 1, 0), -- Strength
(112, 1, 0, 1); -- Agility

/* Werewolf - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(113, 4, 1, 0), -- Agility
(113, 3, 1, 0), -- General
(113, 1, 0, 1), -- Passing
(113, 2, 0, 1); -- Strength

/* Flesh Goldem - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(114, 3, 1, 0), -- General
(114, 2, 1, 0), -- Strength
(114, 1, 0, 1); -- Agility

/* Zombie - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(110, 90);  -- Regeneration

/* Ghoul Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(111, 19);  -- Dodge

/* Wraith - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(112, 1),  -- Block
(112, 59), -- Foul Appearance
(112, 84), -- No Hands
(112, 90), -- Regeneration
(112, 23); -- Strengthide Step

/* Werewolf - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(113, 56), -- Claws
(113, 5),  -- Frenzy
(113, 90); -- Regeneration

/* Flesh Golem - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(114, 52), -- Strengthtand Firm
(114, 54), -- Thick Skull
(114, 90); -- Regeneration

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(11, 3); -- Master of Undeath

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(11, 6); -- Strengthylvanian Spotlight