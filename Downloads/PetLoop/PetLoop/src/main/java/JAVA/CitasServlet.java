package JAVA;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CitasServlet")
public class CitasServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Cambiar según las credenciales de tu base de datos
    private final String DB_URL = "jdbc:mysql://localhost:3306/petloop";
    private final String DB_USER = "root";
    private final String DB_PASSWORD = "";  // Cambiar según sea necesario

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recibir datos del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        String mascota = request.getParameter("mascota");
        String motivo = request.getParameter("motivo");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Cargar el driver y establecer conexión
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Consulta SQL para insertar los datos en la tabla 'citas'
            String insertQuery = "INSERT INTO citas (nombre, email, telefono, fecha, hora, mascota, motivo) VALUES (?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, nombre);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, telefono);
            preparedStatement.setString(4, fecha);
            preparedStatement.setString(5, hora);
            preparedStatement.setString(6, mascota);
            preparedStatement.setString(7, motivo);

            // Ejecutar la inserción
            int rowsInserted = preparedStatement.executeUpdate();

            // Enviar una respuesta de éxito
            if (rowsInserted > 0) {
                response.setStatus(HttpServletResponse.SC_OK); // Código de éxito
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudieron insertar los datos.");
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la conexión: " + e.getMessage());
        } finally {
            // Cerrar recursos
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
