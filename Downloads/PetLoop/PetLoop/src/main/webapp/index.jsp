<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/style.css?v=1.0">
        <link rel="stylesheet" href="css/Size.css?v=1.0">
        <!-- Importar Ionicons -->
        <link rel="stylesheet" href="https://unpkg.com/ionicons@5.5.2/dist/ionicons.min.css">
        <link rel="stylesheet" href="css/CarritoStyle.css?v=1.0"> 
        <link rel='stylesheet' href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
        <title>PetLoop - Tu tienda de mascotas</title>
        <meta name="title" content="PetLoop">
        <link rel="icon" href="img/logo.png" type="icon">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Bangers&family=Carter+One&family=Nunito+Sans:wght@400;700&display=swap"
            rel="stylesheet">

        <!-- 
          - preload images
        -->
        <link rel="preload" as="image" href="img/hero-name.png">
    </head>

    <body>
        <!-- 
          - header
        -->
        <header class="header" data-header>
            <div class="container">

                <button class="nav-toggle-btn" aria-label="toggle manu" data-nav-toggler>
                    <ion-icon name="menu-outline" aria-hidden="true" class="menu-icon"></ion-icon>
                    <ion-icon name="close-outline" aria-label="true" class="close-icon"></ion-icon>
                </button>

                <a href="#" class="logo">PetLoop</a>

                <nav class="navbar" data-navbar>
                    <ul class="navbar-list">

                        <li class="navbar-item">
                            <a href="#home" class="navbar-link" data-nav-link>Inicio</a>
                        </li>

                        <li class="navbar-item">
                            <a href="#MisionyVision" class="navbar-link" data-nav-link>Nosotros</a>
                        </li>
                        
                        <li class="navbar-item">
                            <a href="blogs.jsp" class="navbar-link" data-nav-link>Blogs</a>
                        </li>

                        <li class="navbar-item">
                            <a href="busqueda.jsp" class="navbar-link" data-nav-link>Catálogo</a>
                        </li>

                        <li class="navbar-item">
                            <a href="citas.jsp" class="navbar-link" data-nav-link>Citas</a>
                        </li>

                        <li class="navbar-item">
                            <a href="contactanos.jsp" class="navbar-link" data-nav-link>Contáctanos</a>
                        </li>

                    </ul>

                    <a href="login.jsp" class="navbar-action-btn">Iniciar Sesión</a>
                </nav>

                <div class="header-actions">


                    <form action="busqueda.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="query" value="">
                        <button class="search-btn" type="submit" aria-label="Search" title="Search">
                            <ion-icon name="search-outline" aria-hidden="true"></ion-icon>
                        </button>
                    </form>


                    <button class="action-btn user" aria-label="User">
                        <ion-icon name="person-outline" aria-hidden="true"></ion-icon>
                    </button>

                    <button class="action-btn" aria-label="cart" onclick="toggleCart()">
                        <ion-icon name="bag-handle-outline" aria-hidden="true"></ion-icon>
                        <span class="btn-badge">0</span>
                    </button>



                </div>

            </div>
        </header>
        <article>

            <!-- 
              - #HERO
            -->

            <section class="section hero has-bg-image" id="home" aria-label="home"
                     style="background-image: url('img/hero-name.png')">
                <div class="container">

                    <h1 class="h1 hero-title">
                        <span class="span">Lo que tu mascota necesita</span> en un solo lugar
                    </h1>

                    <a href="#shop" class="btn">Comprar</a>

                </div>
            </section>

            <!-- 
             - #MISION Y VISION
            -->

            <section id="MisionyVision">
                <div>
                    <img src="img/mision.jpg" alt="">
                    <h4>Misión</h4>
                    <p>En PetLoop, nuestra misión es ofrecer a las mascotas productos innovadores y de alta calidad, 
                        como ropa, juguetes y accesorios, que promuevan su bienestar, comodidad y felicidad. 
                        Nos comprometemos a crear una experiencia de compra única, brindando atención personalizada 
                        a los dueños de mascotas, y fomentando un vínculo fuerte y saludable entre ellos y sus fieles 
                        compañeros.


                    </p>
                </div>

                <div>
                    <img src="img/vision.jpg" alt="">
                    <h4>Visión</h4>
                    <p>Ser la tienda líder en el mercado de productos para mascotas a nivel nacional, reconocida por 
                        nuestra dedicación al cuidado integral de las mascotas a través de productos funcionales y 
                        modernos. En PetLoop, aspiramos a ser la marca de referencia en el bienestar y estilo de vida 
                        de las mascotas, siempre promoviendo el amor y el respeto por los animales.
                    </p>
                </div>
            </section>

            <!-- 
             - #CTA
            -->
            <section class="cta has-bg-image" aria-label="cta" style="background-image: url('img/cta-bg.jpg')">
                <div class="container">

                    <figure class="cta-banner">
                        <img src="img/pet.png" width="500" height="650" loading="lazy" alt="perrito" class="w-100">
                    </figure>

                    <div class="cta-content">

                        <h2 class="h2 section-title">Sobre Nosotros</h2>

                        <p class="section-text">
                            En Pet Shop, nos dedicamos a ofrecerte productos excepcionales para el cuidado de tus mascotas,
                            ayudándote a mejorar su calidad de vida y a resaltar su bienestar. Nos enorgullece ofrecer una
                            selección cuidadosamente seleccionada de productos de alta calidad diseñados para satisfacer
                            las necesidades de tus mascotas y proporcionar resultados visibles y duraderos. Nuestra pasión
                            por las mascotas va más allá de simplemente ofrecer productos.
                        </p>

                        <a href="#shop" class="btn">Descubre más</a>

                    </div>

                </div>
            </section>

            <!-- 
              - #CATEGORY
            -->

            <section class="section category" aria-label="category">
                <div class="container">

                    <h2 class="h2 section-title">
                        <span class="span">Nuestras </span> Categorias
                    </h2>

                    <ul class="has-scrollbar">

                        <li class="scrollbar-item">
                            <div class="category-card">

                                <figure class="card-banner img-holder" style="--width: 330; --height: 300;">
                                    <img src="img/alimento.jpg" width="330" height="300" loading="lazy" alt="Cat Food"
                                         class="img-cover">
                                </figure>

                                <h3 class="h3">
                                    <a href="#" class="card-title">Alimentos</a>
                                </h3>

                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="category-card">

                                <figure class="card-banner img-holder" style="--width: 330; --height: 300;">
                                    <img src="img/juguete.jpg" width="330" height="300" loading="lazy" alt="Cat Toys"
                                         class="img-cover">
                                </figure>

                                <h3 class="h3">
                                    <a href="#" class="card-title">Juguetes</a>
                                </h3>

                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="category-card">

                                <figure class="card-banner img-holder" style="--width: 330; --height: 300;">
                                    <img src="img/accesorios.jpg" width="330" height="300" loading="lazy" alt="Dog Food"
                                         class="img-cover">
                                </figure>

                                <h3 class="h3">
                                    <a href="#" class="card-title">Accesorios</a>
                                </h3>

                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="category-card">

                                <figure class="card-banner img-holder" style="--width: 330; --height: 300;">
                                    <img src="img/ropa.jpg" width="330" height="300" loading="lazy" alt="Dog Toys"
                                         class="img-cover">
                                </figure>

                                <h3 class="h3">
                                    <a href="#" class="card-title">Ropas</a>
                                </h3>

                            </div>
                        </li>


                    </ul>

                </div>
            </section>


            <!-- 
            #BLOG
            -->

            <section class="section blog" id="seccionblog" aria-label="blog">
                <div class="container">

                    <ul class="grid-list">

                        <li>
                            <div class="blog-card has-bg-image img-holder"
                                 style="background-image: url('img/blogperritos.jpg'); --width: 540; --height: 374;">

                                <p class="card-subtitle">Consejos de Entrenamiento</p>

                                <h3 class="h3 card-title">
                                    Cómo entrenar a tu <span class="span">perrito</span> en casa
                                </h3>

                                <a href="blogs.jsp#blog1" class="btn">Leer más</a>

                            </div>
                        </li>

                        <li>
                            <div class="blog-card has-bg-image img-holder"
                                 style="background-image: url('img/blogalimentacion.jpg'); --width: 540; --height: 374;">

                                <p class="card-subtitle">Nutrición Canina</p>

                                <h3 class="h3 card-title">
                                    Los mejores alimentos para <span class="span">tu mascota</span>
                                </h3>

                                <a href="blogs.jsp#blog2" class="btn">Leer más</a>

                            </div>
                        </li>

                        <li>
                            <div class="blog-card has-bg-image img-holder"
                                 style="background-image: url('img/blogrescate.jpg'); --width: 540; --height: 374;">

                                <p class="card-subtitle">Historias de Perros</p>

                                <h3 class="h3 card-title">
                                    Historias inspiradoras de <span class="span">rescate</span>
                                </h3>

                                <a href="blogs.jsp#blog3" class="btn">Leer más</a>

                            </div>
                        </li>

                    </ul>

                </div>
            </section>



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

            <%@ page import="java.sql.*" %>
            <%@ page import="java.util.*" %>
            <%
                // Establecer los parámetros de conexión a la base de datos
                String dbURL = "jdbc:mysql://localhost:3306/petloop"; // Cambia esta URL a la de tu base de datos
                String dbUser = "root"; // Tu usuario de la base de datos
                String dbPassword = ""; // Tu contraseña de la base de datos

                // Establecer conexión
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    List<Map<String, Object>> productos = new ArrayList<>();

    try {
        // Cargar el controlador de MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Conectar a la base de datos
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Crear la consulta SQL
        String sql = "SELECT * FROM productos";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        // Recorrer los resultados y almacenarlos en la lista
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
            producto.put("tipo", rs.getString("tipo")); // Aquí añadimos el tipo

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

            <section class="section product" id="shop" aria-label="product">
                <div class="container">
                    <h2 class="h2 section-title">
                        <span class="span">Elementos </span> Destacados
                    </h2>
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
                                        <p class="card-title"><%= producto.get("nombre") %></p>
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
              - #SERVICE
            -->

            <section class="section service" aria-label="service">
                <div class="container">

                    <img src="img/service-image.png" width="122" height="136" loading="lazy" alt="" class="img">

                    <h2 class="h2 section-title">
                        <span class="span">Lo que tu mascota necesita, </span> cuando lo necesitan.
                    </h2>

                    <ul class="grid-list">

                        <li>
                            <div class="service-card">

                                <figure class="card-icon">
                                    <img src="img/entrega.png" width="70" height="70" loading="lazy"
                                         alt="service icon">
                                </figure>

                                <h3 class="h3 card-title">Entregas</h3>

                                <p class="card-text">
                                    En PetLoop, nos aseguramos de que los productos para tus mascotas lleguen a tu puerta de manera rápida y segura.
                                </p>

                            </div>
                        </li>

                        <li>
                            <div class="service-card">

                                <figure class="card-icon">
                                    <img src="img/venta.png" width="70" height="70" loading="lazy"
                                         alt="service icon">
                                </figure>

                                <h3 class="h3 card-title">Ventas</h3>

                                <p class="card-text">
                                    PetLoop se especializa en la venta de una amplia gama de productos para mascotas, desde ropa y 
                                    juguetes hasta accesorios de alta calidad.
                                </p>

                            </div>
                        </li>

                        <li>
                            <div class="service-card">

                                <figure class="card-icon">
                                    <img src="img/alianza.png" width="70" height="70" loading="lazy"
                                         alt="service icon">
                                </figure>

                                <h3 class="h3 card-title">Alianzas</h3>

                                <p class="card-text">
                                    En PetLoop, creemos en el poder de las alianzas estratégicas para ofrecer mejores productos 
                                    y servicios a nuestras mascotas y clientes. 
                                </p>

                            </div>
                        </li> 
                    </ul>
                </div>
            </section>

            <!-- 
          - #PHOTO GALLERY
            -->
            <section id="gallery-section" class="section gallery" aria-label="photo gallery">
                <div class="container">

                    <h2 class="h2 section-title">
                        <span class="span">Vida de tus amigos </span> en imágenes
                    </h2>

                    <ul class="gallery-grid">
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo1.png" alt="gallery image 1" class="img">
                                <figcaption>Disfrutando la vida perruna</figcaption> 
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo2.png" alt="gallery image 2" class="img">
                                <figcaption>Perrito en spa</figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo3.png" alt="gallery image 3" class="img">
                                <figcaption>Gatito feliz</figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo4.png" alt="gallery image 4" class="img">
                                <figcaption>Amigos por siempre</figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo5.png" alt="gallery image 5" class="img">
                                <figcaption>Disfrutando el día</figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/photo6.png" alt="gallery image 6" class="img">
                                <figcaption>Momentos felices</figcaption>
                            </figure>
                        </li>
                        <li>
                            <figure class="gallery-item">
                                <img src="img/lester.png" alt="gallery image 7" class="img">
                                <figcaption>Lester en el parque</figcaption>
                            </figure>
                        </li>
                    </ul>

                </div>
            </section>




            <!-- 
              - #BRAND
            -->

            <section class="section brand" aria-label="brand">
                <div class="container">

                    <h2 class="h2 section-title">
                        <span class="span">Marcas</span> Populares
                    </h2>

                    <ul class="has-scrollbar">

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca1.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca2.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca3.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca4.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca5.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca6.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                        <li class="scrollbar-item">
                            <div class="brand-card img-holder" style="--width: 150; --height: 150;">
                                <img src="img/marca7.png" width="150" height="150" loading="lazy" alt="brand logo"
                                     class="img-cover">
                            </div>
                        </li>

                    </ul>

                </div>
            </section>



        </article>
    </main>


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
                        <li><a href="https://www.instagram.com/lesterciwis/" class="social-link"><ion-icon name="logo-instagram"></ion-icon></a></li>
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
