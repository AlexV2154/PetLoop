<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Libro de Reclamaciones - PetLoop</title>
    <link rel="stylesheet" href="css/ReclamacionesStyle.css">
    <link rel="icon" href="img/logo.png" type="icon">

    <style>
        /* Estilo para el mensaje flotante */
        .toast {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            top: 30px;
            font-size: 17px;
        }

        .toast.show {
            visibility: visible;
            animation: fadein 0.5s, fadeout 0.5s 2.5s;
        }

        @keyframes fadein {
            from {top: 0; opacity: 0;}
            to {top: 30px; opacity: 1;}
        }

        @keyframes fadeout {
            from {top: 30px; opacity: 1;}
            to {top: 0; opacity: 0;}
        }
    </style>
</head>
<body>
<section class="reclamaciones" id="libro-reclamaciones" aria-label="Libro de Reclamaciones">
    <div class="container">
        <h2 class="section-title">Libro de Reclamaciones</h2>

        <% 
        String mensaje = ""; 
        boolean redirigir = false; // Bandera para redirección
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Obtener los datos del formulario
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");
            String tipo = request.getParameter("tipo");
            String mensajeReclamacion = request.getParameter("mensaje");

            // Validar que no haya campos vacíos
            if (nombre.isEmpty() || email.isEmpty() || tipo.isEmpty() || mensajeReclamacion.isEmpty()) {
                mensaje = "Por favor, completa todos los campos.";
            } else {
                // Conexión a la base de datos y ejecución de la consulta
                Connection connection = null;
                PreparedStatement statement = null;
                try {
                    // Conexión a la base de datos
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/petloop", "root", "");
                    String sql = "INSERT INTO reclamaciones (nombre, email, tipo, mensaje) VALUES (?, ?, ?, ?)";
                    statement = connection.prepareStatement(sql);
                    statement.setString(1, nombre);
                    statement.setString(2, email);
                    statement.setString(3, tipo);
                    statement.setString(4, mensajeReclamacion);
                    int rowsInserted = statement.executeUpdate();

                    if (rowsInserted > 0) {
                        redirigir = true; // Indicar que la redirección debe ocurrir
                    } else {
                        mensaje = "Hubo un error al enviar tu reclamación. Por favor, inténtalo nuevamente.";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    mensaje = "Error en la base de datos: " + e.getMessage();
                } finally {
                    try {
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            // Redirigir si se completó exitosamente
            if (redirigir) {
                response.sendRedirect("index.jsp");
                return; // Salir para evitar que se genere más contenido
            }
        }
        %>

        <!-- Agregar un div para el mensaje flotante -->
        <div id="toast" class="toast">
            <%= mensaje %>
        </div>

        <!-- Formulario para la reclamación -->
        <form id="form-reclamacion" action="" method="POST">
            <div class="form-group">
                <label for="nombre">Nombre Completo</label>
                <input type="text" id="nombre" name="nombre" placeholder="Ingresa tu nombre" required>
            </div>
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="Ejemplo: correo@dominio.com" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo de Reclamación</label>
                <select id="tipo" name="tipo" required>
                    <option value="">Selecciona un tipo</option>
                    <option value="Queja">Queja</option>
                    <option value="Sugerencia">Sugerencia</option>
                    <option value="Consulta">Consulta</option>
                </select>
            </div>
            <div class="form-group">
                <label for="mensaje">Descripción de la Reclamación</label>
                <textarea id="mensaje" name="mensaje" rows="5" placeholder="Escribe tu reclamación..." required></textarea>
            </div>
            <button type="submit" class="btn">Enviar Reclamación</button>
        </form>
    </div>
</section>

<script>
    // Mostrar el mensaje flotante si hay uno
    <% if (mensaje != null && !mensaje.isEmpty()) { %>
        document.addEventListener("DOMContentLoaded", function() {
            var toast = document.getElementById("toast");
            toast.classList.add("show");
        });
    <% } %>
</script>
<script src="js/reclamaciones.js"></script>
</body>
</html>