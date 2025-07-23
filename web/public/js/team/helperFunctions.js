/**
 * Check can add player to team and not exceed max allowed for position
 * @param {*} positionId 
 * @param {*} max 
 * @returns boolean
 */
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

    console.log('Current team value before removal:', currentValue);

    const playerCostCell = row.querySelector('td:nth-child(6)');

    console.log('Player cost cell:', playerCostCell);

    const playerCost = parseInt(playerCostCell.textContent.replace(/,/g, ''), 10) || 0;

    currentValueInput.value = currentValue - playerCost; // Reset to current value before recalculating
}