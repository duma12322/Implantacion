/*function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('main-content');
    sidebar.classList.toggle('open');
    content.classList.toggle('shift');
}*/

document.addEventListener('DOMContentLoaded', function() {
   const sidebar = document.querySelector(".sidebar");
   const sidebarToggler = document.querySelector(".sidebar-toggler");
   const menuToggler = document.querySelector(".menu-toggler");

   // Ensure these heights match the CSS sidebar height values
   let collapsedSidebarHeight = "56px"; // Height in mobile view (collapsed)
   let fullSidebarHeight = "calc(100vh - 32px)"; // Height in larger screen

   // Toggle sidebar's collapsed state
   sidebarToggler.addEventListener("click", () => {
     // Cambia el ícono según el estado del sidebar
     if (sidebar.classList.contains("collapsed")) {
       // Si está cerrado, cambia el ícono a caret-left (abierto)
       sidebarToggler.innerHTML = '<i class="bi bi-caret-left-square-fill"></i>';
     } else {
       // Si está abierto, cambia el ícono a caret-right (cerrado)
       sidebarToggler.innerHTML = '<i class="bi bi-caret-right-square-fill"></i>';
     }
     
     // Alternar la clase 'collapsed' para abrir/cerrar el sidebar
     sidebar.classList.toggle("collapsed");
   });

   // Update sidebar height and menu toggle text
   const toggleMenu = (isMenuActive) => {
     sidebar.style.height = isMenuActive ? `${sidebar.scrollHeight}px` : collapsedSidebarHeight;
     menuToggler.innerHTML = isMenuActive
  ? '<i class="bi bi-x-lg"></i>'  // Ícono de cerrar
  : '<i class="bi bi-list"></i>';  // Ícono de menú

   }

   // Toggle menu-active class and adjust height
   menuToggler.addEventListener("click", () => {
     toggleMenu(sidebar.classList.toggle("menu-active"));
   });

   // (Optional code): Adjust sidebar height on window resize
   window.addEventListener("resize", () => {
     if (window.innerWidth >= 1024) {
       sidebar.style.height = fullSidebarHeight;
     } else {
       sidebar.classList.remove("collapsed");
       sidebar.style.height = "auto";
       toggleMenu(sidebar.classList.contains("menu-active"));
     }
   });
});

