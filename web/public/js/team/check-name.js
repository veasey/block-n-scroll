document.addEventListener('DOMContentLoaded', function () {
    const teamNameInput = document.getElementById('team_name');
    const form = document.getElementById('save-team-form');

    const errorMsg = document.createElement('div');
    errorMsg.style.color = 'red';
    errorMsg.style.display = 'none';
    teamNameInput.parentNode.appendChild(errorMsg);

    teamNameInput.addEventListener('blur', function () {
        const name = teamNameInput.value.trim();
        if (!name) return;

        fetch(`/api/team/check-name?name=${encodeURIComponent(name)}`)
            .then(res => res.json())
            .then(data => {
                if (!data.unique) {
                    errorMsg.textContent = 'That team name is already taken.';
                    errorMsg.style.display = 'block';
                } else {
                    errorMsg.textContent = '';
                    errorMsg.style.display = 'none';
                }
            })
            .catch(err => {
                console.error('Error checking name uniqueness:', err);
                errorMsg.textContent = 'Could not verify name uniqueness.';
                errorMsg.style.display = 'block';
            });
    });

    form.addEventListener('submit', function (e) {
        if (errorMsg.style.display === 'block') {
            e.preventDefault();
            alert('Please choose a unique team name.');
        }
    });
});
