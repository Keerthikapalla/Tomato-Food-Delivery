
<%@ page import="com.tap.model.Cart,com.tap.model.CartItem,com.tap.model.Menu,com.tap.model.User,java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    Cart cart = (Cart) session.getAttribute("cart");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/cart");
        return;
    }

    double subtotal = cart.getTotalAmount();
    double deliveryFee = 40.0;
    double platformFee = 10.0;
    double tax = subtotal * 0.05;
    double grandTotal = subtotal + deliveryFee + platformFee + tax;

    String username = user.getUsername() == null ? "" : user.getUsername();
    String phone = user.getPhone() == null ? "" : user.getPhone();
    String address = user.getAddress() == null ? "" : user.getAddress();

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>TOMATO | Checkout</title>

    <!-- Checkout stylesheet -->
    <link rel="stylesheet"
          href="<%= contextPath %>/checkout.css?v=5">

    <!-- Checkout JavaScript -->
    <script src="<%= contextPath %>/checkout.js?v=4" defer></script>
</head>

<body>

    <%@ include file="navbar.jsp" %>

    <!-- =====================================================
         TOMATO FLOATING FOOD EMOJI BACKGROUND

         These decorations float behind the checkout content.
         They do not block form fields or buttons.
    ====================================================== -->

    <div class="floating-food food-one" aria-hidden="true">🍅</div>
    <div class="floating-food food-two" aria-hidden="true">🍕</div>
    <div class="floating-food food-three" aria-hidden="true">🥑</div>
    <div class="floating-food food-four" aria-hidden="true">🍓</div>
    <div class="floating-food food-five" aria-hidden="true">🥗</div>
    <div class="floating-food food-six" aria-hidden="true">🍔</div>

    <!-- Additional floating food decorations -->
    <div class="floating-food food-seven" aria-hidden="true">🍟</div>
    <div class="floating-food food-eight" aria-hidden="true">🍩</div>
    <div class="floating-food food-nine" aria-hidden="true">🥤</div>
    <div class="floating-food food-ten" aria-hidden="true">🍜</div>

    <!-- =====================================================
         CHECKOUT MAIN CONTENT
    ====================================================== -->

    <main class="checkout-wrap">

        <div class="page-heading">

            <div>
                <p class="eyebrow">ALMOST THERE!</p>

                <h1>
                    Checkout <span>♡</span>
                </h1>
            </div>

            <p class="secure-note">
                🔒 Safe &amp; secure checkout
            </p>

        </div>

        <!-- Keep the existing checkout servlet action -->
        <form id="checkoutForm"
              action="<%= contextPath %>/checkout"
              method="post">

            <div class="checkout-grid">

                <!-- =================================================
                     LEFT COLUMN
                ================================================== -->

                <section class="left-column">

                    <!-- DELIVERY DETAILS -->

                    <div class="panel delivery-panel">

                        <div class="section-title">

                            <span class="title-icon">📍</span>

                            <div>
                                <h2>Delivery details</h2>
                                <p>Where should we bring your food?</p>
                            </div>

                        </div>

                        <div class="form-grid">

                            <label>
                                Full name

                                <input
                                    type="text"
                                    name="fullName"
                                    value="<%= username %>"
                                    autocomplete="name"
                                    required>
                            </label>

                            <label>
                                Phone number

                                <input
                                    type="tel"
                                    name="phone"
                                    value="<%= phone %>"
                                    pattern="[0-9]{10}"
                                    maxlength="10"
                                    inputmode="numeric"
                                    autocomplete="tel"
                                    required>
                            </label>

                            <label class="full-width">
                                Delivery address

                                <textarea
                                    name="address"
                                    rows="2"
                                    autocomplete="street-address"
                                    required><%= address %></textarea>
                            </label>

                            <label>
                                City

                                <input
                                    type="text"
                                    name="city"
                                    placeholder="Your city"
                                    autocomplete="address-level2"
                                    required>
                            </label>

                            <label>
                                PIN code

                                <input
                                    type="text"
                                    name="pincode"
                                    pattern="[0-9]{6}"
                                    maxlength="6"
                                    inputmode="numeric"
                                    autocomplete="postal-code"
                                    placeholder="6-digit PIN"
                                    required>
                            </label>

                            <label class="full-width">
                                Landmark
                                <span class="optional">(optional)</span>

                                <input
                                    type="text"
                                    name="landmark"
                                    placeholder="Near a shop, school, etc.">
                            </label>

                        </div>

                    </div>

                    <!-- PAYMENT METHOD -->

                    <div class="panel payment-panel">

                        <div class="section-title">

                            <span class="title-icon">💳</span>

                            <div>
                                <h2>Payment method</h2>
                                <p>Choose what works for you</p>
                            </div>

                        </div>

                        <input
                            type="hidden"
                            name="paymentMode"
                            id="paymentMode"
                            value="COD">

                        <div class="payment-options">

                            <!-- CASH ON DELIVERY -->

                            <label class="payment-option selected">

                                <input
                                    type="radio"
                                    name="onlineMethod"
                                    value="COD"
                                    checked>

                                <span class="payment-emoji">💵</span>
                                <span class="payment-name">Cash</span>
                                <small>On delivery</small>

                            </label>

                            <!-- UPI -->

                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="onlineMethod"
                                    value="UPI">

                                <span class="payment-emoji">📱</span>
                                <span class="payment-name">UPI</span>
                                <small>Pay online</small>

                            </label>

                            <!-- CARD -->

                            <label class="payment-option">

                                <input
                                    type="radio"
                                    name="onlineMethod"
                                    value="CARD">

                                <span class="payment-emoji">💳</span>
                                <span class="payment-name">Card</span>
                                <small>Debit / credit</small>

                            </label>

                        </div>

                        <p class="payment-hint" id="paymentHint">
                            💚 Pay with cash when your delicious order arrives.
                        </p>

                    </div>

                </section>

                <!-- =================================================
                     ORDER SUMMARY
                ================================================== -->

                <aside class="panel summary-panel">

                    <div class="summary-heading">

                        <div>
                            <h2>Your little feast</h2>
                            <p>Fresh picks, coming your way 🍴</p>
                        </div>

                        <span class="bag-icon">🛍️</span>

                    </div>

                    <!-- CART ITEMS FROM SESSION -->

                    <div class="item-list">

                        <%
                            for (CartItem cartItem : cart.getItems().values()) {
                                Menu menu = cartItem.getMenu();
                        %>

                            <div class="order-item">

                                <div class="item-info">

                                    <span class="item-name">
                                        <%= menu.getItemName() %>
                                    </span>

                                    <span class="item-qty">
                                        Qty: <%= cartItem.getQuantity() %>
                                    </span>

                                </div>

                                <span class="item-price">
                                    ₹<%= String.format("%.2f", cartItem.getTotalAmount()) %>
                                </span>

                            </div>

                        <%
                            }
                        %>

                    </div>

                    <!-- KITCHEN NOTE -->

                    <label class="note-label">

                        Note for the kitchen
                        <span class="optional">(optional)</span>

                        <input
                            type="text"
                            name="orderNote"
                            placeholder="Less spicy, extra chutney..."
                            maxlength="150">

                    </label>

                    <!-- PRICE BREAKDOWN -->

                    <div class="price-breakdown">

                        <div>
                            <span>Subtotal</span>
                            <span>₹<%= String.format("%.2f", subtotal) %></span>
                        </div>

                        <div>
                            <span>Delivery</span>
                            <span>₹<%= String.format("%.2f", deliveryFee) %></span>
                        </div>

                        <div>
                            <span>Platform fee</span>
                            <span>₹<%= String.format("%.2f", platformFee) %></span>
                        </div>

                        <div>
                            <span>Taxes (5%)</span>
                            <span>₹<%= String.format("%.2f", tax) %></span>
                        </div>

                    </div>

                    <!-- GRAND TOTAL -->

                    <div class="grand-total">

                        <div>
                            <span>Total to pay</span>
                            <small>Inclusive of all charges</small>
                        </div>

                        <strong>
                            ₹<%= String.format("%.2f", grandTotal) %>
                        </strong>

                    </div>

                    <!-- PLACE ORDER -->

                    <button
                        class="place-order-btn"
                        type="submit"
                        id="placeOrderBtn">

                        Place my order <span>♡</span>

                    </button>

                    <p class="bottom-note">
                        Made with love &amp; tomatoes 🍅
                    </p>

                </aside>

            </div>

        </form>

    </main>

    <%@ include file="Footer.jsp" %>

</body>
</html>
