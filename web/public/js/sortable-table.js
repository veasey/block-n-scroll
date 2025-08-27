document.addEventListener("DOMContentLoaded", function () {
    // Find all tables with class "sortable"
    document.querySelectorAll("table.sortable").forEach(function (table) {
        let headers = table.querySelectorAll("thead th");

        headers.forEach(function (header, index) {
            header.style.cursor = "pointer";

            header.addEventListener("click", function () {
                let rows = Array.from(table.tBodies[0].rows);
                let asc = header.asc = !header.asc; // toggle asc/desc for this column

                rows.sort(function (a, b) {
                    let x = a.cells[index].innerText.trim().toLowerCase();
                    let y = b.cells[index].innerText.trim().toLowerCase();

                    // Try numeric comparison first
                    let xNum = parseFloat(x), yNum = parseFloat(y);
                    if (!isNaN(xNum) && !isNaN(yNum)) {
                        return asc ? xNum - yNum : yNum - xNum;
                    }

                    // Try Date comparison
                    let xDate = Date.parse(x), yDate = Date.parse(y);
                    if (!isNaN(xDate) && !isNaN(yDate)) {
                        return asc ? xDate - yDate : yDate - xDate;
                    }

                    // Fallback: string comparison
                    return asc ? x.localeCompare(y) : y.localeCompare(x);
                });

                rows.forEach(function (row) {
                    table.tBodies[0].appendChild(row); // reattach in sorted order
                });
            });
        });
    });
});