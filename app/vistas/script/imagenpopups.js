function openPopup(title, collapseId) {
    // Establecer el título del servicio en el modal
    document.getElementById('modalTitle').textContent = title;
    
    // Ocultar todos los posibles elementos desplegables antes de mostrar el nuevo
    var allCollapses = document.querySelectorAll('.collapse');
    allCollapses.forEach(function (collapse) {
        collapse.classList.remove('show');
    });

    // Mostrar el contenido desplegable correspondiente
    var collapseElement = document.getElementById(collapseId);
    if (collapseElement) {
        collapseElement.classList.add('show');
    }

    // Abrir el modal
    var myModal = new bootstrap.Modal(document.getElementById('serviceModal'));
    myModal.show();
}

// Función para abrir el modal con contenido dinámico
function openPopup(title, collapseId) {
    // Establecer el título del modal
    document.getElementById("modalTitle").innerText = title;
    
    // Cerrar todos los "collapses" antes de abrir el nuevo
    var collapses = document.querySelectorAll('.collapse');
    collapses.forEach(function(collapse) {
        $(collapse).collapse('hide');
    });
    
    // Abrir el collapse correspondiente
    $('#' + collapseId).collapse('show');
    
    // Mostrar el modal
    $('#serviceModal').modal('show');
}

// Función para cerrar el modal
function closeModal() {
    // Cerrar el modal usando el método de Bootstrap 4.5
    $('#serviceModal').modal('hide');
}
