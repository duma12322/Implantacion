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

    // Función para deshabilitar domingos
    const disableSundays = () => {
        const minDate = new Date(dateInput.min);
        const maxDate = new Date(dateInput.max);
        const datesToDisable = [];

        for (let d = minDate; d <= maxDate; d.setDate(d.getDate() + 1)) {
            if (d.getDay() === 0) { // 0 representa el domingo
                datesToDisable.push(formatDate(new Date(d)));
            }
        }

        dateInput.addEventListener('input', (event) => {
            if (datesToDisable.includes(event.target.value)) {
                alert('Los domingos no laboramos');
                event.target.value = ''; // Limpia el campo de fecha
            }
        });
    };

    disableSundays();
});
