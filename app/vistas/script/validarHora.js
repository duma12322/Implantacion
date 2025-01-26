
document.addEventListener('DOMContentLoaded', function () {
    const horaInput = document.getElementById('hora');
    const minutosInput = document.getElementById('minutos');
    const amPmSelect = document.getElementById('am_pm');
    const fechaInput = document.getElementById('fecha');

    function validarHora() {
        const hora = parseInt(horaInput.value);
        const minutos = parseInt(minutosInput.value);
        const amPm = amPmSelect.value;
        const fecha = fechaInput.value;

        // Verificar que los campos no estén vacíos y que los valores sean válidos
        if (!fecha || isNaN(hora) || isNaN(minutos) || !amPm) return;

        const [year, month, day] = fecha.split('-').map(Number);
        const diaSemana = new Date(year, month - 1, day).getDay(); // Obtener día de la semana correctamente

        let horaEn24 = hora;
        if (amPm === "PM" && hora !== 12) {
            horaEn24 += 12;
        } else if (amPm === "AM" && hora === 12) {
            horaEn24 = 0;
        }

        let mensajeAdvertencia = '';
        if (diaSemana >= 1 && diaSemana <= 5) { // Lunes a viernes
            if (!((horaEn24 >= 9 && horaEn24 < 12) || (horaEn24 === 12 && minutos === 0) || (horaEn24 >= 13 && horaEn24 < 16))) {
                mensajeAdvertencia = "La hora no está dentro del horario permitido de lunes a viernes (9:00 AM - 12:00 PM o 1:00 PM - 4:00 PM).";
            }
        } else if (diaSemana === 6) { // Sábado
            if (!(horaEn24 >= 9 && horaEn24 < 13)) {
                mensajeAdvertencia = "La hora no está dentro del horario permitido para los sábados (9:00 AM - 1:00 PM).";
            }
        }

        if (mensajeAdvertencia) {
            mostrarAdvertencia(mensajeAdvertencia);
        } else {
            ocultarAdvertencia();
        }
    }

    function mostrarAdvertencia(mensaje) {
        const advertencia = document.getElementById('advertencia');
        advertencia.textContent = mensaje;
    }

    function ocultarAdvertencia() {
        const advertencia = document.getElementById('advertencia');
        advertencia.textContent = '';
    }

    horaInput.addEventListener('input', validarHora);
    minutosInput.addEventListener('input', validarHora);
    amPmSelect.addEventListener('change', validarHora);
    fechaInput.addEventListener('change', validarHora);
});

