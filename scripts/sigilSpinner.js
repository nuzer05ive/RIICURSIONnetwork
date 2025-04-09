document.addEventListener("DOMContentLoaded", () => {
  const sigil = document.getElementById("sigil");
  sigil.addEventListener("click", () => {
    sigil.style.animationDuration = "2s";
    setTimeout(() => {
      sigil.style.animationDuration = "8s";
    }, 2000);
  });
});
