<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Resumen de Compra</title>
    <link rel="stylesheet" href="css/pagoStyle.css?v=1.0">
    <link rel="icon" href="img/logo.png" type="icon">

    <style>
        /* Estilos para la ventana modal */
        .modal {
            display: none; 
            position: fixed; 
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            text-align: center;
        }
        .modal-content img {
            width: 50%;
        }
        .modal-footer {
            margin-top: 20px;
        }
        .modal-footer button {
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
        }
        .modal-summary table {
            width: 100%;
            border-collapse: collapse;
        }
        .modal-summary th, .modal-summary td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="cart-sidebar" id="cartSidebar">
        <h2>Resumen del carrito</h2>
        <table id="cart-table" border="1">
            <thead>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Talla</th>
                    <th>Cantidad</th>
                </tr>
            </thead>
            <tbody id="cart-items-table">
                <!-- Aquí se llenarán los productos -->
            </tbody>
        </table>

        <div id="total-container">
            <strong id="total-price">Total: S/.0.00</strong>
        </div>

        <!-- Formulario de Datos de Facturación -->
        <h3>Datos de Facturación</h3>
        <form id="factura-form" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="nombre">Nombre *</label>
                <input type="text" id="nombre" name="nombre" required>
            </div>

            <div class="form-group">
                <label for="apellidos">Apellidos *</label>
                <input type="text" id="apellidos" name="apellidos" required>
            </div>

            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="telefono">Teléfono *</label>
                <input type="text" id="telefono" name="telefono" required>
            </div>

            <div class="form-group">
                <label for="direccion">Dirección *</label>
                <input type="text" id="direccion" name="direccion" required>
            </div>

            <div class="form-group">
                <label for="documento">Tipo de documento *</label>
                <select id="documento" name="documento" required>
                    <option value="DNI">DNI</option>
                    <option value="RUC">RUC</option>
                    <option value="Boleta">Boleta</option>
                </select>
            </div>

            <div class="form-group">
                <label for="numero_documento">Número de documento *</label>
                <input type="text" id="numero_documento" name="numero_documento" required>
            </div>

            <!-- Opciones de Pago -->
            <h4>Selecciona el Método de Pago</h4>
            <div class="payment-options">
                
                <input type="radio" id="yape" name="pago" value="Yape">
                <label for="yape">YAPE (en línea)</label>

                <input type="radio" id="plin" name="pago" value="Plin">
                <label for="plin">PLIN (en línea)</label>
            </div>
            <a href="index.jsp" class="btn" id="checkout-btn">Seguir comprando</a>
            <button type="submit" class="btn" id="submit-btn">Realizar el Pedido</button>
        </form>
    </div>

    <!-- Ventana Modal para Yape -->
    <div id="yape-modal" class="modal">
        <div class="modal-content">
            <img src="img/yape.jpeg" alt="Yape">
            <h2>Resumen de Compra</h2>
            <div id="modal-summary-yape" class="modal-summary">
                <!-- Aquí se llenará el resumen de la compra -->
            </div>
            <div class="modal-footer">
                <button id="ok-btn-yape">OK</button>
                <button id="back-btn-yape">Volver</button>
            </div>
        </div>
    </div>

    <!-- Ventana Modal para Plin -->
    <div id="plin-modal" class="modal">
        <div class="modal-content">
            <img src="img/plin.jpeg" alt="Plin">
            <h2>Resumen de Compra</h2>
            <div id="modal-summary-plin" class="modal-summary">
                <!-- Aquí se llenará el resumen de la compra -->
            </div>
            <div class="modal-footer">
                <button id="ok-btn-plin">OK</button>
                <button id="back-btn-plin">Volver</button>
            </div>
        </div>
    </div>

    <script src="js/pago.js?v=1.0"></script>

    <script>
        // Función para validar el formulario antes de enviar
        function validateForm() {
            var nombre = document.getElementById("nombre").value;
            var apellidos = document.getElementById("apellidos").value;
            var email = document.getElementById("email").value;
            var telefono = document.getElementById("telefono").value;
            var direccion = document.getElementById("direccion").value;
            var documento = document.getElementById("documento").value;
            var numero_documento = document.getElementById("numero_documento").value;
            var metodoPago = document.querySelector('input[name="pago"]:checked');

            // Verificar si todos los campos requeridos están llenos
            if (nombre === "" || apellidos === "" || email === "" || telefono === "" || direccion === "" || documento === "" || numero_documento === "" || !metodoPago) {
                alert("Por favor, complete todos los campos del formulario.");
                return false; // Impide el envío del formulario si algún campo está vacío
            }
            return true; // Permite el envío si todos los campos están completos
        }

        // Evento para el botón "Realizar el Pedido"
        document.getElementById("submit-btn").addEventListener("click", function(event) {
            event.preventDefault();
            
            // Llama a la validación del formulario
            if (validateForm()) {
                // Verifica si se ha seleccionado Yape
                if (document.getElementById("yape").checked) {
                    // Muestra la ventana modal de Yape
                    document.getElementById("yape-modal").style.display = "block";
                    generateModalSummary("yape");

                // Verifica si se ha seleccionado Plin
                } else if (document.getElementById("plin").checked) {
                    // Muestra la ventana modal de Plin
                    document.getElementById("plin-modal").style.display = "block";
                    generateModalSummary("plin");

                } else {
                    // Si no se seleccionó Yape ni Plin, sigue con el flujo normal
                    document.getElementById("factura-form").submit();
                }
            }
        });

        function generateModalSummary(paymentMethod) {
            var cartItems = document.getElementById("cart-items-table").getElementsByTagName("tr");
            var modalSummary = document.getElementById("modal-summary-" + paymentMethod);
            var total = 0;

            // Crear una tabla para el resumen en el modal
            var table = document.createElement("table");
            var tableHeader = "<thead><tr><th>Imagen</th><th>Nombre</th><th>Precio</th><th>Talla</th><th>Cantidad</th></tr></thead><tbody>";
            table.innerHTML = tableHeader;

            for (var i = 0; i < cartItems.length; i++) {
                var product = cartItems[i];
                var cells = product.getElementsByTagName("td");
                var img = cells[0].querySelector("img").src;
                var name = cells[1].innerText;
                var price = parseFloat(cells[2].innerText.replace('S/.','').trim());
                var quantity = parseInt(cells[4].innerText);
                
                total += price * quantity;
                table.innerHTML += "<tr><td><img src='" + img + "' alt='product'></td><td>" + name + "</td><td>S/." + price + "</td><td>" + cells[3].innerText + "</td><td>" + quantity + "</td></tr>";
            }
            table.innerHTML += "</tbody>";
            modalSummary.innerHTML = table.outerHTML;
            document.getElementById("total-price").innerText = "Total: S/." + total.toFixed(2);
        }

        // Función para cerrar el modal
        function closeModal(paymentMethod) {
            document.getElementById(paymentMethod + "-modal").style.display = "none";
        }

        // Evento para el botón "Volver" en Yape
        document.getElementById("back-btn-yape").addEventListener("click", function() {
            closeModal("yape");
        });

        // Evento para el botón "Volver" en Plin
        document.getElementById("back-btn-plin").addEventListener("click", function() {
            closeModal("plin");
        });
        
        // Evento para el botón "OK" en Yape
document.getElementById("ok-btn-yape").addEventListener("click", function() {
    storeDataInSession("yape"); // Almacena los datos en la sesión
    window.location.href = "boleta.jsp"; // Redirige a boleta.jsp
});

document.getElementById("ok-btn-plin").addEventListener("click", function() {
    storeDataInSession("plin"); // Almacena los datos en la sesión
    window.location.href = "boleta.jsp"; // Redirige a boleta.jsp
});

function storeDataInSession(paymentMethod) {
    var cartItems = document.getElementById("cart-items-table").getElementsByTagName("tr");
    var total = 0;
    var items = [];
    
    for (var i = 0; i < cartItems.length; i++) {
        var product = cartItems[i];
        var cells = product.getElementsByTagName("td");
        var img = cells[0].querySelector("img").src;
        var name = cells[1].innerText;
        var price = parseFloat(cells[2].innerText.replace('S/.','').trim());
        var quantity = parseInt(cells[4].innerText);
        
        total += price * quantity;

        items.push({
            img: img,
            name: name,
            price: price,
            size: cells[3].innerText,
            quantity: quantity
        });
    }

    // Usamos sessionStorage para almacenar los datos (esto se puede cambiar a session en Java si se prefiere)
    sessionStorage.setItem("cartItems", JSON.stringify(items));
    sessionStorage.setItem("total", total.toFixed(2));
    sessionStorage.setItem("billingData", JSON.stringify({
        nombre: document.getElementById("nombre").value,
        apellidos: document.getElementById("apellidos").value,
        email: document.getElementById("email").value,
        telefono: document.getElementById("telefono").value,
        direccion: document.getElementById("direccion").value,
        documento: document.getElementById("documento").value,
        numero_documento: document.getElementById("numero_documento").value,
        metodoPago: paymentMethod
    }));
}

    </script>
    
    
</body>
</html>
