<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement, java.util.HashMap, java.sql.SQLException" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/Size.css">

        <!-- Importar Ionicons -->
        <link rel="stylesheet" href="https://unpkg.com/ionicons@5.5.2/dist/ionicons.min.css">
        <link rel="stylesheet" href="css/CarritoStyle.css?v=1.0">
        <link rel="stylesheet" href="css/busquedaStyle.css?v=1.0">
        <link rel='stylesheet' href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
        <title>PetLoop - Tu tienda de mascotas</title>
        <meta name="title" content="PetLoop">
        <link rel="icon" href="img/logo.png" type="icon">

        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
          href="https://fonts.googleapis.com/css2?family=Bangers&family=Carter+One&family=Nunito+Sans:wght@400;700&display=swap"
          rel="stylesheet">

        <!-- Preload images -->
        <link rel="preload" as="image" href="img/hero-name.png">
    </head>
    
    <body>
        <!-- Header -->
        <header class="header" data-header>
            <div class="container">
                <button class="nav-toggle-btn" aria-label="toggle manu" data-nav-toggler>
                    <ion-icon name="menu-outline" aria-hidden="true" class="menu-icon"></ion-icon>
                    <ion-icon name="close-outline" aria-label="true" class="close-icon"></ion-icon>
                </button>

                <a href="index.jsp" class="logo">PetLoop</a>

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
                    <button class="action-btn user" aria-label="User">
                        <ion-icon name="person-outline" aria-hidden="true"></ion-icon>
                    </button>

                    <button class="action-btn" aria-label="cart" onclick="toggleCart()">
                        <ion-icon name="bag-handle-outline" aria-hidden="true"></ion-icon>
                        <span class="btn-badge">0</span>
                    </button>
                </div>
            </div>
            
            
            
            <!-- Carrito de Compras -->
            <div class="cart-sidebar" id="cartSidebar">
                <button class="cart-close-btn" aria-label="Cerrar carrito" onclick="toggleCart()">&times;</button>
                <h2>Tu Carrito</h2>
                <div id="cart-items">
                    <p>No hay productos en el carrito.</p>
                </div>
                <div id="total-container">
                    <strong id="total-price">Total: S/.0.00  </strong>
                </div>
                <a href="pago.jsp" class="btn" id="checkout-btn">Proceder al Pago</a>
            </div>
            
            <!-- Modal de Selección de Talla -->
            <div class="modal-container" id="modal-container">
                <div class="reference-image-container">
                    <img src="img/tallas.jpeg" alt="Referencia" class="reference-image">
                </div>
                <div class="modal">
                    <h2>Selecciona la Talla</h2>
                    <select id="size-select" class="select-size">
                        <option value="0">0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>
                    <div class="buttons-container">
                        <button id="add-to-cart" class="button add-to-cart-btn">Agregar al carrito</button>
                        <button id="close-modal-btn" class="button close-btn">Cerrar</button>
                    </div>
                </div>
            </div>
            
            
            
            
            
            <!-- Barra de Búsqueda -->
            <form action="busqueda.jsp" method="get" class="search-bar">
                <input 
                    type="text" 
                    name="query" 
                    placeholder="Escribe el nombre del producto..." 
                    class="search-input"
                    value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>"
                >
                <button type="submit" class="search-button">Buscar</button>
            </form>
        </header>

        <br><br><br><br><br><br>
        
        <%
    String query = request.getParameter("query");
    List<Map<String, Object>> productos = new ArrayList<>();

    // Conectar con la base de datos
    String dbURL = "jdbc:mysql://localhost:3306/petloop";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String sql;
        // Si el query está vacío, mostramos todos los productos
        if (query == null || query.trim().isEmpty()) {
            sql = "SELECT * FROM productos";  // Muestra todos los productos
        } else {
            sql = "SELECT * FROM productos WHERE nombre LIKE ?";  // Filtra por nombre
        }

        PreparedStatement ps = conn.prepareStatement(sql);

        if (query != null && !query.trim().isEmpty()) {
            ps.setString(1, "%" + query + "%");  // Establecemos el parámetro para la búsqueda
        }

        rs = ps.executeQuery();

        // Obtener los resultados de la consulta
        while (rs.next()) {
            Map<String, Object> producto = new HashMap<>();
            producto.put("id", rs.getInt("id"));
            producto.put("nombre", rs.getString("nombre"));
            producto.put("imagen_default", rs.getString("imagen_default"));
            producto.put("imagen_hover", rs.getString("imagen_hover"));
            producto.put("precio", rs.getDouble("precio"));
            producto.put("descripcion", rs.getString("descripcion"));
            producto.put("rating", rs.getInt("rating"));
            producto.put("stock", rs.getInt("stock"));
            producto.put("tipo", rs.getString("tipo"));

            productos.add(producto);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


        <!-- Muestra los productos encontrados -->
        <section class="section product" id="shop" aria-label="product">
            <div class="container">
                <ul class="grid-list">
                    <% for (Map<String, Object> producto : productos) { %>
                        <li>
                            <div class="product-card" data-id="<%= producto.get("id") %>">
                                <div class="card-banner img-holder" style="--width: 360; --height: 360;">
                                    <img src="<%= producto.get("imagen_default") %>" width="360" height="360" loading="lazy" alt="" class="img-cover default">
                                    <img src="<%= producto.get("imagen_hover") %>" width="360" height="360" loading="lazy" alt="" class="img-cover hover">
                                    <% 
                                        String tipo = (String) producto.get("tipo");
                                        if ("prenda".equals(tipo)) {
                                    %>
                                    <button class="card-action-btn show-modal-btn" aria-label="add to cart" title="Add To Cart">
                                        <ion-icon name="bag-add-outline" aria-hidden="true"></ion-icon>
                                    </button>
                                    <% } else if ("objeto".equals(tipo)) { %>
                                    <button class="card-action-btn" aria-label="add to cart" title="Add To Cart">
                                        <ion-icon name="bag-add-outline" aria-hidden="true"></ion-icon>
                                    </button>
                                    <% } %>
                                </div>
                                <div class="card-content">
                                    <div class="wrapper">
                                        <div class="rating-wrapper">
                                            <ion-icon name="star" aria-hidden="true"></ion-icon>
                                            <ion-icon name="star" aria-hidden="true"></ion-icon>
                                            <ion-icon name="star" aria-hidden="true"></ion-icon>
                                            <ion-icon name="star" aria-hidden="true"></ion-icon>
                                            <ion-icon name="star" aria-hidden="true"></ion-icon>
                                        </div>
                                        <span class="span">(<%= producto.get("rating") %>)</span>
                                    </div>
                                    <h3 class="h3">
                                        <a href="#" class="card-title"><%= producto.get("nombre") %></a>
                                    </h3>
                                    <data class="card-price" value="<%= producto.get("precio") %>">S/.<%= producto.get("precio") %></data>
                                    <p class="card-description"><%= producto.get("descripcion") %></p>
                                </div>
                            </div>
                        </li>
                    <% } %>
                </ul>
            </div>
        </section>

        <!-- 
        - #FOOTER
    -->

    <footer class="footer">

        <div class="footer-top section">
            <div class="container">

                <div class="footer-brand">

                    <a href="#" class="logo">PetLoop</a>

                    <p class="footer-text">
                        Contáctanos: <a href="mailto:petloop@gmail.com" class="link">petloop@gmail.com</a>
                    </p>

                    <ul class="contact-list">
                        <li class="contact-item">
                        <ion-icon name="location-outline" aria-hidden="true"></ion-icon>
                        <address class="address">Lima, San Isidro H-20</address>
                        </li>
                        <li class="contact-item">
                        <ion-icon name="call-outline" aria-hidden="true"></ion-icon>
                        <a href="tel:956956265" class="contact-link">956-956-265</a>
                        </li>
                    </ul>

                    <ul class="social-list">
                        <li><a href="#" class="social-link"><ion-icon name="logo-facebook"></ion-icon></a></li>
                        <li><a href="#" class="social-link"><ion-icon name="logo-twitter"></ion-icon></a></li>
                        <li><a href="#" class="social-link"><ion-icon name="logo-instagram"></ion-icon></a></li>
                    </ul>

                </div>

                <div class="footer-sections">
                    <ul class="footer-list">
                        <li><p class="footer-list-title">Información</p></li>
                        <li><a href="index.jsp#MisionyVision" class="footer-link">Sobre Nosotros</a></li>
                        <li><a href="#" class="footer-link">Términos de Servicio</a></li>
                        <li><a href="#" class="footer-link">Política de Privacidad</a></li>
                        <li><a href="reclamaciones.jsp" class="footer-link">Libro de Reclamaciones</a></li>
                    </ul>

                    <ul class="footer-list">
                        <li><p class="footer-list-title">Servicios</p></li>
                        <li><a href="#" class="footer-link">Adopción de Mascotas</a></li>
                        <li><a href="#" class="footer-link">Entrenamiento Canino</a></li>
                    </ul>
                </div>

            </div>
        </div>

        <div class="footer-bottom">
            <div class="container">
                <p class="copyright">&copy; 2024 PetLoop. Todos los derechos reservados.</p>
            </div>
        </div>

    </footer>



    <!-- 
      - custom js link
    -->
    <script src="js/script.js" defer></script>

    <!-- 
      - ionicon link
    -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <a href="https://api.whatsapp.com/send?phone=986363462&text=Hola,%20sean%20bienvenidos!%20:)" class="float" target="_blank">
        <i class="fa fa-whatsapp my-float"></i>
    </a>

    <script src="js/Carrito.js?v=1.0"></script>
    <script src="js/busqueda.js?v=1.0"></script>
    

    </body>
</html>
