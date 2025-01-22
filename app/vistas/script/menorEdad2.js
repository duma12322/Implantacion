document.getElementById('relacion_fecha_nac').addEventListener('blur', function() {
    let birthDate = new Date(this.value);
    let today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    let monthDifference = today.getMonth() - birthDate.getMonth();

    if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }

    let ageWarning = document.getElementById('age-warning');
    let ageWarning12 = document.getElementById('age-warning-12');
    
    // Comprueba si la edad está entre 13 y 17 años inclusivos
    if (age > 12 && age < 18) {
        ageWarning.style.display = 'none';
        ageWarning12.style.display = 'none';
    } else if (age >= 18) {
        ageWarning.style.display = 'block';
        ageWarning12.style.display = 'none';
        this.value = ''; 
    } else if (age <= 12) {
        ageWarning12.style.display = 'block';
        ageWarning.style.display = 'none';
        this.value = ''; 
    }
});
