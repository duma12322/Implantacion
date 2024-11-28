// Obtener el botón y el contenedor de las pestañas
    const verButton = document.getElementById("verButton");
    const tabsContainer = document.getElementById("consultaTabs");

    verButton.addEventListener('click', function() {
        // Verificamos el estilo de visualización actual
        if (tabsContainer.style.display === 'none' || tabsContainer.style.display === '') {
            // Mostrar las pestañas
            tabsContainer.style.display = 'block';
            // Cambiar el texto del botón
            this.textContent = 'Ocultar Opciones';
        } else {
            // Ocultar las pestañas
            tabsContainer.style.display = 'none';
            // Restaurar el texto del botón
            this.textContent = 'Ver';
        }
    });