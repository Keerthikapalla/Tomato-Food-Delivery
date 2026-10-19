<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.OrderItem" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.User" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    Map<Integer, List<OrderItem>> orderItemsMap =
            (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

    Map<Integer, Menu> menuMap =
            (Map<Integer, Menu>) request.getAttribute("menuMap");

    User user = (User) request.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>TOMATO | My Orders</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/orders.css?v=2">
</head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/orders.css?v=3">

<body>

    <!-- =========================================================
         NAVBAR
    ========================================================== -->

   <%@ include file="navbar.jsp" %>

    <!-- ================= FLOATING TOMATOES ================= -->

    <div class="floating-tomato tomato-one">🍅</div>
    <div class="floating-tomato tomato-two">🍅</div>
    <div class="floating-tomato tomato-three">🍅</div>
    <div class="floating-tomato tomato-four">🍅</div>


    <!-- ================= MAIN ================= -->

    <main class="orders-page">

        <!-- HERO -->

        <section class="orders-hero">

            <div class="hero-tomato">
                🍅
            </div>

            <div class="hero-content">

                <span class="hero-small">
                    YOUR FOOD JOURNEY
                </span>

                <h1>
                    My Delicious Orders
                    <span>❤️</span>
                </h1>

                <p>
                    Every order has a tasty story.
                    Let's see what you enjoyed!
                </p>

            </div>

            <div class="hero-decoration">
                ✨
            </div>

        </section>


        <!-- ================= ORDERS ================= -->

        <section class="orders-container">

            <%
                if (orders == null || orders.isEmpty()) {
            %>

                <!-- EMPTY ORDERS -->

                <div class="empty-orders">

                    <div class="empty-animation">
                        <div class="empty-tomato">🍅</div>
                        <div class="empty-plate">🍽️</div>
                    </div>

                    <h2>
                        No Orders Yet!
                    </h2>

                    <p>
                        Your delicious journey is waiting to begin.
                    </p>

                    <a href="${pageContext.request.contextPath}/restaurant"
                       class="order-food-btn">
                        🍕 Order Some Food
                    </a>

                </div>

            <%
                } else {
            %>

                <div class="orders-top">

                    <div>
                        <span class="section-label">
                            🍽️ YOUR HISTORY
                        </span>

                        <h2>
                            Your Orders
                        </h2>
                    </div>

                    <div class="order-count">
                        <span><%= orders.size() %></span>
                        <small>
                            <%= orders.size() == 1 ? "Order" : "Orders" %>
                        </small>
                    </div>

                </div>


                <div class="orders-list">

                <%
                    int orderNumber = 0;

                    for (Order order : orders) {

                        orderNumber++;

                        int orderId = order.getOrderId();

                        List<OrderItem> orderItems =
                                orderItemsMap.get(orderId);

                        if (orderItems == null) {
                            orderItems = new java.util.ArrayList<OrderItem>();
                        }

                        String status =
                                order.getStatus() == null
                                ? "PLACED"
                                : order.getStatus();

                        String payment =
                                order.getPaymentMode() == null
                                ? "N/A"
                                : order.getPaymentMode();

                        String statusClass =
                                status.toLowerCase().replace(" ", "-");
                %>


                    <!-- ================= ORDER CARD ================= -->

                    <article class="order-card"
                             style="--card-delay:<%= orderNumber * 0.12 %>s;">

                        <!-- CARD TOP -->

                        <div class="order-card-top">

                            <div class="order-number">

                                <div class="order-icon">
                                    📦
                                </div>

                                <div>
                                    <span>
                                        ORDER
                                    </span>

                                    <h3>
                                        #<%= orderId %>
                                    </h3>
                                </div>

                            </div>


                            <div class="status-badge <%= statusClass %>">

                                <span class="status-dot"></span>

                                <%= status %>

                            </div>

                        </div>


                        <!-- ORDER META -->

                        <div class="order-meta">

                            <div class="meta-item">

                                <span class="meta-icon">
                                    📅
                                </span>

                                <div>
                                    <small>
                                        ORDER DATE
                                    </small>

                                    <strong>
                                        <%= order.getOrderDate() %>
                                    </strong>
                                </div>

                            </div>


                            <div class="meta-item">

                                <span class="meta-icon">
                                    💳
                                </span>

                                <div>
                                    <small>
                                        PAYMENT
                                    </small>

                                    <strong>
                                        <%= payment %>
                                    </strong>
                                </div>

                            </div>


                            <div class="meta-item">

                                <span class="meta-icon">
                                    🍴
                                </span>

                                <div>
                                    <small>
                                        ITEMS
                                    </small>

                                    <strong>
                                        <%= orderItems.size() %>
                                    </strong>
                                </div>

                            </div>


                            <div class="meta-item total-meta">

                                <span class="meta-icon">
                                    💰
                                </span>

                                <div>
                                    <small>
                                        TOTAL
                                    </small>

                                    <strong>
                                        ₹<%= String.format("%.2f", order.getTotalAmount()) %>
                                    </strong>
                                </div>

                            </div>

                        </div>


                        <!-- ================= DELIVERY JOURNEY ================= -->

                        <div class="delivery-journey">

                            <div class="journey-title">
                                <span>🚚</span>
                                Your Food Journey
                            </div>

                            <div class="timeline">

                                <div class="timeline-line"></div>

                                <div class="timeline-step active">

                                    <div class="timeline-circle">
                                        ✓
                                    </div>

                                    <span>
                                        Placed
                                    </span>

                                </div>


                                <div class="timeline-step
                                    <%= status.equalsIgnoreCase("PREPARING")
                                        || status.equalsIgnoreCase("ON THE WAY")
                                        || status.equalsIgnoreCase("DELIVERED")
                                        ? "active" : "" %>">

                                    <div class="timeline-circle">
                                        👨‍🍳
                                    </div>

                                    <span>
                                        Preparing
                                    </span>

                                </div>


                                <div class="timeline-step
                                    <%= status.equalsIgnoreCase("ON THE WAY")
                                        || status.equalsIgnoreCase("DELIVERED")
                                        ? "active" : "" %>">

                                    <div class="timeline-circle">
                                        🛵
                                    </div>

                                    <span>
                                        On the way
                                    </span>

                                </div>


                                <div class="timeline-step
                                    <%= status.equalsIgnoreCase("DELIVERED")
                                        ? "active" : "" %>">

                                    <div class="timeline-circle">
                                        🏠
                                    </div>

                                    <span>
                                        Delivered
                                    </span>

                                </div>

                            </div>

                        </div>


                        <!-- ================= ITEMS ================= -->

                        <div class="items-section">

                            <div class="items-heading">

                                <h4>
                                    🍕 What's in this order?
                                </h4>

                                <span>
                                    <%= orderItems.size() %>
                                    <%= orderItems.size() == 1 ? "item" : "items" %>
                                </span>

                            </div>


                            <div class="order-items">

                            <%
                                for (OrderItem orderItem : orderItems) {

                                    int menuId = orderItem.getMenuId();

                                    Menu menu = menuMap.get(menuId);

                                    if (menu != null) {
                            %>

                                <div class="order-item">

                                    <div class="item-image-wrapper">

                                        <img
                                            src="<%= menu.getImagePath() %>"
                                            alt="<%= menu.getItemName() %>"
                                            class="item-image"
                                            onerror="this.src='https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=500&q=80';">

                                        <span class="quantity-bubble">
                                            x<%= orderItem.getQuantity() %>
                                        </span>

                                    </div>


                                    <div class="item-details">

                                        <h5>
                                            <%= menu.getItemName() %>
                                        </h5>

                                        <p>
                                            <%= menu.getDescription() %>
                                        </p>

                                        <span class="item-price">
                                            ₹<%= String.format("%.2f", menu.getPrice()) %>
                                            ×
                                            <%= orderItem.getQuantity() %>
                                        </span>

                                    </div>


                                    <div class="item-total">

                                        ₹<%= String.format("%.2f",
                                            (double) orderItem.getTotalAmount()) %>

                                    </div>

                                </div>

                            <%
                                    }
                                }
                            %>

                            </div>

                        </div>


                        <!-- ================= CARD FOOTER ================= -->

                        <div class="order-card-footer">

                            <div class="thank-you">

                                <span>
                                    🍅
                                </span>

                                <div>
                                    <strong>
                                        Made with love!
                                    </strong>

                                    <small>
                                        Thanks for choosing TOMATO
                                    </small>
                                </div>

                            </div>


                            <a href="${pageContext.request.contextPath}/restaurant"
                               class="order-again-btn">

                                🔄 Order Again

                            </a>

                        </div>

                    </article>


                <%
                    }
                %>

                </div>

            <%
                }
            %>

        </section>

    </main>


    <!-- ================= FOOTER ================= -->

    <%@ include file="Footer.jsp" %> 


</body>
</html>