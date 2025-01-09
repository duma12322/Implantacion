document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form"),
        nextBtn = form.querySelector(".nextBtn"),
        backBtn = form.querySelector(".backBtn"),
        allInput = form.querySelectorAll(".first input");

  // Next button functionality
  nextBtn.addEventListener("click", () => {
    allInput.forEach(input => {
      if (input.value != "") {
        form.classList.add("secActive");
      } else {
        form.classList.remove("secActive");
      }
    });
  });

  // Back button functionality with redirect to registro_paciente.php
  backBtn.addEventListener("click", () => {
    window.location.href = "registro_paciente.php"; // Redirect to the desired page
  });
});
