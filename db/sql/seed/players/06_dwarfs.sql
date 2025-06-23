/* max rerolls */
UPDATE base_team SET max_rerolls = 6 WHERE name = 'Dwarf';
/* reroll cost */
UPDATE base_team SET reroll_cost = 50 WHERE id = 6;

INSERT INTO base_team_player
(id, name, description, category, base_team_id, ma, st, ag, pa, av, cost, max_count, exclusive_group_id)
VALUES
(60, 'Lineman', 'Basic sturdy Dwarf player with Block, Tackle, Thick Skull', 'standard', 6, 4, 3, 4, 5, 10, 70000, 12, NULL),
(61, 'Runner', 'Fast Dwarf with Sure Hands and Thick Skull', 'standard', 6, 6, 3, 4, 4, 9, 85000, 2, NULL),
(62, 'Blitzer', 'Powerful Dwarf with Block and Thick Skull', 'standard', 6, 5, 3, 4, 4, 10, 80000, 2, NULL),
(63, 'Troll Slayer', 'Frenzied, dauntless warrior with Block and Thick Skull', 'special', 6, 5, 3, 4, NULL, 9, 95000, 2, NULL),
(64, 'Deathroller', 'Legendary rolling war machine with multiple special traits', 'special', 6, 4, 7, 3, NULL, 11, 170000, 1, 5);

-- Lineman
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(60, 2, 1, 0), -- Strength (S)
(60, 4, 1, 0), -- General (G)
(60, 1, 0, 1); -- Passing (A)

-- Runner
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(61, 3, 1, 0), -- Agility (AG)
(61, 4, 1, 0), -- General (G)
(61, 1, 0, 1); -- Passing (P)

-- Blitzer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(62, 2, 1, 0), -- Strength (S)
(62, 4, 1, 0), -- General (G)
(62, 1, 0, 1); -- Passing (P)

-- Troll Slayer
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(63, 2, 1, 0), -- Strength (S)
(63, 4, 1, 0), -- General (G)
(63, 1, 0, 1); -- Passing (P)

-- Deathroller
INSERT INTO base_team_player_skill_category (base_team_player_id, skill_category_id, is_primary, is_secondary) VALUES
(64, 4, 1, 0), -- General (G)
(64, 3, 0, 1), -- Agility (AG)
(64, 1, 0, 1); -- Passing (P)


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
(63, 2), -- Dauntless
(63, 5), -- Frenzy
(63, 54);  -- Thick Skull

-- Deathroller (ID 64)
INSERT INTO base_team_player_skill (base_team_player_id, skill_id) VALUES
(64, 44), -- Break Tackle
(64, 3), -- Dirty Player (+2)
(64, 47), -- Juggernaut
(64, 82), -- Loner (5+)
(64, 48),  -- Mighty Blow (+1)
(64, 84), -- No Hands
(64, 92), -- Secret Weapon
(64, 52); -- Stand Firm

-- Add Team to Region
INSERT INTO base_team_regional_rule (base_team_id, regional_rule_id) VALUES
(6, 5), -- Old World Classic
(6, 8); -- Worlds Edge Superleague 