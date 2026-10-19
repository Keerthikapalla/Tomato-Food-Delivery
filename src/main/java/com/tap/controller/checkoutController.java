package com.tap.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.OrderItemDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class checkoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        User user = session == null
                ? null
                : (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.setAttribute("cart", cart);
        req.setAttribute("user", user);

        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/checkout.jsp");

        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        // 1. Verify login
        User user = session == null
                ? null
                : (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Verify cart
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()
                || cart.getItems() == null
                || cart.getItems().isEmpty()) {

            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // 3. Validate delivery details on the server
        String fullName = trim(req.getParameter("fullName"));
        String phone = trim(req.getParameter("phone"));
        String address = trim(req.getParameter("address"));
        String city = trim(req.getParameter("city"));
        String pincode = trim(req.getParameter("pincode"));

        if (fullName.length() < 2) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Please enter your full name.");
            return;
        }

        if (!phone.matches("[0-9]{10}")) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Please enter a valid 10-digit phone number.");
            return;
        }

        if (address.length() < 5) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Please enter your complete delivery address.");
            return;
        }

        if (city.isEmpty()) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Please enter your city.");
            return;
        }

        if (!pincode.matches("[0-9]{6}")) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Please enter a valid 6-digit PIN code.");
            return;
        }

        // 4. Only COD is enabled for now
        String paymentMode = trim(req.getParameter("paymentMode"));

        if (!"COD".equals(paymentMode)) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Only Cash on Delivery is available right now.");
            return;
        }

        // 5. Identify the restaurant from the cart
        Map<Integer, CartItem> cartItems = cart.getItems();

        int restaurantId = 0;

        for (CartItem cartItem : cartItems.values()) {
            if (cartItem == null
                    || cartItem.getMenu() == null
                    || cartItem.getQuantity() <= 0) {

                forwardCheckoutError(
                        req, resp, cart, user,
                        "Your cart contains an invalid item. Please review it.");
                return;
            }

            int itemRestaurantId =
                    cartItem.getMenu().getRestaurantId();

            if (restaurantId == 0) {
                restaurantId = itemRestaurantId;
            } else if (restaurantId != itemRestaurantId) {
                forwardCheckoutError(
                        req, resp, cart, user,
                        "Please order from one restaurant at a time.");
                return;
            }

            if (cartItem.getMenu().getPrice() < 0) {
                forwardCheckoutError(
                        req, resp, cart, user,
                        "An item has an invalid price. Please review your cart.");
                return;
            }
        }

        if (restaurantId <= 0) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Unable to identify the restaurant for your order.");
            return;
        }

        // 6. Calculate totals on the server
        double subtotal = cart.getTotalAmount();

        if (subtotal <= 0) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "Your order total is invalid.");
            return;
        }

        double deliveryFee = 40.0;
        double platformFee = 10.0;
        double taxes = subtotal * 0.05;

        double grandTotal =
                subtotal + deliveryFee + platformFee + taxes;

        // 7. Create the order
        String orderDate =
                new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(new Date());

        Order order = new Order();

        order.setUserId(user.getUserId());
        order.setRestaurantId(restaurantId);
        order.setOrderDate(orderDate);
        order.setTotalAmount(grandTotal);
        order.setStatus("PLACED");
        order.setPaymentMode("COD");

        OrderDaoImpl orderDao = new OrderDaoImpl();

        orderDao.addOrder(order);

        int orderId = order.getOrderId();

        if (orderId <= 0) {
            forwardCheckoutError(
                    req, resp, cart, user,
                    "We couldn't create your order. Please try again.");
            return;
        }

        // 8. Save the order items
        OrderItemDaoImpl orderItemDao =
                new OrderItemDaoImpl();

        for (CartItem cartItem : cartItems.values()) {

            Menu menu = cartItem.getMenu();
            int quantity = cartItem.getQuantity();

            double itemTotal = menu.getPrice() * quantity;

            OrderItem orderItem = new OrderItem();

            orderItem.setOrderId(orderId);
            orderItem.setMenuId(menu.getMenuId());
            orderItem.setQuantity(quantity);

            // Existing orderitem.totalAmount column is INT.
            orderItem.setTotalAmount(
                    (int) Math.round(itemTotal));

            orderItemDao.addOrderItem(orderItem);
        }

        // 9. Clear cart only after order processing
        session.removeAttribute("cart");

        // 10. Show order success
        req.setAttribute("orderId", orderId);
        req.setAttribute("order", order);

        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/orderSuccess.jsp");

        dispatcher.forward(req, resp);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private void forwardCheckoutError(
            HttpServletRequest req,
            HttpServletResponse resp,
            Cart cart,
            User user,
            String message)
            throws ServletException, IOException {

        req.setAttribute("checkoutError", message);
        req.setAttribute("cart", cart);
        req.setAttribute("user", user);

        RequestDispatcher dispatcher =
                req.getRequestDispatcher("/checkout.jsp");

        dispatcher.forward(req, resp);
    }
}