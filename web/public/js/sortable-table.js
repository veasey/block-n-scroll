 function sortTable(n) {
            var table = document.getElementById("sortable-table");
            var rows = Array.from(table.rows).slice(1);
            var asc = table.asc = !table.asc;
            rows.sort(function(a, b) {
                var x = a.cells[n].innerText.toLowerCase();
                var y = b.cells[n].innerText.toLowerCase();
                return asc ? (x > y ? 1 : -1) : (x < y ? 1 : -1);
            });
            for (var i = 0; i < rows.length; i++) table.tBodies[0].appendChild(rows[i]);
        }