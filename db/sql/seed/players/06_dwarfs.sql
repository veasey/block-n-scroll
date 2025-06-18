/* max rerolls */
UPDATE base_team SET max_rerolls = 6 WHERE name = 'Dwarf';

INSERT INTO base_team_player
(id, name, description, category, base_team_id, category_regional_special_rule_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(60, 'Lineman', 'Basic sturdy Dwarf player with Block, Tackle, Thick Skull', 'standard', 6, NULL, 4, 3, 4, 5, 10, 70000, 12, NULL),
(61, 'Runner', 'Fast Dwarf with Sure Hands and Thick Skull', 'standard', 6, NULL, 6, 3, 4, 4, 9, 85000, 2, NULL),
(62, 'Blitzer', 'Powerful Dwarf with Block and Thick Skull', 'standard', 6, NULL, 5, 3, 4, 4, 10, 80000, 2, NULL),
(63, 'Troll Slayer', 'Frenzied, dauntless warrior with Block and Thick Skull', 'special', 6, NULL, 5, 3, 4, NULL, 9, 95000, 2, NULL),
(64, 'Deathroller', 'Legendary rolling war machine with multiple special traits', 'special', 6, NULL, 4, 7, 3, NULL, 11, 170000, 1, 5);

-- Lineman
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(60, 2, 'primary'), -- Strength (S)
(60, 4, 'primary'), -- General (G)
(60, 1, 'secondary'); -- Passing (A)

-- Runner
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(61, 3, 'primary'), -- Agility (AG)
(61, 4, 'primary'), -- General (G)
(61, 1, 'secondary'); -- Passing (P)

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(62, 2, 'primary'), -- Strength (S)
(62, 4, 'primary'), -- General (G)
(62, 1, 'secondary'); -- Passing (P)

-- Troll Slayer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(63, 2, 'primary'), -- Strength (S)
(63, 4, 'primary'), -- General (G)
(63, 1, 'secondary'); -- Passing (P)

-- Deathroller
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, skill_category_type) VALUES
(64, 4, 'primary'), -- General (G)
(64, 3, 'secondary'), -- Agility (AG)
(64, 1, 'secondary'); -- Passing (P)


-- Lineman (ID 60)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(60, 1), -- Block
(60, 4), -- Tackle
(60, 6); -- Thick Skull

-- Runner (ID 61)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(61, 25), -- Sure Hands
(61, 6);  -- Thick Skull

-- Blitzer (ID 62)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(62, 1), -- Block
(62, 6); -- Thick Skull

-- Troll Slayer (ID 63)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(63, 1),  -- Block
(63, 14), -- Dauntless
(63, 11), -- Frenzy
(63, 6);  -- Thick Skull

-- Deathroller (ID 64)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(64, 27), -- Break Tackle
(64, 28), -- Dirty Player (+2)
(64, 29), -- Juggernaut
(64, 30), -- Loner (5+)
(64, 2),  -- Mighty Blow (+1)
(64, 31), -- No Hands
(64, 32), -- Secret Weapon
(64, 33); -- Stand Firm

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, special_rule_id) VALUES
(6, 5), -- Old World Classic
(6, 8); -- Worlds Edge Superleague 