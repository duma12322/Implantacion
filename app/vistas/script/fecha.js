 document.addEventListener('DOMContentLoaded', (event) => {
            const dateInput = document.getElementById('fecha');
            const today = new Date();
            const nextMonth = new Date(today.getFullYear(), today.getMonth() + 1, 1);

            const formatDate = (date) => {
                const year = date.getFullYear();
                const month = ('0' + (date.getMonth() + 1)).slice(-2);
                const day = ('0' + date.getDate()).slice(-2);
                return `${year}-${month}-${day}`;
            };

            dateInput.min = formatDate(today);
            dateInput.max = formatDate(nextMonth);
        });