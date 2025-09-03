document.getElementById('hide_team_selector').addEventListener('change', function() {
    
    const selectedValue = this.value;
    
    switch(selectedValue) {
        case 'y':
            // Show all teams
            document.querySelectorAll('tr[data-hidden="true"]').forEach(row => {
                row.classList.remove('hidden');
            });
            break;
        case 'x':
            // Show only hidden teams
            document.querySelectorAll('tr[data-hidden="false"]').forEach(row => {
                row.classList.add('hidden');
            });
            document.querySelectorAll('tr[data-hidden="true"]').forEach(row => {
                row.classList.remove('hidden');
            });
            break;
        default:
            // Hide all hidden teams
            document.querySelectorAll('tr[data-hidden="true"]').forEach(row => {
                row.classList.add('hidden');
            });
            document.querySelectorAll('tr[data-hidden="false"]').forEach(row => {
                row.classList.remove('hidden');
            });
            break;
    }
});