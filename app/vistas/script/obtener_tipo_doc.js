
    // Llamada Ajax para obtener los tipos de documento desde el servidor
    fetch('obtener_tipo_doc.php')
        .then(response => response.json())
        .then(data => {
            let selectElement = document.getElementById('tipo_doc');
            selectElement.innerHTML = '';  // Limpiar las opciones anteriores
            let option = document.createElement('option');
            option.value = '';
            option.disabled = true;
            option.selected = true;
            option.textContent = 'Seleccione su tipo de documento';
            selectElement.appendChild(option);
            
            // Agregar todas las opciones (siempre los 4 valores posibles)
            data.forEach(item => {
                let option = document.createElement('option');
                option.value = item;
                option.textContent = item;
                selectElement.appendChild(option);
            });
        })
        .catch(error => console.error('Error:', error));

