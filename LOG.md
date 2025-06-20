# DEVELOPMENT ROADMAP

### Phase 1
The database schema, seeded DATA

### Phase 2
Deliver rules from DB as HTML or JSON

### Phase 3
Basic team builder and tracker.
Can join league

### Phase 4
Track matches
Connect Team trackers to match events.

# Log

---
06 06 2025
Seed and schem data added.

Features required:
- [ ] partial names list, need to check that faction list exists. If positional does not exist, default to linemen, if no lineman for faction default to human names list.
- [ ] require a way to input names for admins, and request additional names from coaches.

Need to fix script that runs schema and seed files.
Next week just focus on schema and data.

---
07 06 2025
sql files and script in container now.
script run, schema and seeding works

just need to actually make it work, so it builds the schema and seeds it next
then check over schema and add missing data in seed files

---
08 06 2025
Data OK. Added some extra names.
Begin on backend code.

---
09 06 2025
Revising schema, found some missing data.
Fleshing out the seed files.

---
10 06 2025
Basic monolith framework. Routing to deliver flat results as HTML or JSON (for API requests).

--
11 06 2025
Working on just displaying some data on a page, from DB data through to presenting to client.
why is .env not copied into /var/www/html?

---
12 06 2025
Env variables now read.
Shown a template.
Look into routing next, then hopefuly pulling and presented data.

---
13 06 2025
Basic homepage, thinking about main navigation and initial information displayed.
Changed how web container is built, as would like a mounted volume (instead of copied files) for source, so I can make updates to source and templates without having to rebuild containers each time.

---
14 06 2025
Debugging route that gets all team data via DB.
Is having issues connecting to the DB container from the web container.

---
15 06 2025
Race table was empty as seed had errors in it.
Simplified some player tables and debugged schema building and seeding tables.
Can now see data from DB in a template.

---
16 06 2025
Standardised schema to make it clearer what are "base" stats, as opposed to user tracking stats.
Make Base namespace in Models, so I can have Base data, User data etc

---
17 06 2025
Team page and relations to populate date done.
Todo: 
- [ ] Need draft team to go to team manager page.
- [ ] Seed rest of positional data
- [ ] modal popup for skills on click, or at least go to skill page...

---
18 06 2025
Made primary skills, secondary skills, regional rules and race rules a hasMany join.
Fixed existing team seeds.
Mended some duff gen in the positional seeds and skills.

---
19 06 2025
Continue putting in positional data.

---
20 06 2025
Added Rules Team Controller to seperate data presentation logic, and add on its own layer in controller.
Added helper for formatting logic.
Had to add TWIG to container, to allow creation of controllers (removing logic from routes file)
Added reroll to amazon team as I realised I had forgotten to add rerolls to teams.
- [ ] add reroll cost to existing teams, and continue adding positional data.