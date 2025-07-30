function filterTeams(query) {
    const select = document.getElementById('opponent_team_id');
    const options = select.querySelectorAll('option');
    const countDisplay = document.getElementById('team-count');

    let visibleCount = 0;

    options.forEach(option => {
        if (option.value === "") return; // skip the "No registered team" option

        const match = option.textContent.toLowerCase().includes(query.toLowerCase());
        option.hidden = !match;

        if (match) visibleCount++;
    });

    countDisplay.textContent = `${visibleCount} team${visibleCount === 1 ? '' : 's'} available`;
}
