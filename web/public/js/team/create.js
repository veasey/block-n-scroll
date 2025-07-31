// web/public/js/team/create.js
document.addEventListener('DOMContentLoaded', function () {

    /**
     * But Player Button Click Handler
     * Adds a player to the team table and increments the bought count
     */
    document.querySelectorAll('.buy-player-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {

            const currentPlayerRow = btn.closest('tr');
            const positionId = btn.getAttribute('data-position-id');
            const max = parseInt(btn.getAttribute('data-max'), 10);
            
            if (exceedingMaxPositionalsAllowed(currentPlayerRow, max)) {
                alert('You cannot buy more than the maximum allowed for this position.');
                return;
            }
            
            addOrIncrementBoughtCount(positionId, currentPlayerRow);

            fetch(`/rules/position/${positionId}.json`)
                .then(response => response.json())
                .then(data => {

                    const position = data.position;
                    
                    // Find the team table
                    const teamTable = document.querySelector('#team-table tbody');
                    if (!teamTable) return;

                    const playerNumber = teamTable.querySelectorAll('tr').length + 1;

                    // increment current team value
                    const currentValueInput = document.querySelector('#current_team_value');
                    const currentValue = parseInt(currentValueInput.value, 10) || 0;
                    currentValueInput.value = currentValue + position.cost;
                    document.querySelector('#current-team-value-span').textContent = currentValueInput.value;

                    // create skills
                    const skills = position.skills.map(skill => {
                        return `<a href="/rules/skill/${skill.id}.html" title="${skill.description}" class="skill-link"><span class="skill">${skill.name}</span></a>`;
                    }).join(', ');

                    // Create a new row for the team table
                    const newRow = document.createElement('tr');
                    newRow.innerHTML = `
                        <td>${playerNumber}</td>
                        <td>${position.name} <input type="hidden" name="team_positions[]" value="${position.id}"></td>
                        <td>${skills}</td>
                        <td>${position.primary_skill_initials}</td>
                        <td>${position.secondary_skill_initials}</td>                        
                        <td>${Number(position.cost).toLocaleString()}</td>
                        <td><button type="button" class="remove-player-btn">Remove</button></td>
                    `;
                    teamTable.appendChild(newRow);             
                })
                .catch(err => {
                    console.error('Failed to fetch position data:', err);
                });

        });
    });

    /**
     * Remove Player Button Click Handler
     * Removes a player from the team table and decrements the bought count
     */
    document.addEventListener('click', function (e) {
        if (e.target.classList.contains('remove-player-btn')) {

            const currentPlayerRow = e.target.closest('tr');
            const positionId = currentPlayerRow.querySelector('input[name="team_positions[]"]').value;
            
            removeTeamPlayerCost(currentPlayerRow);
            removeTeamPlayerPositionalBoughtCount(positionId);
            currentPlayerRow.remove();
            resetTeamPlayerNumbers();
        }
    });

    /**
     * Buy Sidebar Staff Button Click Handler
     * Adds staff to the team and updates the current team value
     */
    document.querySelectorAll('.buy-staff-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {

            const staffCost = parseInt(btn.getAttribute('data-staff-cost'), 10);
            const maxStaff = parseInt(btn.getAttribute('data-max-staff'), 10);
            let currentStaffCount = parseInt(btn.getAttribute('data-current-staff'), 10) || 0;

            if (currentStaffCount >= maxStaff) {
                return;
            }

            // Increment the current team value
            const currentValueInput = document.querySelector('#current_team_value');
            const currentValue = parseInt(currentValueInput.value, 10) || 0;
            currentValueInput.value = currentValue + staffCost;
            document.querySelector('#current-team-value-span').textContent = currentValueInput.value;

            // Update the staff count
            currentStaffCount += 1;
            btn.setAttribute('data-current-staff', currentStaffCount);
            btn.closest('tr').querySelector('span.count').textContent = currentStaffCount;
        });
    });

    /**
     * Fire Staff Button Click Handler
     * Removes staff from the team and updates the current team value
     */
    document.querySelectorAll('.fire-staff-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {

            const staffId = btn.getAttribute('data-staff-id'); // Get the staff ID if needed
            const addStaffButton = btn.closest('tr')?.querySelector(`.buy-staff-btn[data-staff-id="${staffId}"]`);

            const staffCost = parseInt(addStaffButton.getAttribute('data-staff-cost'), 10);
            let currentStaffCount = parseInt(addStaffButton.getAttribute('data-current-staff'), 10) || 0;

            if (currentStaffCount <= 0) {
                return;
            }

            // Increment the current team value
            const currentValueInput = document.querySelector('#current_team_value');
            const currentValue = parseInt(currentValueInput.value, 10) || 0;
            currentValueInput.value = currentValue - staffCost;
            document.querySelector('#current-team-value-span').textContent = currentValueInput.value;

            // Update the staff count
            currentStaffCount -= 1;
            addStaffButton.setAttribute('data-current-staff', currentStaffCount);
            btn.closest('tr').querySelector('span.count').textContent = currentStaffCount;
        });
    });

    /**
     * Form Submission Handler
     * Validates the team name and current team value before submitting
     */
    const saveTeamForm = document.querySelector('#save-team-form');
    if (saveTeamForm) {
        saveTeamForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const teamNameInput = document.querySelector('#team_name');
            if (!teamNameInput.value.trim()) {
                alert('Please enter a team name.');
                return;
            }

            const teamValueInput = document.querySelector('#current_team_value');
            if (parseInt(teamValueInput.value, 10) <= 0) {
                alert('Your team must have a value greater than zero.');
                return;
            }

            const maxTeamValue = document.querySelector('#max_cost');
            if (parseInt(teamValueInput.value, 10) > parseInt(maxTeamValue.value, 10)) {
                alert('Team cannot exceed max team value.');
                return;
            }

            // add all players to post
            const teamPositions = [];
            document.querySelectorAll('#team-table tbody tr').forEach(function (row) {
                const positionInput = row.querySelector('input[name="team_positions[]"]');
                if (positionInput) {
                    teamPositions.push(positionInput.value);
                }
            });

            const teamPositionsInput = document.createElement('input');
            teamPositionsInput.type = 'hidden';
            teamPositionsInput.name = 'team_positions';
            teamPositionsInput.value = JSON.stringify(teamPositions);
            saveTeamForm.appendChild(teamPositionsInput);

            // add all side staff to post
            const teamStaff = [];
            document.querySelectorAll('.buy-staff-btn').forEach(function (btn) {
                const currentStaffCount = parseInt(btn.getAttribute('data-current-staff'), 10) || 0;
                if (currentStaffCount > 0) {
                    teamStaff.push({
                        id: btn.getAttribute('data-staff-id'),
                        count: currentStaffCount
                    });
                }
            });

            const teamStaffInput = document.createElement('input');
            teamStaffInput.type = 'hidden';
            teamStaffInput.name = 'team_staff';
            teamStaffInput.value = JSON.stringify(teamStaff);
            saveTeamForm.appendChild(teamStaffInput);

            // Submit the form
            this.submit();
        });
    }
});
