/**
 * Check can add player to team and not exceed max allowed for position
 * @param {HTMLElement} currentPlayerRow - The row of the player being added
 * @param {number} max - The maximum allowed for this position
 * @returns boolean
 */
function exceedingMaxPositionalsAllowed(currentPlayerRow, max) {
    
    const boughtCountElem = currentPlayerRow.querySelector(`.bought-count`);
    if (!boughtCountElem) return false; 

    let boughtCount = parseInt(boughtCountElem.getAttribute('data-bought-count'), 10) || 0;    
    if (boughtCount >= max && max > 0) {
        return true; 
    }

    return false;
}

/**
 * Increments or creates a bought count for the player in the team table
 * @param {number} positionId - The ID of the position being bought
 * @param {HTMLElement} currentPlayerRow - The row of the player being added
 * @returns void
 */
function addOrIncrementBoughtCount(positionId, currentPlayerRow) {
    
    // is boughtCount already created?
    let boughtCountElem = currentPlayerRow.querySelector(`.bought-count`);

    if (boughtCountElem) {
        // Increment existing bought count
        let boughtCount = parseInt(boughtCountElem.getAttribute('data-bought-count'), 10) || 0;
        boughtCount += 1;
        boughtCountElem.setAttribute('data-bought-count', boughtCount);
        boughtCountElem.textContent = `${boughtCount} of `; // add max if you have it
    }
    else {
        // Create new bought count element
        boughtCountElem = document.createElement('span');
        boughtCountElem.className = 'bought-count';
        boughtCountElem.setAttribute('data-position-id', positionId);
        boughtCountElem.setAttribute('data-bought-count', 1);
        boughtCountElem.textContent = '1 of '; // Initial count

        currentPlayerRow.querySelector('td:nth-child(3)').prepend(boughtCountElem);
    }               
}

/**
 * reduces the bought count for a player in the team table
 * If the count reaches zero, it removes the element
 * @param {number} positionId 
 */
function removeTeamPlayerPositionalBoughtCount(positionId) {
    const positionsTable = document.querySelector('#positions-table tbody');
    if (!positionsTable) return;

    const button = positionsTable.querySelector(`button[data-position-id="${positionId}"]`);
    if (!button) return;

    const currentPlayerRow = button.closest('tr');
    if (!currentPlayerRow) return;

    const boughtCountElem = currentPlayerRow.querySelector('.bought-count');
    if (!boughtCountElem) return;

    let boughtCount = parseInt(boughtCountElem.getAttribute('data-bought-count'), 10) || 0;
    boughtCount -= 1;
    if (boughtCount <= 0) {
        boughtCountElem.remove();
        return;
    }    

    boughtCountElem.setAttribute('data-bought-count', boughtCount);
    boughtCountElem.textContent = `${boughtCount} of `; // Update text    
}

/**
 * Reset player numbers in the team table, so they are sequential
 */
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

/**
 * Remove player from team and update current team value
 * @param {HTMLElement} row - The table row of the player to remove
 * @returns void
 */
function removeTeamPlayerCost(row) {
    
    const teamTable = document.querySelector('#team-table tbody');
    if (!teamTable) return;
    
    const currentValueInput = document.querySelector('#current_team_value');
    const currentValue = parseInt(currentValueInput.value, 10) || 0;

    const playerCostCell = row.querySelector('td:nth-child(6)');
    const playerCost = parseInt(playerCostCell.textContent.replace(/,/g, ''), 10) || 0;

    currentValueInput.value = currentValue - playerCost; // Reset to current value before recalculating
}

function increaseCurrentTeamValue(amount) {
    // Increment the current team value
    const currentValueInput = document.querySelector('#current_team_value');
    const currentValue = parseInt(currentValueInput.value, 10) || 0;
    currentValueInput.value = currentValue + amount;
    document.querySelector('#current-team-value-span').textContent = currentValueInput.value;
}

function decreaseCurrentTeamValue(amount) {
    const currentValueInput = document.querySelector('#current_team_value');
    const currentValue = parseInt(currentValueInput.value, 10) || 0;
    currentValueInput.value = currentValue - amount;
    document.querySelector('#current-team-value-span').textContent = currentValueInput.value;
    
}

function increaseTreasuryValue(amount) {
    const treasuryInput = document.querySelector('#treasury');
    if (!treasuryInput) return;
    const treasury = parseInt(treasuryInput.value, 10) || 0;
    treasuryInput.value = treasury + amount;
}

function decreaseTreasuryValue(amount) {
    const treasuryInput = document.querySelector('#treasury');
    if (!treasuryInput) return;
    const treasury = parseInt(treasuryInput.value, 10) || 0;
    treasuryInput.value = treasury - amount;    
}

function fireStaffButtonHandler(btn) {
    const staffId = btn.getAttribute('data-staff-id'); // Get the staff ID if needed
    const addStaffButton = btn.closest('tr')?.querySelector(`.buy-staff-btn[data-staff-id="${staffId}"]`);

    const staffCost = parseInt(addStaffButton.getAttribute('data-staff-cost'), 10);
    let currentStaffCount = parseInt(addStaffButton.getAttribute('data-current-staff'), 10) || 0;

    if (currentStaffCount <= 0) {
        return;
    }

    decreaseCurrentTeamValue(staffCost);
    increaseTreasuryValue(staffCost);

    // Update the staff count
    currentStaffCount -= 1;
    addStaffButton.setAttribute('data-current-staff', currentStaffCount);
    btn.closest('tr').querySelector('span.count').textContent = currentStaffCount;
}

function buyStaffButtonHandler(btn) {
    const staffCost = parseInt(btn.getAttribute('data-staff-cost'));
    const maxStaff = parseInt(btn.getAttribute('data-max-staff'));
    let currentStaffCount = parseInt(btn.getAttribute('data-current-staff')) || 0;

    if (currentStaffCount >= maxStaff) {
        return;
    }

    increaseCurrentTeamValue(staffCost);
    decreaseTreasuryValue(staffCost);

    // Update the staff count
    currentStaffCount += 1;
    btn.setAttribute('data-current-staff', currentStaffCount);
    btn.closest('tr').querySelector('span.count').textContent = currentStaffCount;
}

function removePlayerButtonHandler(e) {
    const currentPlayerRow = e.target.closest('tr');
    const positionId = currentPlayerRow.querySelector('input[name="team_positions[]"]').value;
    
    removeTeamPlayerCost(currentPlayerRow);
    removeTeamPlayerPositionalBoughtCount(positionId);
    currentPlayerRow.remove();
    resetTeamPlayerNumbers();
}

function buyPlayerButtonHandler(btn) {
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

            increaseCurrentTeamValue(position.cost);
            decreaseCurrentTeamValue(position.cost);

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
}