# DEVELOPMENT ROADMAP

<details>
<summary><strong>Phase 1</strong></summary>

- Design and implement the database schema  
- Seed initial data  
</details>

<details>
<summary><strong>Phase 2</strong></summary>

- Deliver rules from the database as HTML and JSON (API)  
</details>

<details>
<summary><strong>Phase 3</strong></summary>

- Build basic team builder and tracker  
- Implement league joining functionality  
</details>

<details>
<summary><strong>Phase 4</strong></summary>

- Track matches  
- Connect team trackers to match events  
</details>

---

# DEVELOPMENT LOG

<details>
<summary><strong>06 June 2025</strong></summary>

**Seed and schema data added.**

**Next steps:**  
- [ ] Implement partial name lists with fallback logic:  
  - If faction list exists, use it  
  - If positional names do not exist, default to linemen  
  - If no linemen for faction, default to human names list  
- [ ] Create input method for admins to add names  
- [ ] Provide functionality for coaches to request additional names  
- [ ] Fix script that runs schema and seed files  

*Focus next week: schema and data refinement*
</details>

<details>
<summary><strong>07 June 2025</strong></summary>

- SQL files and schema/seed script now containerized  
- Script runs successfully, schema and seeding working  
- Next: automate schema build and seeding, review schema, and add missing seed data  
</details>

<details>
<summary><strong>08 June 2025</strong></summary>

- Seed data validated and supplemented with extra names  
- Started backend development  
</details>

<details>
<summary><strong>09 June 2025</strong></summary>

- Revised schema, identified missing data points  
- Expanding seed files accordingly  
</details>

<details>
<summary><strong>10 June 2025</strong></summary>

- Created basic monolith framework  
- Routing setup to deliver flat results as HTML or JSON (for API)  
</details>

<details>
<summary><strong>11 June 2025</strong></summary>

- Displaying DB data on pages working  
- Investigating why `.env` file is not copied into `/var/www/html`  
</details>

<details>
<summary><strong>12 June 2025</strong></summary>

- Environment variables now loading correctly  
- Template rendering confirmed  
- Next: improve routing and data presentation  
</details>

<details>
<summary><strong>13 June 2025</strong></summary>

- Built basic homepage  
- Planning main navigation and initial content  
- Modified web container build to use mounted volume for live source/template updates without rebuilding  
</details>

<details>
<summary><strong>14 June 2025</strong></summary>

- Debugging route fetching all team data from DB  
- Addressing DB connection issues between web and DB containers  
</details>

<details>
<summary><strong>15 June 2025</strong></summary>

- Fixed empty race table caused by seed errors  
- Simplified player tables and debugged schema and seed processes  
- Can now display DB data in templates successfully  
</details>

<details>
<summary><strong>16 June 2025</strong></summary>

- Standardized schema to clearly separate "base" stats from user-tracking stats  
- Created `Base` namespace in models to distinguish base data from user data  
</details>

<details>
<summary><strong>17 June 2025</strong></summary>

- Completed team page with relational data population  
- **To do:**  
  - [ ] Draft team page to link to team manager page  
  - [ ] Seed remaining positional data  
  - [ ] Implement modal popup for skills or dedicated skill pages  
</details>

<details>
<summary><strong>18 June 2025</strong></summary>

- Converted primary/secondary skills, regional rules, and race rules to `hasMany` relationships  
- Fixed broken team seeds  
- Corrected positional seeds and skill generation errors  
</details>

<details>
<summary><strong>19 June 2025</strong></summary>

- Continued adding positional data  
</details>

<details>
<summary><strong>20 June 2025</strong></summary>

- Added `RulesTeamController` to separate data presentation logic  
- Created helper for formatting logic  
- Added TWIG to container to support controllers and remove logic from route files  
- Added rerolls to Amazon team (previously missing)  
- **Done:**  
  - [x] Added reroll cost to existing teams  
- **In progress:**  
  - [ ] Continue seeding positional data  
</details>

<details>
<summary><strong>21 June 2025</strong></summary>

- Added humans and imperial nobility factions  
- Railway trial expired; considering AWS hosting options  
- **To do:**  
  - [ ] Double-check all skills and tidy seed files  
  - [ ] Revisit existing race and positional seed scripts (consider switching from ID-based to skill name-based referencing)  
  - [ ] Update player seeds and cross-reference before further additions  
- **Done:**  
  - [x] Added missing skill traits (e.g., Stunty, Swarming)  
  - [x] Reviewed schema to include random roll mechanics for skill randomization  
</details>

<summary><strong>22 June 2025</strong></summary>
- Changed back slashed apostrophes in skill.sql to double apostrophes
- Checked SKILLS on skills template.
- updated Amazon and Black Orc Player seed files with new skill IDs.
</details>


