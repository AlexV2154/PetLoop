class Carrito {
    constructor() {
        this.productos = JSON.parse(localStorage.getItem('carrito')) || [];
        this.carritoSidebar = document.getElementById("cartSidebar");
        this.cartItemsContainer = document.getElementById("cart-items");
        this.totalPriceElement = document.getElementById("total-price");
        this.btnBadge = document.querySelector('.btn-badge');
        this.productoTemporal = {}; // Producto temporal para manejar la selección de tallas

        this.mostrarCarrito();
        this.actualizarTotal();
        this.actualizarBadge();

        // Manejador para cerrar el carrito
        const cartCloseBtn = document.querySelector('.cart-close-btn');
        cartCloseBtn.addEventListener('click', () => {
            this.cerrarCarrito(); // Llama al nuevo método de cierre
        });
    }

    guardarEnLocalStorage() {
        localStorage.setItem('carrito', JSON.stringify(this.productos));
    }

    agregarProducto(id, nombre, precio, imagen) {
    const cantidad = 1; // Puede ser dinámico si es necesario

    const talla = this.productoTemporal.talla || ""; // Si es un producto con talla, se puede agregar

    // Realizar la solicitud AJAX para agregar el producto a la base de datos
    const formData = new FormData();
    formData.append('id', id);
    formData.append('nombre', nombre);
    formData.append('precio', precio);
    formData.append('imagen', imagen);
    formData.append('cantidad', cantidad);
    formData.append('talla', talla);

    fetch('CarritoServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        console.log(data); // Imprimir la respuesta del servidor
        if (data.includes("Error")) {
            alert("Hubo un error al agregar el producto al carrito.");
        } else {
            // Actualizar la interfaz de usuario si se agregó correctamente
            this.mostrarCarrito();
            this.actualizarTotal();
            this.actualizarBadge();
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

    agregarProductoConTalla(id, nombre, precio, imagen, talla) {
        const producto = {
            id,
            nombre,
            precio: parseFloat(precio),
            imagen,
            talla,
            cantidad: 1
        };
        this.productos.push(producto);
        this.mostrarCarrito();
        this.actualizarTotal();
        this.actualizarBadge();
        this.guardarEnLocalStorage();
    }

    mostrarCarrito() {
        this.cartItemsContainer.innerHTML = "";
        if (this.productos.length === 0) {
            this.cartItemsContainer.innerHTML = "<p>No hay productos en el carrito.</p>";
            this.cerrarCarrito(); // Si no hay productos, cierra el carrito
            return;
        }

        this.productos.forEach((producto) => {
            const item = document.createElement("div");
            item.classList.add("product-item");
            item.innerHTML = `
                <img src="${producto.imagen}" alt="${producto.nombre}" class="product-image" />
                <span class="product-title">${producto.nombre}</span>
                <span class="product-price">S/.${producto.precio.toFixed(2)}</span>
                ${producto.talla ? `<span class="product-talla">Talla: ${producto.talla}</span>` : ''}
                <span class="space-between"></span>
                <input type="number" value="${producto.cantidad}" min="1" class="product-quantity" data-id="${producto.id}" />
                <button class="remove-btn" data-id="${producto.id}">
                    <ion-icon name="trash-outline" aria-hidden="true"></ion-icon>
                </button>
            `;
            this.cartItemsContainer.appendChild(item);
        });

        this.carritoSidebar.classList.add("visible");
        this.carritoSidebar.style.display = "block"; // Asegúrate de mostrar el carrito
    }

    actualizarTotal() {
        const total = this.productos.reduce((acc, producto) => acc + producto.precio * producto.cantidad, 0);
        this.totalPriceElement.innerText = `Total: S/.${total.toFixed(2)}`;
    }

    actualizarBadge() {
        const totalItems = this.productos.reduce((acc, producto) => acc + producto.cantidad, 0);
        this.btnBadge.innerText = totalItems;
    }

    eliminarProducto(id) {
        this.productos = this.productos.filter(producto => producto.id !== id);
        this.mostrarCarrito();
        this.actualizarTotal();
        this.actualizarBadge();
        this.guardarEnLocalStorage();
    }

    cerrarCarrito() {
        this.carritoSidebar.classList.remove("visible"); // Remueve la clase visible
        this.carritoSidebar.style.display = "none"; // Asegúrate de que el carrito esté oculto
    }
}

// Instancia del carrito
const carrito = new Carrito();

// Manejar clics en botones "Agregar al carrito"
document.querySelectorAll('.card-action-btn').forEach((button) => {
    button.addEventListener('click', (event) => {
        const productCard = event.target.closest('.product-card');
        const id = productCard.getAttribute('data-id');
        const nombre = productCard.querySelector('.card-title').innerText;
        const precio = productCard.querySelector('.card-price').getAttribute('value');
        const imagen = productCard.querySelector('.default').src;

        if (button.classList.contains('show-modal-btn')) {
            // Producto con talla
            carrito.productoTemporal = { id, nombre, precio, imagen };
            document.getElementById('modal-container').style.display = 'flex';
        } else {
            // Producto sin talla
            carrito.agregarProducto(id, nombre, precio, imagen);
        }
    });
});

// Manejar clics en el botón del modal para agregar con talla
document.getElementById('add-to-cart').addEventListener('click', () => {
    const talla = document.getElementById('size-select').value;

    if (carrito.productoTemporal.id) {
        const { id, nombre, precio, imagen } = carrito.productoTemporal;
        carrito.agregarProductoConTalla(id, nombre, precio, imagen, talla);
        carrito.productoTemporal = {};
    }

    document.getElementById('modal-container').style.display = 'none';
});

// Manejar clics en botones "Eliminar" del carrito
document.getElementById("cart-items").addEventListener('click', (event) => {
    if (event.target.closest(".remove-btn")) {
        const id = event.target.closest(".remove-btn").getAttribute('data-id');
        carrito.eliminarProducto(id);
    }
});

// Manejar cambios en las cantidades de productos
document.getElementById("cart-items").addEventListener('input', (event) => {
    if (event.target.classList.contains("product-quantity")) {
        const id = event.target.getAttribute('data-id');
        const cantidad = parseInt(event.target.value);
        const producto = carrito.productos.find(p => p.id === id);

        if (producto) {
            producto.cantidad = cantidad;
            carrito.actualizarTotal();
            carrito.actualizarBadge();
            carrito.guardarEnLocalStorage();
        }
    }
});

// Manejar cierre del modal
document.getElementById('close-modal-btn').addEventListener('click', () => {
    document.getElementById('modal-container').style.display = 'none';
});

// Función para abrir y cerrar el carrito
function toggleCart() {
    if (carrito.carritoSidebar.classList.contains("visible")) {
        carrito.cerrarCarrito();
    } else {
        carrito.carritoSidebar.classList.add("visible");
        carrito.carritoSidebar.style.display = "block";
    }
}




