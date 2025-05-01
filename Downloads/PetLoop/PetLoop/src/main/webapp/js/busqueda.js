document.addEventListener("DOMContentLoaded", function () {
    // Obtenemos el formulario de búsqueda y el botón de búsqueda
    const searchForm = document.querySelector('.search-bar');
    const searchButton = document.querySelector('.search-button');
    const searchInput = document.querySelector('.search-input');

    // Agregamos un evento de clic al botón de búsqueda
    searchButton.addEventListener('click', function (e) {
        // Prevenimos que el formulario se envíe de forma predeterminada
        e.preventDefault();

        // Obtenemos el valor del input de búsqueda
        const query = searchInput.value.trim();

        // Si el campo está vacío, mostramos todos los productos
        if (query === '') {
            // Redirigir a la misma página pero sin parámetros de búsqueda
            window.location.href = "busqueda.jsp";
        } else {
            // Si hay texto en el campo de búsqueda, enviamos el formulario
            searchForm.submit();
        }
    });

    // También agregamos un evento de 'enter' al campo de búsqueda para enviar el formulario
    searchInput.addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();  // Prevenimos el comportamiento por defecto del Enter
            searchButton.click();  // Simulamos un clic en el botón de búsqueda
        }
    });
});