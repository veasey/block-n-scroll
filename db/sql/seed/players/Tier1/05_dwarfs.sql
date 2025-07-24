/* max rerolls */
UPDATE base_team SET max_rerolls = 6 WHERE name = 'Dwarf';
/* reroll cost */
UPDATE base_team SET reroll_cost = 50000 WHERE id = 5;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id) VALUES
(50, 'Lineman', 'Basic sturdy Dwarf player with Block, Tackle, Thick Skull', 'standard', 5, 4, 3, 4, 5, 10, 70000, 12, NULL),
(51, 'Runner', 'Fast Dwarf with Sure Hands and Thick Skull', 'standard', 5, 6, 3, 4, 4, 9, 85000, 2, NULL),
(52, 'Blitzer', 'Powerful Dwarf with Block and Thick Skull', 'standard', 5, 5, 3, 4, 4, 10, 80000, 2, NULL),
(53, 'Troll Slayer', 'Frenzied, dauntless warrior with Block and Thick Skull', 'special', 5, 5, 3, 4, NULL, 9, 95000, 2, NULL),
(54, 'Deathroller', 'Legendary rolling war machine with multiple special traits', 'special', 5, 4, 7, 3, NULL, 11, 170000, 1, 5);

/* Lineman - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(50, 2, 1, 0), -- Strength
(50, 4, 1, 0), -- General
(50, 1, 0, 1); -- Passing

/* Runner - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(51, 3, 1, 0), -- Agility
(51, 4, 1, 0), -- General
(51, 1, 0, 1); -- Passing

/* Blitzer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(52, 2, 1, 0), -- Strength
(52, 4, 1, 0), -- General
(52, 1, 0, 1); -- Passing

/* Troll Slayer - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(53, 2, 1, 0), -- Strength
(53, 4, 1, 0), -- General
(53, 1, 0, 1); -- Passing

/* Deathroller - Skill Access */
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(54, 4, 1, 0), -- General
(54, 3, 0, 1), -- Agility
(54, 1, 0, 1); -- Passing

/* Lineman - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(50, 1), -- Block
(50, 4), -- Tackle
(50, 6); -- Thick Skull

/* Runner - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(51, 25), -- Sure Hands
(51, 6);  -- Thick Skull

/* Blitzer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(52, 1), -- Block
(52, 6); -- Thick Skull

/* Troll Slayer - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(53, 1),  -- Block
(53, 2),  -- Dauntless
(53, 5),  -- Frenzy
(53, 54); -- Thick Skull

/* Deathroller - Starting Skills */
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(54, 44), -- Break Tackle
(54, 3),  -- Dirty Player (+2)
(54, 47), -- Juggernaut
(54, 82), -- Loner (5+)
(54, 48), -- Mighty Blow (+1)
(54, 84), -- No Hands
(54, 92), -- Secret Weapon
(54, 52); -- Stand Firm

/* Regional Rules */
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(5, 5), -- Old World Classic
(5, 8); -- Worlds Edge Superleague 