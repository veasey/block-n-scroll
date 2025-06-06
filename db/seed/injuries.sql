INSERT INTO injury_casualty_table (roll_start, roll_end, description, effect, permanent) VALUES
(1, 6, 'Injury Table (d6 roll)', 'Refer to detailed injury table', FALSE),
(7, 9, 'Miss Next Game (2-7 games)', 'Player misses next 2-7 games', FALSE),
(10, 12, 'Niggling Injury + Miss Next Game', 'Permanent -1 AV + temporary miss games', TRUE),
(13, 14, 'Characteristic reduction + Miss Next Game', 'Permanent -1 to a characteristic + miss 8-9 games', TRUE),
(15, 16, 'Dead', 'Player is dead, permanently out', TRUE);

INSERT INTO lasting_injury_table (d6_roll, injury_type, characteristic, reduction) VALUES
(1, 'Head Injury', 'AV', -1),
(2, 'Head Injury', 'AV', -1),
(3, 'Smashed Knee', 'MA', -1),
(4, 'Broken Arm', 'PA', -1),
(5, 'Neck Injury', 'AG', -1),
(6, 'Dislocated Shoulder', 'ST', -1);