<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Cart"%>
<%@ page import="com.tap.model.CartItem"%>

<%
    Cart sessionCart = null;

    if (session != null) {
        sessionCart = (Cart) session.getAttribute("cart");
    }

    int cartCount = 0;

    if (sessionCart != null && sessionCart.getItems() != null) {

        for (CartItem cartItem : sessionCart.getItems().values()) {

            if (cartItem != null) {
                cartCount += cartItem.getQuantity();
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>TOMATO | Menu</title>


    <!-- GOOGLE FONT -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">


    <!-- MENU CSS -->

    <link rel="stylesheet" href="menu.css">
    
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/menutheme.css?v=1">

</head>


<body>


    <!-- =========================================================
         TOMATO OPENING TRANSITION
    ========================================================== -->

    <div class="tomato-transition"
         id="tomatoTransition">

        <div class="transition-whole-tomato"
             id="transitionWholeTomato">

            <div class="transition-leaf leaf-one"></div>
            <div class="transition-leaf leaf-two"></div>
            <div class="transition-leaf leaf-three"></div>

            <div class="transition-tomato-body"></div>

            <div class="transition-highlight"></div>

        </div>


        <div class="tomato-half tomato-left-half">

            <div class="half-leaf"></div>
            <div class="half-body"></div>

            <div class="half-seed seed-one"></div>
            <div class="half-seed seed-two"></div>
            <div class="half-seed seed-three"></div>

        </div>


        <div class="tomato-half tomato-right-half">

            <div class="half-leaf"></div>
            <div class="half-body"></div>

            <div class="half-seed seed-one"></div>
            <div class="half-seed seed-two"></div>
            <div class="half-seed seed-three"></div>

        </div>


        <div class="juice-splash">

            <span class="juice-stream stream-one"></span>
            <span class="juice-stream stream-two"></span>
            <span class="juice-stream stream-three"></span>
            <span class="juice-stream stream-four"></span>

            <span class="juice-drop drop-one"></span>
            <span class="juice-drop drop-two"></span>
            <span class="juice-drop drop-three"></span>
            <span class="juice-drop drop-four"></span>
            <span class="juice-drop drop-five"></span>
            <span class="juice-drop drop-six"></span>
            <span class="juice-drop drop-seven"></span>
            <span class="juice-drop drop-eight"></span>
            <span class="juice-drop drop-nine"></span>
            <span class="juice-drop drop-ten"></span>
            <span class="juice-drop drop-eleven"></span>
            <span class="juice-drop drop-twelve"></span>

            <span class="splash-wave wave-one"></span>
            <span class="splash-wave wave-two"></span>
            <span class="splash-wave wave-three"></span>

        </div>


        <div class="transition-text">

            <strong>Freshly opened!</strong>

            <span>
                Let's explore your delicious menu 🍅
            </span>

        </div>

    </div>



    <!-- =========================================================
         NAVBAR
    ========================================================== -->

     <%@ include file="navbar.jsp" %>

    <!-- =========================================================
         MENU SECTION
    ========================================================== -->

    <section class="menu-container"
             id="menuSection">


        <!-- FLOATING FOOD DECORATIONS -->

        <div class="floating-foods"
             aria-hidden="true">

            <div class="floating-food food-one">🍦</div>
            <div class="floating-food food-two">🥤</div>
            <div class="floating-food food-three">🍔</div>
            <div class="floating-food food-four">🍕</div>
            <div class="floating-food food-five">🍩</div>
            <div class="floating-food food-six">🧁</div>
            <div class="floating-food food-seven">🍟</div>
            <div class="floating-food food-eight">🥗</div>
            <div class="floating-food food-nine">🍰</div>
            <div class="floating-food food-ten">🥪</div>

        </div>



        <!-- SECTION HEADING -->

        <div class="menu-heading">

            <span class="section-small">
                🍅 OUR DELICIOUS COLLECTION
            </span>

            <h2>
                Open the <span>Menu</span>
            </h2>

            <p>
                Scroll inside the book and discover your next favourite dish.
            </p>

        </div>



        <!-- =====================================================
             BOOK AREA
        ====================================================== -->

        <div class="book-stage">


            <!-- =================================================
                 SIDE CLIMBING ROPE
            ================================================== -->

            <aside class="tomato-climber"
                   id="tomatoClimber">


                <div class="rope-top-anchor">

                    <span></span>
                    <i></i>

                </div>


                <div class="rope-track"
                     id="ropeTrack">


                    <svg class="rope-svg"
                         viewBox="0 0 90 900"
                         preserveAspectRatio="none"
                         aria-hidden="true">


                        <defs>

                            <linearGradient
                                id="ropeGradient"
                                x1="0%"
                                y1="0%"
                                x2="100%"
                                y2="0%">

                                <stop offset="0%"
                                      stop-color="#8b4f25" />

                                <stop offset="30%"
                                      stop-color="#d39458" />

                                <stop offset="50%"
                                      stop-color="#f0c07c" />

                                <stop offset="70%"
                                      stop-color="#b86d35" />

                                <stop offset="100%"
                                      stop-color="#6d3b1d" />

                            </linearGradient>

                        </defs>


                        <path
                            class="rope-shadow-path"
                            d="M46 0
                               C15 100, 75 190, 40 290
                               C10 380, 78 470, 45 570
                               C18 660, 73 750, 42 900">
                        </path>


                        <path
                            class="rope-main-path"
                            d="M43 0
                               C12 100, 72 190, 37 290
                               C7 380, 75 470, 42 570
                               C15 660, 70 750, 39 900">
                        </path>

                    </svg>

                </div>


                <div class="rope-bottom-anchor">

                    <span class="knot-main"></span>
                    <span class="knot-left"></span>
                    <span class="knot-right"></span>

                </div>



                <!-- CLIMBING TOMATO -->

                <div class="climbing-tomato"
                     id="climbingTomato">


                    <div class="tomato-arm left-arm">

                        <div class="tomato-hand left-hand">

                            <span></span>
                            <span></span>
                            <span></span>

                        </div>

                    </div>


                    <div class="tomato-arm right-arm">

                        <div class="tomato-hand right-hand">

                            <span></span>
                            <span></span>
                            <span></span>

                        </div>

                    </div>


                    <div class="climber-body">

                        <div class="climber-highlight"></div>

                        <div class="climber-seed seed-a"></div>
                        <div class="climber-seed seed-b"></div>
                        <div class="climber-seed seed-c"></div>


                        <div class="climber-face">

                            <span class="eye eye-left"></span>
                            <span class="eye eye-right"></span>

                            <span class="cheek cheek-left"></span>
                            <span class="cheek cheek-right"></span>

                            <span class="climber-smile"></span>

                        </div>


                        <div class="climber-leaf leaf-a"></div>
                        <div class="climber-leaf leaf-b"></div>
                        <div class="climber-leaf leaf-c"></div>

                    </div>


                    <div class="tomato-leg left-leg">

                        <div class="tomato-foot">
                            <span></span>
                        </div>

                    </div>


                    <div class="tomato-leg right-leg">

                        <div class="tomato-foot">
                            <span></span>
                        </div>

                    </div>


                    <div class="climber-message"
                         id="tomatoMessage">

                        Keep going! 🍅

                    </div>

                </div>

            </aside>



            <!-- =================================================
                 OPEN BOOK
            ================================================== -->

            <div class="book-wrapper">


                <div class="book-cover">

                    <div class="book-title-decoration">

                        <span>🍅</span>
                        <span>🍅</span>

                    </div>


                    <div class="book-cover-title">
                        YOUR MENU
                    </div>


                    <div class="book-cover-subtitle">
                        Delicious discoveries
                    </div>

                </div>



                <!-- ONLY THIS AREA SCROLLS -->

                <div class="book-scroll-area"
                     id="bookScrollArea">


                    <div class="open-book">


                        <div class="book-pages">


                            <%

                                List<Menu> menuList =
                                    (List<Menu>) request.getAttribute("allmenus");


                                if (menuList != null && !menuList.isEmpty()) {


                                    for (int index = 0;
                                         index < menuList.size();
                                         index++) {


                                        Menu menu =
                                            menuList.get(index);


                                        boolean imageLeft =
                                            index % 2 == 0;


                                        int menuQuantity = 0;


                                        if (sessionCart != null
                                            && sessionCart.getItems() != null
                                            && sessionCart.getItems()
                                                .containsKey(menu.getMenuId())) {


                                            CartItem currentItem =
                                                sessionCart.getItems()
                                                    .get(menu.getMenuId());


                                            if (currentItem != null) {

                                                menuQuantity =
                                                    currentItem.getQuantity();

                                            }

                                        }

                            %>


                            <!-- =================================================
                                 MENU SPREAD
                            ================================================== -->

                            <section
                                class="menu-spread <%= imageLeft ? "image-left" : "image-right" %>">


                                <!-- =================================================
                                     LEFT PAGE
                                ================================================== -->

                                <div class="book-page left-page">


                                    <%

                                        if (imageLeft) {

                                    %>


                                    <!-- IMAGE -->

                                    <div class="dish-image-page">

                                        <div class="dish-image-frame">

                                            <img
                                                src="<%= menu.getImagePath() %>"
                                                alt="<%= menu.getItemName() %>"
                                                class="dish-image"
                                                loading="lazy"
                                                onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1000&q=90';">

                                        </div>


                                        <div class="image-caption">
                                            Freshly prepared
                                        </div>

                                    </div>


                                    <%

                                        } else {

                                    %>


                                    <!-- INFO -->

                                    <div class="dish-info">


                                        <span class="dish-number">
                                            DISH <%= index + 1 %>
                                        </span>


                                        <h3>
                                            <%= menu.getItemName() %>
                                        </h3>


                                        <div class="dish-divider">

                                            <span></span>
                                            🍅
                                            <span></span>

                                        </div>


                                        <p class="dish-description">

                                            <%= menu.getDescription() != null
                                                ? menu.getDescription()
                                                : "A delicious dish prepared specially for you." %>

                                        </p>


                                        <div class="dish-meta">


                                            <div class="price">

                                                ₹<%= String.format("%.2f",
                                                    menu.getPrice()) %>

                                            </div>


                                            <div class="availability
                                                <%= menu.isAvailable()
                                                    ? "available"
                                                    : "not-available" %>">

                                                <span></span>

                                                <%= menu.isAvailable()
                                                    ? "Available"
                                                    : "Currently unavailable" %>

                                            </div>

                                        </div>



                                        <!-- =================================================
                                             BACKEND CART
                                        ================================================== -->

                                       <div
    class="cart-control-wrapper"
    data-menu-id="<%= menu.getMenuId() %>"
    data-restaurant-id="<%= menu.getRestaurantId() %>"
    data-cart-url="${pageContext.request.contextPath}/cart">


                                            <%

                                                if (menu.isAvailable()) {


                                                    if (menuQuantity > 0) {

                                            %>


                                            <div class="quantity-control">


                                                <!-- DECREASE -->

                                                <form
                                                    method="post"
                                                    action="${pageContext.request.contextPath}/cart"
                                                    class="quantity-form">


                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">


                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">


                                                    <!-- IMPORTANT:
                                                         KEEP USER ON MENU -->

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">


                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">


                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= menuQuantity - 1 %>">


                                                    <button
                                                        class="quantity-btn"
                                                        type="submit">

                                                        −

                                                    </button>

                                                </form>



                                                <!-- QUANTITY -->

                                                <span class="quantity-value">

                                                    <%= menuQuantity %>

                                                </span>



                                                <!-- INCREASE -->

                                                <form
                                                    method="post"
                                                    action="${pageContext.request.contextPath}/cart"
                                                    class="quantity-form">


                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">


                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">


                                                    <!-- IMPORTANT:
                                                         KEEP USER ON MENU -->

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">


                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">


                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= menuQuantity + 1 %>">


                                                    <button
                                                        class="quantity-btn"
                                                        type="submit">

                                                        +

                                                    </button>

                                                </form>

                                            </div>


                                            <%

                                                    } else {

                                            %>


                                            <!-- ADD TO CART -->

                                            <form
                                                method="post"
                                                action="${pageContext.request.contextPath}/cart"
                                                class="add-cart-form">


                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="add">


                                                <input
                                                    type="hidden"
                                                    name="menuId"
                                                    value="<%= menu.getMenuId() %>">


                                                <!-- IMPORTANT:
                                                     KEEP USER ON MENU -->

                                                <input
                                                    type="hidden"
                                                    name="source"
                                                    value="menu">


                                                <input
                                                    type="hidden"
                                                    name="restaurantId"
                                                    value="<%= menu.getRestaurantId() %>">


                                                <button
                                                    class="add-btn"
                                                    type="submit">

                                                    <span>+</span>
                                                    Add to Cart

                                                </button>

                                            </form>


                                            <%

                                                    }

                                                } else {

                                            %>


                                            <button
                                                class="add-btn disabled-btn"
                                                type="button"
                                                disabled>

                                                Unavailable

                                            </button>


                                            <%

                                                }

                                            %>

                                        </div>

                                    </div>


                                    <%

                                        }

                                    %>

                                </div>



                                <!-- BOOK SPINE -->

                                <div class="book-spine">

                                    <div class="spine-line"></div>

                                    <div class="spine-dot"></div>

                                </div>



                                <!-- =================================================
                                     RIGHT PAGE
                                ================================================== -->

                                <div class="book-page right-page">


                                    <%

                                        if (imageLeft) {

                                    %>


                                    <!-- INFO -->

                                    <div class="dish-info">


                                        <span class="dish-number">
                                            DISH <%= index + 1 %>
                                        </span>


                                        <h3>
                                            <%= menu.getItemName() %>
                                        </h3>


                                        <div class="dish-divider">

                                            <span></span>
                                            🍅
                                            <span></span>

                                        </div>


                                        <p class="dish-description">

                                            <%= menu.getDescription() != null
                                                ? menu.getDescription()
                                                : "A delicious dish prepared specially for you." %>

                                        </p>


                                        <div class="dish-meta">


                                            <div class="price">

                                                ₹<%= String.format("%.2f",
                                                    menu.getPrice()) %>

                                            </div>


                                            <div class="availability
                                                <%= menu.isAvailable()
                                                    ? "available"
                                                    : "not-available" %>">

                                                <span></span>

                                                <%= menu.isAvailable()
                                                    ? "Available"
                                                    : "Currently unavailable" %>

                                            </div>

                                        </div>



                                        <!-- =================================================
                                             BACKEND CART
                                        ================================================== -->

                              <div
    class="cart-control-wrapper"
    data-menu-id="<%= menu.getMenuId() %>"
    data-restaurant-id="<%= menu.getRestaurantId() %>"
    data-cart-url="${pageContext.request.contextPath}/cart">


                                            <%

                                                if (menu.isAvailable()) {


                                                    if (menuQuantity > 0) {

                                            %>


                                            <div class="quantity-control">


                                                <!-- DECREASE -->

                                                <form
                                                    method="post"
                                                    action="${pageContext.request.contextPath}/cart"
                                                    class="quantity-form">


                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">


                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">


                                                    <!-- IMPORTANT:
                                                         KEEP USER ON MENU -->

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">


                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">


                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= menuQuantity - 1 %>">


                                                    <button
                                                        class="quantity-btn"
                                                        type="submit">

                                                        −

                                                    </button>

                                                </form>



                                                <!-- QUANTITY -->

                                                <span class="quantity-value">

                                                    <%= menuQuantity %>

                                                </span>



                                                <!-- INCREASE -->

                                                <form
                                                    method="post"
                                                    action="${pageContext.request.contextPath}/cart"
                                                    class="quantity-form">


                                                    <input
                                                        type="hidden"
                                                        name="action"
                                                        value="update">


                                                    <input
                                                        type="hidden"
                                                        name="menuId"
                                                        value="<%= menu.getMenuId() %>">


                                                    <!-- IMPORTANT:
                                                         KEEP USER ON MENU -->

                                                    <input
                                                        type="hidden"
                                                        name="source"
                                                        value="menu">


                                                    <input
                                                        type="hidden"
                                                        name="restaurantId"
                                                        value="<%= menu.getRestaurantId() %>">


                                                    <input
                                                        type="hidden"
                                                        name="quantity"
                                                        value="<%= menuQuantity + 1 %>">


                                                    <button
                                                        class="quantity-btn"
                                                        type="submit">

                                                        +

                                                    </button>

                                                </form>

                                            </div>


                                            <%

                                                    } else {

                                            %>


                                            <!-- ADD TO CART -->

                                            <form
                                                method="post"
                                                action="${pageContext.request.contextPath}/cart"
                                                class="add-cart-form">


                                                <input
                                                    type="hidden"
                                                    name="action"
                                                    value="add">


                                                <input
                                                    type="hidden"
                                                    name="menuId"
                                                    value="<%= menu.getMenuId() %>">


                                                <!-- IMPORTANT:
                                                     KEEP USER ON MENU -->

                                                <input
                                                    type="hidden"
                                                    name="source"
                                                    value="menu">


                                                <input
                                                    type="hidden"
                                                    name="restaurantId"
                                                    value="<%= menu.getRestaurantId() %>">


                                                <button
                                                    class="add-btn"
                                                    type="submit">

                                                    <span>+</span>
                                                    Add to Cart

                                                </button>

                                            </form>


                                            <%

                                                    }

                                                } else {

                                            %>


                                            <button
                                                class="add-btn disabled-btn"
                                                type="button"
                                                disabled>

                                                Unavailable

                                            </button>


                                            <%

                                                }

                                            %>

                                        </div>

                                    </div>


                                    <%

                                        } else {

                                    %>


                                    <!-- IMAGE -->

                                    <div class="dish-image-page">

                                        <div class="dish-image-frame">

                                            <img
                                                src="<%= menu.getImagePath() %>"
                                                alt="<%= menu.getItemName() %>"
                                                class="dish-image"
                                                loading="lazy"
                                                onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=1000&q=90';">

                                        </div>


                                        <div class="image-caption">
                                            Freshly prepared
                                        </div>

                                    </div>


                                    <%

                                        }

                                    %>

                                </div>

                            </section>


                            <%

                                    }

                                } else {

                            %>


                            <!-- EMPTY MENU -->

                            <div class="empty-menu">

                                <div class="empty-tomato">
                                    🍅
                                </div>

                                <h3>
                                    No dishes available
                                </h3>

                                <p>
                                    This restaurant has not added any menu items yet.
                                </p>

                            </div>


                            <%

                                }

                            %>

                        </div>



                        <!-- BOOK BOTTOM -->

                        <div class="book-bottom">

                            <span></span>

                            <div>
                                🍅 Made fresh for food lovers 🍅
                            </div>

                            <span></span>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- =========================================================
         BOTTOM MESSAGE
    ========================================================== -->

    <section class="bottom-message">

        <div class="bottom-tomato">
            🍅
        </div>

        <h2>
            Your next delicious meal is waiting for you.
        </h2>

        <p>
            Pick your favourite dish and let TOMATO do the rest.
        </p>

    </section>



    <!-- =========================================================
         FOOTER
    ========================================================== -->

    <%@ include file="Footer.jsp" %> 


    <script src="${pageContext.request.contextPath}/menu.js?v=3" defer></script>

</body>

</html>