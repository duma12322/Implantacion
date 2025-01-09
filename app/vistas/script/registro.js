document.addEventListener('DOMContentLoaded', function () {
    // Cargar estados
    fetch('obtener_estados.php')
        .then(response => response.json())
        .then(data => {
            const estadoSelect = document.getElementById('estado');
            data.forEach(estado => {
                const option = document.createElement('option');
                option.value = estado.id_estado;
                option.textContent = estado.estado;
                estadoSelect.appendChild(option);
            });
        });

    // Cargar ciudades y municipios basados en el estado seleccionado
    document.getElementById('estado').addEventListener('change', function () {
        const estadoId = this.value;

        // Cargar ciudades
        fetch(`obtener_ciudades.php?estado=${estadoId}`)
            .then(response => response.json())
            .then(data => {
                const ciudadSelect = document.getElementById('ciudad');
                ciudadSelect.innerHTML = '<option disabled selected>Seleccione su ciudad</option>';
                data.forEach(ciudad => {
                    const option = document.createElement('option');
                    option.value = ciudad.id_ciudad;
                    option.textContent = ciudad.ciudad;
                    ciudadSelect.appendChild(option);
                });
            });

        // Cargar municipios
        fetch(`obtener_municipios.php?estado=${estadoId}`)
            .then(response => response.json())
            .then(data => {
                const municipioSelect = document.getElementById('municipio');
                municipioSelect.innerHTML = '<option disabled selected>Seleccione su municipio</option>';
                data.forEach(municipio => {
                    const option = document.createElement('option');
                    option.value = municipio.id_municipio;
                    option.textContent = municipio.municipio;
                    municipioSelect.appendChild(option);
                });
            });
    });

    // Cargar parroquias basadas en el municipio seleccionado
    document.getElementById('municipio').addEventListener('change', function () {
        const municipioId = this.value;
        fetch(`obtener_parroquias.php?municipio=${municipioId}`)
            .then(response => response.json())
            .then(data => {
                const parroquiaSelect = document.getElementById('parroquia');
                parroquiaSelect.innerHTML = '<option disabled selected>Seleccione su parroquia</option>';
                data.forEach(parroquia => {
                    const option = document.createElement('option');
                    option.value = parroquia.id_parroquia;
                    option.textContent = parroquia.parroquia;
                    parroquiaSelect.appendChild(option);
                });
            });
    });
});
