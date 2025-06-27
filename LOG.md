# DEVELOPMENT ROADMAP

<details>
<summary><strong>Phase 1</strong></summary>

* Design and implement the database schema
* Seed initial data

</details>

<details>
<summary><strong>Phase 2</strong></summary>

* Deliver rules from the database as HTML and JSON (API)

</details>

<details>
<summary><strong>Phase 3</strong></summary>

* Build basic team builder and tracker
* Implement league joining functionality

</details>

<details>
<summary><strong>Phase 4</strong></summary>

* Track matches
* Connect team trackers to match events

</details>

---

# DEVELOPMENT LOG

## 06 June 2025

* Seed and schema data added.
* **Next steps:**

  * [ ] Implement partial name lists with fallback logic:

    * If faction list exists, use it
    * If positional names do not exist, default to linemen
    * If no linemen for faction, default to human names list
  * [ ] Create input method for admins to add names
  * [ ] Provide functionality for coaches to request additional names
  * [ ] Fix script that runs schema and seed files
  * *Focus next week: schema and data refinement*

## 07 June 2025

* SQL files and schema/seed script now containerized
* Script runs successfully; schema and seeding confirmed working
* Next: automate schema build and seeding, review schema, add missing seed data

## 08 June 2025

* Seed data validated and expanded with additional names
* Backend development started

## 09 June 2025

* Revised schema, identified missing data points
* Expanding seed files accordingly

## 10 June 2025

* Created basic monolith framework
* Routing set up to deliver flat results as HTML or JSON (API)

## 11 June 2025

* DB data display on pages confirmed working
* Investigating `.env` file copy issue in `/var/www/html`

## 12 June 2025

* Environment variables now loading correctly
* Template rendering confirmed working
* Next: improve routing and data presentation

## 13 June 2025

* Basic homepage created
* Planning navigation and initial content
* Modified web container to use mounted volume for live updates

## 14 June 2025

* Debugging route to fetch all team data from DB
* Addressing DB connection issues between web and DB containers

## 15 June 2025

* Fixed empty race table due to seed errors
* Simplified player tables, debugged schema and seed processes
* DB data successfully displaying in templates

## 16 June 2025

* Standardized schema to separate base stats from user-tracking stats
* Introduced `Base` namespace in models for separation

## 17 June 2025

* Team page with relational data completed
* **To do:**

  * [ ] Link team page to manager page
  * [ ] Seed remaining positional data
  * [ ] Implement skill modal popup or dedicated skill pages

## 18 June 2025

* Converted primary/secondary skills and rules to `hasMany` relationships
* Fixed broken team seeds and skill generation errors

## 19 June 2025

* Continued adding positional data

## 20 June 2025

* Added `RulesTeamController` for data presentation logic
* Created helper for formatting logic
* Added TWIG for cleaner controllers and removed logic from routes
* Reroll costs added to Amazon and other teams
* **In progress:**

  * [x] Continue seeding positional data

## 21 June 2025

* Added Humans and Imperial Nobility
* Railway trial expired — exploring AWS hosting
* **To do:**

  * [x] Verify all skills and tidy seed files
  * [x] Revisit race and positional seed scripts (switch to skill name-based referencing)
  * [x] Update player seeds and cross-reference
* **Done:**

  * [x] Added missing skill traits (e.g., Stunty, Swarming)
  * [x] Added random roll mechanics to schema

## 22 June 2025

* Replaced backslash apostrophes in `skill.sql` with double apostrophes
* Verified skills template rendering
* Updated Amazon and Black Orc player seed files with correct skill IDs

## 23 June 2025

* Continued fixing skill IDs in positional seed data
* Added Lizardmen

## 24 June 2025

* Added Necromantic, Norse, and Orcs

## 25 June 2025

* Added Shambling Undead, Skaven, and Wood Elf
* Created tier folders for positional seed data
* Removed duplicate races and updated IDs

## 26 June 2025

* Added Chaos Renegades
* Adjusted exclusive group logic for Renegades (3 of 4 big guys)
* Normalized costs in positional data (standardized currency units)

## 27 June 2025

* Added Daemons of Khorne
* Tidied and standardized SQL files
* Fixed out-of-sync IDs between default name seeds and positional seeds
* **To do:**

  * [ ] Investigate why DB container shuts down after initial seeding (possibly root user issue)
  * [ ] Continue adding team positional data (finish Tier 1 teams)
  * [ ] Revise and correct skill descriptions
