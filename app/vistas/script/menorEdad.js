
      document.getElementById('relacion_fecha_nac').addEventListener('blur', function() {
          let birthDate = new Date(this.value);
          let today = new Date();
          let age = today.getFullYear() - birthDate.getFullYear();
          let monthDifference = today.getMonth() - birthDate.getMonth();

          if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
              age--;
          }

          let ageWarning = document.getElementById('age-warning');
          if (age >= 18) {
              ageWarning.style.display = 'block';
              this.value = ''; // Reset the input field
          } else {
              ageWarning.style.display = 'none';
          }
      });
