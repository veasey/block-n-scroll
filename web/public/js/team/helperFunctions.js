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