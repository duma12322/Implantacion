// Función para alternar el texto del botón entre "Leer más" y "Leer menos"
function toggleText(button) {
    var collapseId = $(button).attr("data-target");
    var collapseElement = $(collapseId);
    
    // Verifica si el contenido está desplegado
    if (collapseElement.hasClass("show")) {
        $(button).text("Leer más");
    } else {
        $(button).text("Leer menos");
    }
}
