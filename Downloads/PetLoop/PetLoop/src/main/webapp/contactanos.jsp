<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="img/logo.png" type="icon">
    <link rel="stylesheet" href="css/ContactanosStyle.css?v=1.0">
    <title>Contacto - PetLoop</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
    <!-- SweetAlert2 Theme (dark theme in this case) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark/dark.css">
    <script src="js/script.js" defer></script>
</head>
<body>
    <!-- Encabezado -->
    <header class="header" data-header>
        <div class="container">
            <button class="nav-toggle-btn" aria-label="toggle menu" data-nav-toggler>
                <ion-icon name="menu-outline" aria-hidden="true" class="menu-icon"></ion-icon>
                <ion-icon name="close-outline" aria-label="true" class="close-icon"></ion-icon>
            </button>
            <a href="#" class="logo">PetLoop</a>
            <nav class="navbar" data-navbar>
                <ul class="navbar-list">
                    <li class="navbar-item"><a href="index.jsp" class="navbar-link" data-nav-link>Inicio</a></li>
                    <li class="navbar-item"><a href="index.jsp#MisionyVision" class="navbar-link" data-nav-link>Nosotros</a></li>
                    <li class="navbar-item"><a href="blogs.jsp" class="navbar-link" data-nav-link>Blogs</a></li>
                    <li class="navbar-item"><a href="busqueda.jsp" class="navbar-link" data-nav-link>Catálogo</a></li>
                    <li class="navbar-item"><a href="citas.jsp" class="navbar-link" data-nav-link>Citas</a></li>
                    <li class="navbar-item"><a href="contactanos.jsp" class="navbar-link" data-nav-link>Contáctanos</a></li>
                </ul>
                <a href="login.jsp" class="navbar-action-btn">Iniciar Sesión</a>
            </nav>
            <div class="header-actions">
                <button class="action-btn" aria-label="Search"><ion-icon name="search-outline" aria-hidden="true"></ion-icon></button>
                <button class="action-btn user" aria-label="User"><ion-icon name="person-outline" aria-hidden="true"></ion-icon></button>
                <button class="action-btn" aria-label="cart"><ion-icon name="bag-handle-outline" aria-hidden="true"></ion-icon><span class="btn-badge">0</span></button>
            </div>
        </div>
    </header>

    <!-- Formulario de contacto -->
    <main>
        <section class="contact-form">
            <div class="container">
                <h1>Contacto</h1>
                <form id="contactForm" action="ContactoServlet" method="post">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Correo electrónico:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono:</label>
                        <input type="tel" id="telefono" name="telefono">
                    </div>
                    <div class="form-group">
                        <label for="mensaje">Mensaje:</label>
                        <textarea id="mensaje" name="mensaje" rows="5" required></textarea>
                    </div>
                    <button type="submit">Enviar</button>
                </form>
            </div>
        </section>
    </main>

    <!-- Manejo del formulario con SweetAlert -->
    <script>
        document.getElementById('contactForm').addEventListener('submit', function(event) {
            event.preventDefault(); // Prevenir el envío automático del formulario

            fetch('ContactoServlet', {
                method: 'POST',
                body: new URLSearchParams(new FormData(event.target)) // Recoger los datos del formulario
            })
            .then(response => {
                if (response.ok) {
                    Swal.fire({
                        position: "top-end",
                        icon: "success",
                        title: "Su mensaje ha sido enviado con éxito",
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        window.location.href = 'index.jsp'; // Redirigir después de la confirmación
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "Oops...",
                        text: "Hubo un problema al enviar su mensaje."
                    });
                }
            })
            .catch(error => {
                Swal.fire({
                    icon: "error",
                    title: "Oops...",
                    text: "Ocurrió un error en la red o con el servidor."
                });
            });
        });
    </script>

    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <a href="https://api.whatsapp.com/send?phone=986363462&text=Hola,%20sean%20bienvenidos!%20:)" class="float" target="_blank">
        <i class="fa fa-whatsapp my-float"></i>
    </a>
</body>
</html>