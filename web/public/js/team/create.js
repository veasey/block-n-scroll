// web/public/js/team/create.js
document.addEventListener('DOMContentLoaded', function () {
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

    // Remove player from team
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

    // save team form submission
    const saveTeamForm = document.querySelector('#save-team-form');
    if (saveTeamForm) {
        saveTeamForm.addEventListener('submit', function (e) {
            e.preventDefault();
            // Here you can add any additional validation or processing before submitting
            this.submit();
        });
    }
});