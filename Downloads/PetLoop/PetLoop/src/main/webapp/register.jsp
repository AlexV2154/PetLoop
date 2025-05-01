<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="img/logo.png" type="icon">
        <link rel="stylesheet" href="css/RegisterStyle.css">
        <link rel='stylesheet' href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
        <title>Página de Registro</title>
    </head>
    <body>
        <div class="return">
            <a href="login.jsp"><i class='bx bx-caret-left-circle'></i></a>
        </div>

        <section>
            <form action="register.jsp?action=add" method="post">
                <h1>Registrarse</h1>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="text" id="txtnombre" name="txtnombre" required>
                    <label for="">Nombre</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="text" id="txtapellido" name="txtapellido" required>
                    <label for="">Apellidos</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="text" id="txtdni" name="txtdni" minlength="8" required>
                    <label for="">DNI</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="tel" id="txttelefono" name="txttelefono" minlength="9" required>
                    <label for="">Teléfono</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="text" id="txtdireccion" name="txtdireccion" required>
                    <label for="">Dirección</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="email" id="txtcorreo" name="txtcorreo" required>
                    <label for="">Correo</label>
                </div>
                <div class="inputbox">
                    <ion-icon name="lock-closed-outline"></ion-icon>
                    <input type="password" id="txtpassword" name="txtpassword" required>
                    <label for="">Contraseña</label>
                </div>
                <button type="submit">Registrar</button>
            </form>

            <%
                String successMessage = null;
                String errorMessage = null;

                String url = "jdbc:mysql://localhost:3306/petloop?user=root&password=Pass&useUnicode=true&characterEncoding=UTF-8";
                String username = "root";
                String password = "";

                Connection connection = null;
                PreparedStatement preparedStatement = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(url, username, password);

                    String action = request.getParameter("action");
                    if ("add".equals(action)) {
                        String nombre = request.getParameter("txtnombre");
                        String apellidos = request.getParameter("txtapellido");
                        String telefono = request.getParameter("txttelefono");
                        String dni = request.getParameter("txtdni");
                        String direccion = request.getParameter("txtdireccion");
                        String correo = request.getParameter("txtcorreo");
                        String contraseña = request.getParameter("txtpassword");

                        // Encriptar la contraseña
                        String hashedPassword = BCrypt.hashpw(contraseña, BCrypt.gensalt());

                        String insertQuery = "INSERT INTO clientes (nombre, apellidos, telefono, dni, direccion, correo, contraseña) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(insertQuery);
                        preparedStatement.setString(1, nombre);
                        preparedStatement.setString(2, apellidos);
                        preparedStatement.setString(3, telefono);
                        preparedStatement.setString(4, dni);
                        preparedStatement.setString(5, direccion);
                        preparedStatement.setString(6, correo);
                        preparedStatement.setString(7, hashedPassword); // Usar la contraseña encriptada

                        int rowsAffected = preparedStatement.executeUpdate();
                        if (rowsAffected > 0) {
                            successMessage = "Registro exitoso";
                        } else {
                            errorMessage = "Error al registrar";
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    errorMessage = "Error en la conexión: " + e.getMessage();
                } finally {
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                }
            %>

            <script>
                <% if (successMessage != null) { %>
                    Swal.fire({
                        title: '¡Éxito!',
                        text: '<%= successMessage %>',
                        icon: 'success',
                        confirmButtonText: 'Aceptar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = 'login.jsp';
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