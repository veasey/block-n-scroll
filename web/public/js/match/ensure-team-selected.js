document.addEventListener('DOMContentLoaded', function() {

    const saveTeamForm = document.querySelector('#start_match_form');
    if (saveTeamForm) {
        saveTeamForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const opponentTeam = document.getElementById('opponent_team_id').value.trim();
            const unregisteredName = document.getElementById('unregistered_name').value.trim();

            if (!opponentTeam && !unregisteredName) {
                e.preventDefault();
                alert('Please select a registered team or enter an unregistered opponent name.');
            }

            this.submit();
        });
    }
});