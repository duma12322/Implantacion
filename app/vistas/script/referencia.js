function toggleReferencia() {
        let tipoPago = document.getElementById('tipo_pago').value;
        let referenciaInput = document.getElementById('referencia_bancaria');

        if (tipoPago === 'EFECTIVO $') {
            referenciaInput.value = '0000'; // Asignar valor
            referenciaInput.disabled = true; // Deshabilitar
        } else {
            referenciaInput.value = ''; // Limpiar valor
            referenciaInput.disabled = false; // Habilitar
        }
    }

    // Ejecutar la función una vez al cargar la página
    document.addEventListener('DOMContentLoaded', function() {
        toggleReferencia(); // Inicializa el estado del campo al cargar la página
    });