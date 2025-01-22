  
        function toggleDescriptionField() {
            var select = document.getElementById('relacion_discapacitado');
            var descriptionField = document.getElementById('descriptionField');
            if (select.value == "1") {
                descriptionField.style.display = 'block';
            } else {
                descriptionField.style.display = 'none';
            }
        }
  