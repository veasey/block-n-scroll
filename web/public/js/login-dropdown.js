document.addEventListener('DOMContentLoaded', function() {
    const btn = document.getElementById('loginDropdownBtn');
    const dropdown = document.getElementById('loginDropdown');
    if (btn && dropdown) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        });
        document.addEventListener('click', function(e) {
            if (!btn.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.style.display = 'none';
            }
        });
    }
});