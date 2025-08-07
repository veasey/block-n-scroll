// web/public/js/team/create.js
document.addEventListener('DOMContentLoaded', function () {

    /**
     * Buy Player Button Click Handler
     * Adds a player to the team table and increments the bought count
     */
    document.querySelectorAll('.buy-player-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            buyPlayerButtonHandler(btn);
        });
    });

    /**
     * Remove Player Button Click Handler
     * Removes a player from the team table and decrements the bought count
     */
    document.addEventListener('click', function (e) {
        if (e.target.classList.contains('remove-player-btn')) {
            removePlayerButtonHandler(e);
        }
    });

    /**
     * Buy Sidebar Staff Button Click Handler
     * Adds staff to the team and updates the current team value
     */
    document.querySelectorAll('.buy-staff-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            buyStaffButtonHandler(btn);
        });
    });

    /**
     * Fire Staff Button Click Handler
     * Removes staff from the team and updates the current team value
     */
    document.querySelectorAll('.fire-staff-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
           fireStaffButtonHandler(btn);
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

            const treasury = document.querySelector('#treasury');
            if (parseInt(treasury.value, 10) <= 0) {
                alert('You cannot afford to do that.');
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
