<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Iniciar sesión - Pet Shop</title>
        <link rel="icon" href="img/logo.png" type="icon">
        <link rel="stylesheet" href="css/LoginStyle.css">
        <link rel='stylesheet' href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
    </head>
    <body>
        <div class="return">
            <a href="index.jsp"><i class='bx bx-caret-left-circle'></i></a>
        </div>

        <section>
            <form action="login.jsp?action=login" method="post">
                <div class="imagen"><i class='bx bxs-user'></i></div>
                <h1>Iniciar sesión</h1>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="email" id="correo" name="correo" required>
                    <label for="">Correo</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="password" id="contraseña" name="contraseña" required>
                    <label for="">Contraseña</label>
                </div>
                <button type="submit">Iniciar</button>
                <div class="register">
                    <p>No tiene una cuenta <a href="register.jsp">Registrarse</a></p>
                </div>
            </form>
            
            <%
                String successMessage = null;
                String errorMessage = null;

                String url = "jdbc:mysql://localhost:3306/petloop?user=root&password=Pass&useUnicode=true&characterEncoding=UTF-8";
                String username = "root";
                String password = "";

                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, username, password);

                    String action = request.getParameter("action");
                    if ("login".equals(action)) {
                        String correo = request.getParameter("correo");
                        String contraseña = request.getParameter("contraseña");

                        String selectQuery = "SELECT * FROM clientes WHERE correo = ?";
                        preparedStatement = connection.prepareStatement(selectQuery);
                        preparedStatement.setString(1, correo);
                        resultSet = preparedStatement.executeQuery();

                        if (resultSet.next()) {
                            String storedHashedPassword = resultSet.getString("contraseña");

                            if (BCrypt.checkpw(contraseña, storedHashedPassword)) {
                                successMessage = "Inicio de sesión exitoso";
                                // Redirigir a la página de inicio
                                response.sendRedirect("index.jsp");
                            } else {
                                errorMessage = "Correo o contraseña incorrectos";
                            }
                        } else {
                            errorMessage = "Correo o contraseña incorrectos";
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMessage = "Error en la conexión: " + e.getMessage();
                } finally {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (resultSet != null) {
                        resultSet.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            %>

            <script>
                <% if (successMessage != null) { %>
                    Swal.fire({
                        title: '¡Bienvenido!',
                        text: '<%= successMessage %>',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'index.jsp';
                        }
                    });
                <% } else if (errorMessage != null) { %>
                    Swal.fire({
                        title: '¡Error!',
                        text: '<%= errorMessage %>',
                        icon: 'error',
                        confirmButtonText: 'Aceptar'
                    });
                <% } %>
            </script>

        </section>
    </body>
</html>