document.addEventListener("DOMContentLoaded", function() {
  // Datos de ejemplo
  const citas = {
    individuales: 25,
    pareja: 15,
    adolescentes: 12,
    niños: 20
  };

  // Actualizar contadores
  document.getElementById("individuales").innerText = citas.individuales;
  document.getElementById("pareja").innerText = citas.pareja;
  document.getElementById("adolescentes").innerText = citas.adolescentes;
  document.getElementById("niños").innerText = citas.niños;

  // Datos para los gráficos
  const labels = ["Individuales", "Pareja", "Adolescentes", "Niños"];
  const data = [
    citas.individuales,
    citas.pareja,
    citas.adolescentes,
    citas.niños
  ];

  // Gráfico de Barras
  new Chart(document.getElementById("barChart"), {
    type: "bar",
    data: {
      labels: labels,
      datasets: [
        {
          label: "Citas",
          data: data,
          backgroundColor: ["#007bff", "#28a745", "#ffc107", "#dc3545"],
          borderColor: ["#0056b3", "#19692c", "#b38600", "#8b1a1a"],
          borderWidth: 1
        }
      ]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });

  // Gráfico de Pastel
  new Chart(document.getElementById("pieChart"), {
    type: "pie",
    data: {
      labels: labels,
      datasets: [
        {
          data: data,
          backgroundColor: ["#007bff", "#28a745", "#ffc107", "#dc3545"]
        }
      ]
    },
    options: {
      responsive: true
    }
  });
});
