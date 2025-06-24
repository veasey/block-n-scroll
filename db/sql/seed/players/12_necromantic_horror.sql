/* reroll cost */
UPDATE base_team SET reroll_cost = 70 WHERE id = 12;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count)
VALUES
(120, 'Zombie', 'Slow with poor ball handling', 'standard', 
12, 4, 3, 4, NULL, 9, 40000, 16),
(121, 'Ghoul Runners', 'Fast ball carrier', 'standard', 
12, 7, 3, 3, 4, 8, 75000, 2),
(122, 'Wraith', 'A no hands blitzer', 'standard', 
12, 6, 3, 3, NULL, 9, 95000, 2),
(123, 'Werewolf', 'Good allrounder with claws', 'standard', 
12, 8, 3, 3, 4, 9, 125000, 2),
(124, 'Flesh Golem', 'Reliable strength on the LOS', 'special', 
12, 4, 4, 4, NULL, 10, 115000, 2);

/* Zombie - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(120, 3, 1, 0),  -- G
(120, 4, 0, 1),  -- A
(120, 2, 0, 1);  -- S

/* Ghoul Runners - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(121, 4, 1, 0),  -- A
(121, 3, 0, 1),  -- G
(121, 1, 0, 1),  -- P
(121, 2, 0, 1);  -- S

/* Wraith - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(122, 3, 1, 0),  -- G
(122, 2, 1, 0),  -- S
(122, 1, 0, 1);  -- A

/* Werewolf - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(123, 4, 1, 0),  -- A
(123, 3, 1, 0),  -- G
(123, 1, 0, 1),  -- P
(123, 2, 0, 1);  -- S

/* Flesh Goldem - Pri & Sec */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary)  VALUES
(124, 3, 1, 0),  -- G
(124, 2, 1, 0),  -- S
(124, 1, 0, 1);  -- A

/* Zombie - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(120, 90);  -- Regeneration

/* Ghoul Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(121, 19);  -- Dodge

/* Wraith - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(122, 1),  -- Block
(122, 59),  -- Foul Appearance
(122, 84),  -- No Hands
(122, 90),  -- Regeneration
(122, 23);  -- Side Step

/* Werewolf - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(123, 56),  -- Claws
(123, 5),  -- Frenzy
(123, 90);  -- Regeneration

/* Flesh Golem - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(124, 52),  -- Stand Firm
(124, 54),  -- Thick Skull
(124, 90);  -- Regeneration

/* Race Rule */
INSERT INTO base_team_special_rule (base_team_id, special_rule_id) VALUES
(12, 3); -- Master of Undeath

/* Regional Rule */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(12, 6); -- Sylvanian Spotlight