document.addEventListener("DOMContentLoaded", () => {
    // Mensajes de confirmación para eliminar usuarios
    document.querySelectorAll(".btn-danger").forEach((button) => {
        button.addEventListener("click", (e) => {
            if (!confirm("¿Estás seguro de que deseas eliminar este usuario?")) {
                e.preventDefault();
            }
        });
    });
});
