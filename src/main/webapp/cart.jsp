
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>

<%
    Cart cart = (Cart) request.getAttribute("cart");
    String cartError = null;

    if (session != null) {
        cartError = (String) session.getAttribute("cartError");
        session.removeAttribute("cartError");
    }

    double subtotal = 0;
    double deliveryFee = 40;
    double platformFee = 10;
    double taxes = 0;
    double grandTotal = 0;
    int cartCount = 0;

    if (cart != null && cart.getItems() != null
            && !cart.getItems().isEmpty()) {
        subtotal = cart.getTotalAmount();

        for (CartItem item : cart.getItems().values()) {
            if (item != null) {
                cartCount += item.getQuantity();
            }
        }

        taxes = subtotal * 0.05;
        grandTotal = subtotal + deliveryFee + platformFee + taxes;
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TOMATO | Cart</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="<%= contextPath %>/cart.css?v=4">

    <%-- Apply the saved guest theme early to reduce theme flash.
         navbar.jsp also applies the theme and remains the shared source. --%>
    <script>
        (function () {
            try {
                var savedTheme = localStorage.getItem("tomatoTheme");
                if (savedTheme === "dark" || savedTheme === "light") {
                    document.documentElement.dataset.theme = savedTheme;
                }
            } catch (e) {
                // Continue with the theme provided by the server/navbar.
            }
        })();
    </script>
</head>

<body data-context-path="<%= contextPath %>">

    <%@ include file="navbar.jsp" %>

    <main class="cart-page">

        <% if (cartError != null && !cartError.trim().isEmpty()) { %>
            <div class="cart-error" id="cartError" role="alert">
                <span aria-hidden="true">⚠️</span>
                <div>
                    <strong>Cart notice</strong>
                    <p><%= cartError %></p>
                </div>
                <button type="button" onclick="closeError()" aria-label="Close notice">×</button>
            </div>
        <% } %>

        <% if (cart != null && cart.getItems() != null
                && !cart.getItems().isEmpty()) { %>

            <section class="cart-layout">

                <div class="cart-items-section">
                    <div class="section-heading">
                        <div>
                            <span>YOUR SELECTION</span>
                            <h2>Delicious picks</h2>
                        </div>
                        <div class="item-count-badge">
                            <%= cartCount %> items
                        </div>
                    </div>

                    <div class="cart-items">
                        <% for (CartItem cartItem : cart.getItems().values()) {
                            if (cartItem == null || cartItem.getMenu() == null) {
                                continue;
                            }

                            int menuId = cartItem.getMenu().getMenuId();
                            int quantity = cartItem.getQuantity();
                            double itemPrice = cartItem.getMenu().getPrice();
                            double itemTotal = cartItem.getTotalAmount();

                            String imagePath = cartItem.getMenu().getImagePath();
                            String itemName = cartItem.getMenu().getItemName();
                            String description = cartItem.getMenu().getDescription();
                        %>

                            <article class="cart-item" data-menu-id="<%= menuId %>">
                                <div class="cart-item-image">
                                    <img
                                        src="<%= imagePath == null ? "" : imagePath %>"
                                        alt="<%= itemName == null ? "Food item" : itemName %>"
                                        onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=600&q=80';">
                                </div>

                                <div class="cart-item-details">
                                    <span class="item-label">TOMATO PICK</span>
                                    <h3><%= itemName == null ? "Food item" : itemName %></h3>
                                    <p><%= description == null || description.trim().isEmpty()
                                        ? "Freshly prepared and delicious." : description %></p>
                                    <strong class="item-price">
                                        ₹<%= String.format(java.util.Locale.ROOT, "%.2f", itemPrice) %>
                                    </strong>
                                </div>

                                <div class="cart-item-actions">
                                    <div class="quantity-control">
                                        <form method="post"
                                              action="<%= contextPath %>/cart"
                                              class="cart-update-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="menuId" value="<%= menuId %>">
                                            <input type="hidden" name="quantity" value="<%= quantity - 1 %>">
                                            <input type="hidden" name="source" value="cart">
                                            <button type="submit" class="quantity-btn"
                                                    aria-label="Decrease quantity">−</button>
                                        </form>

                                        <span class="quantity-value"><%= quantity %></span>

                                        <form method="post"
                                              action="<%= contextPath %>/cart"
                                              class="cart-update-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="menuId" value="<%= menuId %>">
                                            <input type="hidden" name="quantity" value="<%= quantity + 1 %>">
                                            <input type="hidden" name="source" value="cart">
                                            <button type="submit" class="quantity-btn"
                                                    aria-label="Increase quantity">+</button>
                                        </form>
                                    </div>

                                    <form method="post"
                                          action="<%= contextPath %>/cart"
                                          class="remove-form">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="menuId" value="<%= menuId %>">
                                        <input type="hidden" name="source" value="cart">
                                        <button type="submit" class="remove-btn">Remove</button>
                                    </form>
                                </div>

                                <div class="cart-item-total">
                                    <span>Total</span>
                                    ₹<%= String.format(java.util.Locale.ROOT, "%.2f", itemTotal) %>
                                </div>
                            </article>
                        <% } %>
                    </div>

                    <div class="cart-actions">
                        <form method="post"
                              action="<%= contextPath %>/cart"
                              class="clear-cart-form"
                              onsubmit="return confirmClearCart();">
                            <input type="hidden" name="action" value="clear">
                            <input type="hidden" name="source" value="cart">
                            <button type="submit" class="clear-cart-btn">🗑 Clear Cart</button>
                        </form>

                        <a href="<%= contextPath %>/menu?restaurantId=<%= cart.getRestaurantId() %>"
                           class="add-more-btn">
                            <span class="mini-tomato">🍅</span>
                            <span>Add More Items</span>
                        </a>
                    </div>
                </div>

                <aside class="cart-summary">
                    <div class="summary-card">
                        <div class="summary-top">
                            <span>🍅 ORDER SUMMARY</span>
                            <h2>Almost yours.</h2>
                        </div>

                        <div class="summary-basket">
                            <img
                                src="https://cdn-icons-png.flaticon.com/512/1170/1170678.png"
                                alt="Shopping cart"
                                class="cart-summary-image">
                            <div>
                                <strong><%= cartCount %> items</strong>
                                <span>Freshly selected for you</span>
                            </div>
                        </div>

                        <div class="summary-row">
                            <span>Subtotal</span>
                            <strong>₹<%= String.format(java.util.Locale.ROOT, "%.2f", subtotal) %></strong>
                        </div>
                        <div class="summary-row">
                            <span>Delivery Fee</span>
                            <strong>₹<%= String.format(java.util.Locale.ROOT, "%.2f", deliveryFee) %></strong>
                        </div>
                        <div class="summary-row">
                            <span>Platform Fee</span>
                            <strong>₹<%= String.format(java.util.Locale.ROOT, "%.2f", platformFee) %></strong>
                        </div>
                        <div class="summary-row">
                            <span>Taxes</span>
                            <strong>₹<%= String.format(java.util.Locale.ROOT, "%.2f", taxes) %></strong>
                        </div>

                        <div class="summary-divider"></div>

                        <div class="summary-total">
                            <span>Total</span>
                            <strong>₹<%= String.format(java.util.Locale.ROOT, "%.2f", grandTotal) %></strong>
                        </div>

							<a class="checkout-btn" 
							href="<%= contextPath %>/checkout" 
							style="text-decoration: none;">
    						<span>→</span>
    									Proceed to Checkout
												</a>


                        <button type="button"
                                class="continue-btn"
                                onclick="browseRestaurants()">
                            ← Continue
                        </button>

                        <div class="secure-message">🔒 Safe &amp; secure ordering</div>
                    </div>
                </aside>

            </section>

        <% } else { %>

            <section class="empty-cart">
                <div class="empty-visual">
                    <div class="empty-circle"></div>
                    <img
                        src="https://cdn-icons-png.flaticon.com/512/1170/1170678.png"
                        alt="Empty shopping cart"
                        class="cart-summary-image">
                </div>

                <span class="empty-label">🍅 TOMATO BASKET</span>
                <h2>Your basket is waiting.</h2>
                <p>
                    Nothing delicious has joined your cart yet.
                    Explore our restaurants and fill your basket.
                </p>

                <button type="button" class="browse-btn" onclick="browseRestaurants()">
                    Explore Restaurants <span>→</span>
                </button>
            </section>

        <% } %>
    </main>

    <section class="bottom-message">
        <div class="bottom-food" aria-hidden="true">🍕</div>
        <div>
            <span>ONE MORE BITE?</span>
            <h2>Good food is just a click away.</h2>
            <p>Pick your favourites and enjoy your Tomato meal.</p>
        </div>
        <div class="bottom-food" aria-hidden="true">🍔</div>
    </section>

    <%@ include file="Footer.jsp" %>

    
    <script src="<%= contextPath %>/cart.js?v=5" defer></script>
</body>
</html>
