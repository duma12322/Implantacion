document.addEventListener('DOMContentLoaded', function() {
  const sidebar = document.querySelector(".sidebar");
  const sidebarToggler = document.querySelector(".sidebar-toggler");

  // Asegúrate de que las alturas coincidan con las definidas en CSS
  let collapsedSidebarHeight = "56px"; // Altura en vista móvil (colapsada)

  // Comprobar el estado del sidebar en el almacenamiento local
  const savedState = localStorage.getItem('sidebar-collapsed');
  if (savedState !== null && window.innerWidth < 480) {
    sidebar.classList.toggle('collapsed', JSON.parse(savedState));
  }

  // Toggle del estado colapsado del sidebar (mostrar/ocultar menú)
  sidebarToggler.addEventListener("click", () => {
    if (window.innerWidth < 480) {  // Solo actúa en pantallas menores a 480px
      sidebar.classList.toggle("collapsed");
      localStorage.setItem('sidebar-collapsed', sidebar.classList.contains("collapsed"));
    }
  });

  // Ajustar la altura del sidebar en función del tamaño de la ventana
  window.addEventListener("resize", () => {
    if (window.innerWidth < 480) {
      sidebar.style.height = sidebar.classList.contains("collapsed") ? collapsedSidebarHeight : "auto";
    } else {
      sidebar.style.height = "100vh";  // En pantallas grandes, el sidebar debe ocupar toda la altura
    }
  });
});
