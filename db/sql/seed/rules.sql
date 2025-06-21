DELETE FROM race_special_rule;
DELETE FROM regional_special_rule;

INSERT INTO race_special_rule (id, name, description) VALUES
 (1, 'Bribery and Corruption', 'Allows roll to Argue the Call via bribes'),
 (2, 'Low Cost Linemen', 'Linemen cost 0 TV when calculating team value'),
 (3, 'Master of Undeath', 'Undead may reanimate a dead player'),
 (4, 'Favoured of...', 'Blessings of Chaos gods');

INSERT INTO regional_special_rule (id, name, description) VALUES
 (1, 'Badlands Brawl', "Brutal league favoured by Greenskin and Ogre teams"),
 (2, 'Elven Kingdoms League', "One of the oldest leagues in the known world, the Elven KingdomsLeague prides itself on upholding the traditions of classically-correct Blood Bowl. Many find it dull but, in terms of elegance and expertise, it is second to none."),
 (3, 'Halfling Thimble Cup', "Traditionally, Halflings have been associated more closely with the culinary arts than the world of professional sport. In recent years this has changed greatly, and the Thimble Cup has become a main stay on the Blood Bowl calendar."),
 (4, 'Lustrian SuperLeague', "The Lustrian Superleague is the oldest competition in the world, and home to many of the sport's most ancient teams.For millennia it was closed to all except Lizardmen teams, but in recent years has opened its ranks to welcome other races."),
 (5, 'Old World Classic', "Since the collapse of the NAF, Blood Bowl in the Old World has struggled. But in recent years the sport's fortunes have improved, largely thanks to the founding of the Old World Classic, a competition that draws together many minor leagues."),
 (6, 'Sylvanian Spotlight', "For many decades the Sylvanian Spotlight was the only place most Undead teams could hope to compete. In recent years, the development of sun protection magic has changed this, allowing the athletically inclined Undead to play at anytime, anywhere!"),
 (7, 'Underworld Challenge', "A secretive league that, until only recently, many pundits refused to believe even existed! The Underworld Challenge hosts many strange and diverse teams, the likes of which are rarely seen in day light. For a horrifying spectacle, it is second to none!"),
 (8, 'Worlds Edge SuperLeague', "Played on high peaks under clear skies, the Superleague is the pride of the Dwarfen realm. Games last many hours as rules are carefully checked and checked again, ensuring that the purity of Roze-El's sacred work is maintained. Interestingly, in Dwarfish'venerable' and 'dull' are spelled the same.");

 INSERT INTO skill_random_selection
(first_d6, second_d6, agility_skill, general_skill, mutations_skill, passing_skill, strength_skill) VALUES
(1, 1, 'Catch', 'Block', 'Big Hand', 'Accurate', 'Arm Bar'),
(1, 2, 'Diving Catch', 'Dauntless', 'Claws', 'Cannoneer', 'Brawler'),
(1, 3, 'Diving Tackle', 'Dirty Player (+1)', 'Disturbing Presence*', 'Cloud Burster', 'Break Tackle'),
(1, 4, 'Dodge', 'Fend', 'Extra Arms', 'Dump-off', 'Grab'),
(1, 5, 'Defensive', 'Frenzy*', 'Foul Appearance*', 'Fumblerooskie', 'Guard'),
(1, 6, 'Jump Up', 'Kick', 'Horns', 'Hail Mary Pass', 'Juggernaut'),
(2, 1, 'Leap', 'Pro', 'Iron Hard Skin', 'Leader', 'Mighty Blow (+1)'),
(2, 2, 'Safe Pair of Hands', 'Shadowing', 'Monstrous Mouth', 'Nerves of Steel', 'Multiple Block'),
(2, 3, 'Sidestep', 'Strip Ball', 'Prehensile Tail', 'On the Ball', 'Pile Driver'),
(2, 4, 'Sneaky Git', 'Sure Hands', 'Tentacles', 'Pass', 'Stand Firm'),
(2, 5, 'Sprint', 'Tackle', 'Two Heads', 'Running Pass', 'Strong Arm'),
(2, 6, 'Sure Feet', 'Wrestle', 'Very Long Legs', 'Safe Pass', 'Thick Skull');
