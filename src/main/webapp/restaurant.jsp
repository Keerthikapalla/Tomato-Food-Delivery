
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.User" %>

<%
    Cart sessionCart = (Cart) session.getAttribute("cart");
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    boolean isLoggedIn = loggedInUser != null;

    int cartCount = 0;

    if (sessionCart != null && sessionCart.getItems() != null) {
        for (CartItem item : sessionCart.getItems().values()) {
            if (item != null) {
                cartCount += item.getQuantity();
            }
        }
    }

    List<Restaurant> restaurants =
        (List<Restaurant>) request.getAttribute("restaurants");

    boolean hasActiveRestaurants = false;
    if (restaurants != null) {
        for (Restaurant r : restaurants) {
            if (r.isActive()) {
                hasActiveRestaurants = true;
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TOMATO | Restaurants</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/restaurant.css">
</head>

<body data-context-path="${pageContext.request.contextPath}">

<!-- ================= NAVBAR ================= -->
 			
 			
 			 <%@ include file="navbar.jsp" %>


<!-- ================= HERO ================= -->

<section class="hero">
    <div class="hero-left">

        <div class="small-label">🍅 EXPLORE TOMATO</div>

        <h1>
            What are you
            <span>craving today?</span>
        </h1>

        

        <!-- Search remains in the hero, not the navbar -->
        <div class="hero-search">
            <span class="search-icon" aria-hidden="true">⌕</span>

            <input
                type="search"
                id="searchInput"
                placeholder="Search restaurants, cuisines or locations..."
                autocomplete="off"
                aria-label="Search restaurants, cuisines or locations">

            <button
                type="button"
                id="clearSearch"
                class="clear-search"
                aria-label="Clear search"
                hidden>&times;</button>
        </div>

        <!-- <div class="hero-tags" aria-label="Popular food categories">
            <span>🍕 Pizza</span>
            <span>🍛 Biryani</span>
            <span>🍔 Burgers</span>
            <span>🥘 South Indian</span>
            <span>🍰 Desserts</span>
        </div> -->

    </div>
</section>


<!-- ================= RESTAURANTS ================= -->

<section class="restaurants-section" id="restaurantsSection">

    <div class="section-heading">
        <div>
            <span class="section-small">🍅 EXPLORE NEAR YOU</span>

            <h2>Restaurants you'll <span>love</span></h2>

            <p id="restaurantSubtitle">
                Discover the best restaurants in Bengaluru
            </p>
        </div>
    </div>


    <!-- ================= CUISINE FILTERS ================= -->

    <div class="filters" aria-label="Filter restaurants by cuisine">

        <button type="button" class="filter active" data-filter="all">
            All
        </button>

        <button type="button" class="filter" data-filter="South Indian">
            🥘 South Indian
        </button>

        <button type="button" class="filter" data-filter="North Indian">
            🍛 North Indian
        </button>

        <button type="button" class="filter" data-filter="Pizza">
            🍕 Italian
        </button>

        <button type="button" class="filter" data-filter="Burgers">
            🍔 Burgers
        </button>

        <button type="button" class="filter" data-filter="Chinese">
            🍜 Chinese
        </button>

        <button type="button" class="filter" data-filter="Desserts">
            🍰 Desserts
        </button>

    </div>


    <!-- ================= DATABASE-DRIVEN RESTAURANTS ================= -->

    <div class="restaurant-grid" id="restaurantGrid">

        <% if (hasActiveRestaurants) { %>

            <% for (Restaurant restaurant : restaurants) {
                if (restaurant.isActive()) {
            %>

            <article class="restaurant-card"
                     data-id="<%= restaurant.getRestaurantId() %>"
                     data-name="<%= restaurant.getName() %>"
                     data-cuisine="<%= restaurant.getCuisineType() %>"
                     data-address="<%= restaurant.getAddress() %>">

                <div class="restaurant-image">
                    <img
                        src="<%= restaurant.getImagePath() %>"
                        alt="<%= restaurant.getName() %>"
                        loading="lazy"
                        onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=90';">

                    <div class="rating">
                        ★ <%= restaurant.getRating() %>
                    </div>
                </div>


                <div class="restaurant-info">

                    <div class="restaurant-title-row">
                        <h3><%= restaurant.getName() %></h3>

                        <button
                            type="button"
                            class="tomato-menu-btn"
                            onclick="viewMenu(<%= restaurant.getRestaurantId() %>)"
                            aria-label="View menu for <%= restaurant.getName() %>">

                            <svg class="tomato-menu-svg"
                                 viewBox="0 0 120 100"
                                 xmlns="http://www.w3.org/2000/svg">

                                <defs>
                                    <linearGradient
                                        id="tomatoGradient<%= restaurant.getRestaurantId() %>"
                                        x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="0%" stop-color="#ff5555"/>
                                        <stop offset="100%" stop-color="#d92727"/>
                                    </linearGradient>
                                </defs>

                                <path
                                    d="M60 25 C54 15 43 15 35 20
                                       C43 24 49 29 55 34
                                       C55 27 57 25 60 25
                                       C66 15 77 15 85 20
                                       C77 24 71 29 65 34
                                       C65 27 63 25 60 25Z"
                                    fill="#3f8f2f"/>

                                <path
                                    d="M60 28 C38 26 19 39 18 59
                                       C17 80 35 92 60 92
                                       C85 92 103 80 102 59
                                       C101 39 82 26 60 28Z"
                                    fill="url(#tomatoGradient<%= restaurant.getRestaurantId() %>)"
                                    stroke="#c91f1f"
                                    stroke-width="2"/>

                                <ellipse cx="39" cy="50" rx="8" ry="13"
                                         fill="rgba(255,255,255,0.28)"
                                         transform="rotate(25 39 50)"/>

                                <text x="60" y="58"
                                      text-anchor="middle"
                                      fill="white"
                                      font-family="Poppins, sans-serif"
                                      font-size="13"
                                      font-weight="700">View</text>

                                <text x="60" y="73"
                                      text-anchor="middle"
                                      fill="white"
                                      font-family="Poppins, sans-serif"
                                      font-size="13"
                                      font-weight="700">Menu</text>
                            </svg>
                        </button>
                    </div>

                    <div class="cuisine">
                        <%= restaurant.getCuisineType() %>
                    </div>

                    <div class="restaurant-details">
                        <span>📍 <%= restaurant.getAddress() %></span>
                        <span>🕒 <%= restaurant.getDeliveryTime() %></span>
                    </div>

                </div>
            </article>

            <% } } %>

        <% } else { %>

            <div class="empty-message" id="emptyRestaurants">
                <div>🍅</div>
                <h3>No restaurants available</h3>
                <p>Please check again later.</p>
            </div>

        <% } %>

    </div>


    <!-- ================= SEARCH/FILTER NO RESULTS ================= -->

    <div class="no-results" id="noResults" hidden>
        <div>🍅</div>
        <h3>Tomato couldn't find that restaurant</h3>
        <p>Try another restaurant, cuisine, or location.</p>
        <button type="button" id="resetFilters" class="reset-filters">
            Show all restaurants
        </button>
    </div>

</section>


<!-- ================= TOMATO ROPE ================= -->


<!-- ================= ANIMATED TOMATO ROPE ================= -->
<div class="tomato-rope-track" id="tomatoRopeTrack">

    <div class="hanging-rope"></div>

    <div class="rope-tomato" id="ropeTomato"
         aria-label="Tomato mascot climbing the rope">

        <div class="tomato-character">

            

            <span class="tomato-body">🍅</span>

            <span class="tomato-eye tomato-eye-left"></span>
            <span class="tomato-eye tomato-eye-right"></span>
            <span class="tomato-smile"></span>

           

            <span class="tomato-leg tomato-leg-left"></span>
            <span class="tomato-leg tomato-leg-right"></span>

            <span class="tomato-shoe tomato-shoe-left"></span>
            <span class="tomato-shoe tomato-shoe-right"></span>

        </div>

        <div class="rope-tomato-message" id="tomatoMessage">
            Let's explore! 🍅
        </div>

    </div>

</div>
<!-- ================= END TOMATO ROPE ================= -->



<!-- ================= BOTTOM MESSAGE ================= -->

<section class="bottom-message">
    <div class="bottom-tomato">🍅</div>
    <h2>Your next delicious meal is waiting for you.</h2>
    <p>Pick a restaurant and let TOMATO do the rest.</p>
</section>


<!-- ================= FOOTER ================= -->

<footer>
    <div class="footer-logo">🍅 TOMATO</div>
    <p>Made with ❤️ for food lovers.</p>

    <div class="footer-links">
        <a href="#">About</a>
        <a href="#">Help</a>
        <a href="#">Privacy</a>
        <a href="#">Terms</a>
    </div>
</footer>

<script src="${pageContext.request.contextPath}/restaurant.js"></script>

</body>
</html>
