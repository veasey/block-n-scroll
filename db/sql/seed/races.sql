DELETE FROM base_team;

INSERT INTO base_team (id, name, description, tier) VALUES
(1, 'Amazons', 'Strong female warriors.', 1),
(2, 'Black Orc', 'Elite orc warriors with heavy armor and brute strength.', 2),
(3, 'Chaos Dwarf', 'Stubborn and brutal dwarves allied with Chaos.', 1),
(4, 'Dark Elf', 'Fast and deadly with excellent passing skills.', 1),
(5, 'Dwarf', 'Sturdy and resilient fighters.', 1),
(6, 'Elven Union', 'Agile elves with a focus on passing and speed.', 2),
(7, 'High Elf', 'Graceful and powerful elves with magic affinity.', 1),
(8, 'Humans', 'Versatile and balanced team.', 1),
(9, 'Imperial Nobility', 'Elite human teams with skill and speed.', 1),
(10, 'Lizardmen', 'Strong and ancient reptilian warriors.', 1),
(11, 'Necromantic Horror', 'Undead team with speed and agility options.', 1),
(12, 'Norse', 'Fierce and hardy northern warriors.', 1),
(13, 'Orc', 'Strong and tough with powerful blitzers.', 1),
(14, 'Shambling Undead', 'Hard to kill undead with special skills.', 1),
(15, 'Skaven', 'Fast and tricky, but fragile.', 1),
(16, 'Wood Elf', 'Agile forest dwellers with great speed and precision.', 1);

-- Tier 2 (Strong niche teams)
INSERT INTO base_team (id, name, description, tier) VALUES
(17, 'Chaos Chosen', 'Elite warriors of Chaos, strong and aggressive.', 2),
(18, 'Chaos Renegade', 'Disciples of Chaos with diverse skillsets.', 2),
(19, 'Daemons of Khorne', 'Fierce, bloodthirsty daemons with powerful attacks.', 2),
(20, 'Khorne', 'Followers of Khorne, brutal and bloodthirsty.', 2),
(21, 'Gnomes', 'Tiny and tricky players with unique skills.', 2),
(22, 'Nurgle', 'Rotting, disease-infested followers of Chaos.', 2),
(23, 'Old World Aliance', 'Mixed team of different races united.', 2),
(24, 'Slaanesh', 'Followers of the Chaos god Slaanesh, fast and seductive.', 2),
(25, 'Slann', 'Frog-like creatures with unique jumping abilities.', 2),
(26, 'Underworld', 'Mix of Skaven and Goblins, tricky and unpredictable.', 2),
(27, 'Vampires', 'Bloodthirsty undead with powerful abilities.', 2),
(28, 'Khemri', 'Ancient undead with mummies and constructs.', 3);

-- Tier 3 (Fun / Underdog teams)
INSERT INTO base_team (id, name, description, tier) VALUES
(29, 'Goblins', 'Cheap and tricky players.', 3),
(30, 'Halflings', 'Small and sneaky, hard to injure.', 3),
(31, 'Ogres', 'Massive, tough and slow brutes.', 3),
(32, 'Snotlings', 'Small, numerous, chaotic, and fragile.', 3);