
        document.getElementById('discapacitado').addEventListener('change', function() {
            var descripDiscaGroup = document.getElementById('descrip_disca_group');
            if (this.value == '1') {
                descripDiscaGroup.style.display = 'block';
            } else {
                descripDiscaGroup.style.display = 'none';
            }
        });
  