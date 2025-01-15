let selectedRowId = null;
let selectedRowElement = null; // Variable para almacenar la fila seleccionada

// Función para seleccionar la fila
function selectRow(id, row) {
    // Si ya hay una fila seleccionada, eliminamos el color
    if (selectedRowElement) {
        selectedRowElement.classList.remove('selected-row');
    }

    // Aplicamos el color gris a la nueva fila seleccionada
    selectedRowElement = row;
    selectedRowElement.classList.add('selected-row');

    // Guardamos el ID de la fila seleccionada
    selectedRowId = id;
    document.getElementById('id_usuario_to_delete').value = id;
}

// Validar la eliminación del usuario antes de enviar el formulario
document.querySelectorAll('.deleteForm').forEach(form => {
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Evita el envío del formulario directamente

        if (selectedRowId === null) {
            // Si no se seleccionó un usuario, mostrar mensaje de alerta
            Swal.fire({
                icon: 'warning',
                title: 'No has seleccionado un usuario',
                text: 'Por favor selecciona un usuario antes de intentar eliminarlo.',
            });
        } else {
            // Si se seleccionó un usuario, mostrar confirmación de eliminación
            Swal.fire({
                title: '¿Estás seguro?',
                text: "No podrás revertir esta acción.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, eliminarlo',
                cancelButtonText: 'No, cancelar',
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si el usuario confirma, enviar el formulario
                    this.submit();
                }
            });
        }
    });
});
