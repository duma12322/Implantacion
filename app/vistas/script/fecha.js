document.addEventListener('DOMContentLoaded', (event) => {
    const dateInput = document.getElementById('fecha');
    const today = new Date();

    // Primer día del mes actual
    const firstDayCurrentMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());

    // Último día del próximo mes
    const lastDayNextMonth = new Date(today.getFullYear(), today.getMonth() + 2, 0);

    const formatDate = (date) => {
        const year = date.getFullYear();
        const month = ('0' + (date.getMonth() + 1)).slice(-2);
        const day = ('0' + date.getDate()).slice(-2);
        return `${year}-${month}-${day}`;
    };

    // Establecer el mínimo y el máximo para el input de fecha
    dateInput.min = formatDate(firstDayCurrentMonth);
    dateInput.max = formatDate(lastDayNextMonth);
});
