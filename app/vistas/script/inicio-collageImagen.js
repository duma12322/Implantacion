// Función para alternar el contenido y el texto de los botones
function toggleText(button, collapseId) {
    var collapseElement = document.getElementById(collapseId);
    
    // Verificar si el contenido está colapsado o desplegado
    if (collapseElement.classList.contains('show')) {
        // Si está desplegado, lo colapsamos
        collapseElement.classList.remove('show');
        button.innerText = 'Leer más'; // Cambiar el texto del botón
    } else {
        // Si está colapsado, lo desplegamos
        collapseElement.classList.add('show');
        button.innerText = 'Leer menos'; // Cambiar el texto del botón
    }
}

// Función para manejar la acción de clic en las imágenes para abrir la tarjeta correspondiente
function openCollapse(collapseId, buttonId) {
    var collapseElement = document.getElementById(collapseId);
    var buttonElement = document.getElementById(buttonId);
    
    // Abrir el colapso si está cerrado
    if (!collapseElement.classList.contains('show')) {
        collapseElement.classList.add('show');
        buttonElement.innerText = 'Leer menos'; // Cambiar el texto del botón
    }
}
