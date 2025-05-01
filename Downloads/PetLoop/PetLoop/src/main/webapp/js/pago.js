document.addEventListener('DOMContentLoaded', () => {
    setTimeout(() => {
        console.log('Intentando mostrar productos en el carrito.');
        
        const productos = JSON.parse(localStorage.getItem('carrito')) || [];
        const cartItemsContainer = document.getElementById('cart-items');
        const totalPriceElement = document.getElementById('total-price');

        if (productos.length === 0) {
            cartItemsContainer.innerHTML = "<p>No hay productos en el carrito.</p>";
        } else {
            let total = 0;
            productos.forEach((producto) => {
                const item = document.createElement("div");
                item.classList.add("product-item");

                const tallaHTML = producto.talla ? `<span class="product-talla">Talla: ${producto.talla}</span>` : '';

                item.innerHTML = `
                    <img src="${producto.imagen}" alt="${producto.nombre}" class="product-image" />
                    <span class="product-title">${producto.nombre}</span>
                    <span class="product-price">S/.${producto.precio.toFixed(2)}</span>
                    ${tallaHTML}
                    <span class="product-quantity">Cantidad: ${producto.cantidad}</span>
                `;
                
                cartItemsContainer.appendChild(item);
                total += producto.precio * producto.cantidad;
            });

            totalPriceElement.innerText = `Total: S/.${total.toFixed(2)}`;
        }
    }, 1000); // Retraso de 1 segundo para asegurar que el DOM esté completamente cargado
});


document.addEventListener("DOMContentLoaded", () => {
    // Obtener los productos del carrito desde localStorage
    const productos = JSON.parse(localStorage.getItem('carrito')) || [];

    // Obtener el contenedor de la tabla
    const cartItemsTable = document.getElementById("cart-items-table");

    // Limpiar el contenido de la tabla
    cartItemsTable.innerHTML = "";

    if (productos.length === 0) {
        const row = cartItemsTable.insertRow();
        const cell = row.insertCell();
        cell.colSpan = 5;
        cell.textContent = "No hay productos en el carrito.";
        return;
    }

    // Crear las filas de la tabla
    productos.forEach((producto) => {
        const row = cartItemsTable.insertRow();

        // Imagen
        const cellImagen = row.insertCell();
        const img = document.createElement("img");
        img.src = producto.imagen;
        img.alt = producto.nombre;
        img.classList.add("product-image");
        cellImagen.appendChild(img);

        // Nombre
        const cellNombre = row.insertCell();
        cellNombre.textContent = producto.nombre;

        // Precio
        const cellPrecio = row.insertCell();
        cellPrecio.textContent = `S/.${producto.precio.toFixed(2)}`;

        // Talla (si aplica)
        const cellTalla = row.insertCell();
        cellTalla.textContent = producto.talla ? producto.talla : "N/A";

        
        // Cantidad (solo lectura, no editable)
        const cellCantidad = row.insertCell();
        const cantidadSpan = document.createElement("span");
        cantidadSpan.textContent = producto.cantidad;
        cellCantidad.appendChild(cantidadSpan);
    });

    // Mostrar el total del carrito
    actualizarTotal(productos);

});

// Función para actualizar el total del carrito
function actualizarTotal(productos) {
    const total = productos.reduce((acc, producto) => acc + producto.precio * producto.cantidad, 0);
    const totalContainer = document.getElementById("total-container");

    // Mostrar el total en el contenedor
    totalContainer.innerHTML = `Total: S/.${total.toFixed(2)}`;
}

