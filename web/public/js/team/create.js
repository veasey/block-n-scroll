function exceedingMaxPositionalsAllowed(positionId, max) {
    const boughtCountElem = document.querySelector(`.bought-count[data-position-id="${positionId}"]`);
    if (!boughtCountElem) return false; 
    const boughtCount = parseInt(boughtCountElem.textContent, 10) || 0;
    
    if (boughtCount >= max && max > 0) {
        return false; // Does not exceed max allowed
    }

    // Increment bought count in the DOM
    bought += 1;
    boughtCountElem.textContent = bought;
    return true; // Exceeds max allowed   
}

function resetTeamPlayerNumbers() {
    const teamTable = document.querySelector('#team-table tbody');
    if (!teamTable) return;
    teamTable.querySelectorAll('tr').forEach((row, idx) => {
        const numberCell = row.querySelector('td:first-child');
        if (numberCell) {
            numberCell.textContent = idx + 1;
        }
    });
}

function removeTeamPlayerCost() {
    const teamTable = document.querySelector('#team-table tbody');
    if (!teamTable) return;
    const currentValueInput = document.querySelector('#current_team_value');
    const currentValue = parseInt(currentValueInput.value, 10) || 0;
    let totalCost = 0;
    teamTable.querySelectorAll('tr').forEach(row => {
        const costCell = row.querySelector('td:nth-child(6)');
        if (costCell) {
            const cost = parseInt(costCell.textContent.replace(/,/g, ''), 10) || 0;
            totalCost += cost;  
        }
    });
    currentValueInput.value = currentValue - totalCost;
}

document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.buy-player-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {

            const positionId = btn.getAttribute('data-position-id');
            const max = parseInt(btn.getAttribute('data-max'), 10);
            
            if (exceedingMaxPositionalsAllowed(positionId, max)) {
                alert('You cannot buy more than the maximum allowed for this position.');
                return;
            }

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
                    console.log(position.cost);
                    currentValueInput.value = currentValue + position.cost;


                    // create skills
                    const skills = position.skills.map(skill => {
                        return `<a href="/rules/skill/${skill.id}.html" title="${skill.description}" class="skill-link">
                            <span class="skill">${skill.name}</span>
                        </a>`;
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
            e.target.closest('tr').remove();
            resetTeamPlayerNumbers();
            removeTeamPlayerCost();
        }
    });
});