<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Boleta de Compra</title>
    <link rel="stylesheet" href="css/boletaStyle.css?v=1.0">
    <link rel="icon" href="img/logo.png" type="icon">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script> <!-- Incluir jsPDF -->
</head>
<body>
    <div class="container">
        <h2 class="title">Boleta de Compra</h2>
        <div id="billing-info" class="billing-info">
            <h3>Datos de Facturación</h3>
            <p><strong>Nombre:</strong> <span id="nombre"></span></p>
            <p><strong>Apellidos:</strong> <span id="apellidos"></span></p>
            <p><strong>Email:</strong> <span id="email"></span></p>
            <p><strong>Teléfono:</strong> <span id="telefono"></span></p>
            <p><strong>Dirección:</strong> <span id="direccion"></span></p>
            <p><strong>Tipo de Documento:</strong> <span id="documento"></span></p>
            <p><strong>Número de Documento:</strong> <span id="numero_documento"></span></p>
            <p><strong>Método de Pago:</strong> <span id="metodo_pago"></span></p>
        </div>

        <table id="cart-summary-table" class="cart-summary-table">
            <thead>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Talla</th>
                    <th>Cantidad</th>
                </tr>
            </thead>
            <tbody id="cart-summary-items">
                <!-- Aquí se llenarán los productos -->
            </tbody>
        </table>

        <div id="total-container" class="total-container">
            <strong id="total-price">Total: S/.0.00</strong>
        </div>

        <div class="button-container">
            <button onclick="window.location.href='index.jsp'" class="back-btn">Volver al inicio</button>
            <button onclick="generatePDF()" class="back-btn">Generar PDF</button> <!-- Botón para generar PDF -->
        </div>
    </div>

    <script>
        // Recupera los datos almacenados en sessionStorage
        var cartItems = JSON.parse(sessionStorage.getItem("cartItems"));
        var total = sessionStorage.getItem("total");
        var billingData = JSON.parse(sessionStorage.getItem("billingData"));

        // Rellena los datos de facturación
        document.getElementById("nombre").innerText = billingData.nombre;
        document.getElementById("apellidos").innerText = billingData.apellidos;
        document.getElementById("email").innerText = billingData.email;
        document.getElementById("telefono").innerText = billingData.telefono;
        document.getElementById("direccion").innerText = billingData.direccion;
        document.getElementById("documento").innerText = billingData.documento;
        document.getElementById("numero_documento").innerText = billingData.numero_documento;
        document.getElementById("metodo_pago").innerText = billingData.metodoPago;

        // Muestra los productos en el resumen
        var cartSummaryTable = document.getElementById("cart-summary-items");
        cartItems.forEach(function(item) {
            var row = "<tr><td><img src='" + item.img + "' alt='product' class='product-img' style='width: 30px; height: 30px;'></td><td>" + item.name + "</td><td>S/." + item.price + "</td><td>" + item.size + "</td><td>" + item.quantity + "</td></tr>";
            cartSummaryTable.innerHTML += row;
        });

        // Muestra el total
        document.getElementById("total-price").innerText = "Total: S/." + total;

        // Función para generar el PDF
        function generatePDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            // Título
            doc.setFontSize(22);
            doc.setFont("helvetica", "bold");
            doc.text("Boleta de Compra", 105, 20, null, null, "center");

            // Línea de separación
            doc.setLineWidth(0.5);
            doc.line(20, 25, 190, 25); 

            // Datos de facturación
            doc.setFontSize(14);
            doc.setFont("helvetica", "normal");
            doc.text("Datos de Facturación:", 20, 35);

            let yPosition = 45;
            doc.setFontSize(12);
            const billingDataLines = [
                "Nombre: " + billingData.nombre,
                "Apellidos: " + billingData.apellidos,
                "Email: " + billingData.email,
                "Teléfono: " + billingData.telefono,
                "Dirección: " + billingData.direccion,
                "Tipo de Documento: " + billingData.documento,
                "Número de Documento: " + billingData.numero_documento,
                "Método de Pago: " + billingData.metodoPago
            ];

            billingDataLines.forEach(line => {
                doc.text(line, 20, yPosition);
                yPosition += 8;
            });

            // Espacio entre datos de facturación y resumen
            yPosition += 12;
            doc.setFontSize(14);
            doc.setFont("helvetica", "bold");
            doc.text("Resumen de Compra:", 20, yPosition);
            yPosition += 12;

            // Tabla con los productos
            const tableColumnWidths = [70, 50, 30, 30]; // Ajusta el ancho de las columnas
            doc.setFontSize(12);
            doc.setFont("helvetica", "normal");

            // Cabecera de la tabla
            doc.setFillColor(200, 220, 255); // Color de fondo para la cabecera
            doc.rect(20, yPosition, tableColumnWidths[0] + tableColumnWidths[1] + tableColumnWidths[2] + tableColumnWidths[3], 10, "F");
            doc.text("Nombre", 25, yPosition + 7);
            doc.text("Precio", 75, yPosition + 7);
            doc.text("Talla", 125, yPosition + 7);
            doc.text("Cantidad", 155, yPosition + 7);

            // Productos
            yPosition += 12;
            cartItems.forEach(function(item) {
                // Agregar datos del producto sin la imagen
                doc.text(item.name, 25, yPosition + 10);
                doc.text("S/." + item.price, 75, yPosition + 10);
                doc.text(item.size, 125, yPosition + 10);
                doc.text(item.quantity.toString(), 155, yPosition + 10);
                yPosition += 12;
            });

            // Total
            doc.setFontSize(14);
            doc.setFont("helvetica", "bold");
            doc.text("Total: S/." + total, 20, yPosition + 10);

            // Línea de separación
            doc.setLineWidth(0.5);
            doc.line(20, yPosition + 15, 190, yPosition + 15);

            // Pie de página con la empresa o logo
            doc.setFontSize(10);
            doc.text("Gracias por tu compra en PetLoop", 105, yPosition + 25, null, null, "center");

            // Guardar el archivo PDF
            doc.save("boleta_compra.pdf");
        }

    </script>
</body>
</html>
