
package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final MenuDaoImpl menuDao = new MenuDaoImpl();

    private boolean isAjax(HttpServletRequest request) {
        return "XMLHttpRequest".equals(
                request.getHeader("X-Requested-With"));
    }

    private Cart getSessionCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        return cart;
    }

    private int getCartCount(Cart cart) {
        int count = 0;

        if (cart != null && cart.getItems() != null) {
            for (CartItem item : cart.getItems().values()) {
                if (item != null) {
                    count += item.getQuantity();
                }
            }
        }

        return count;
    }

    private int getItemQuantity(Cart cart, int menuId) {
        if (cart == null || cart.getItems() == null) {
            return 0;
        }

        CartItem item = cart.getItems().get(menuId);

        return item == null ? 0 : item.getQuantity();
    }

    private void sendJson(
            HttpServletResponse response,
            int status,
            boolean success,
            int cartCount,
            int quantity,
            String message) throws IOException {

        response.setStatus(status);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");

        response.getWriter().write(
                "{"
                + "\"success\":" + success + ","
                + "\"cartCount\":" + cartCount + ","
                + "\"quantity\":" + quantity + ","
                + "\"message\":\"" + escapeJson(message) + "\""
                + "}"
        );
    }

    /*
     * Ask for confirmation when adding an item from
     * a different restaurant without modifying the cart.
     */
    private void sendRestaurantSwitchConfirmation(
            HttpServletResponse response,
            Cart cart,
            int menuId,
            int requestedRestaurantId) throws IOException {

        response.setStatus(HttpServletResponse.SC_CONFLICT);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");

        response.getWriter().write(
                "{"
                + "\"success\":false,"
                + "\"requiresConfirmation\":true,"
                + "\"cartCount\":" + getCartCount(cart) + ","
                + "\"quantity\":" + getItemQuantity(cart, menuId) + ","
                + "\"restaurantId\":" + requestedRestaurantId + ","
                + "\"message\":\"Your cart contains items from another restaurant. Would you like to replace your cart?\""
                + "}"
        );
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }

    private void respond(
            HttpServletRequest request,
            HttpServletResponse response,
            Cart cart,
            int menuId,
            boolean success,
            int status,
            String message) throws IOException {

        if (isAjax(request)) {
            sendJson(
                    response,
                    status,
                    success,
                    getCartCount(cart),
                    getItemQuantity(cart, menuId),
                    message
            );
        } else {
            String restaurantId =
                    request.getParameter("restaurantId");

            if ("menu".equals(request.getParameter("source"))
                    && restaurantId != null
                    && !restaurantId.isBlank()) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/menu?restaurantId=" + restaurantId
                );

            } else {
                response.sendRedirect(
                        request.getContextPath() + "/cart"
                );
            }
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Cart cart = getSessionCart(session);

        String action = request.getParameter("action");

        if (action == null || action.isBlank()) {
            action = "add";
        }

        /*
         * =====================================================
         * CLEAR CART
         *
         * IMPORTANT:
         * Process this action BEFORE menuId validation.
         * Clearing the entire cart does not require a menuId.
         * =====================================================
         */
        if ("clear".equals(action)) {

            synchronized (session) {

                // Clear the existing Cart object as well.
                Cart existingCart =
                        (Cart) session.getAttribute("cart");

                if (existingCart != null) {
                    existingCart.clear();
                }

                // Remove the cart from the session.
                session.removeAttribute("cart");

                // Remove any previous cart error message.
                session.removeAttribute("cartError");
            }

            if (isAjax(request)) {

                sendJson(
                        response,
                        HttpServletResponse.SC_OK,
                        true,
                        0,
                        0,
                        "Cart cleared successfully."
                );

            } else {

                // Reload cart.jsp with no cart in the session.
                response.sendRedirect(
                        request.getContextPath() + "/cart"
                );
            }

            return;
        }

        /*
         * Validate menuId for actions that require a menu item.
         */
        int menuId;

        try {
            String menuIdValue =
                    request.getParameter("menuId");

            if (menuIdValue == null || menuIdValue.isBlank()) {
                throw new NumberFormatException();
            }

            menuId = Integer.parseInt(menuIdValue);

        } catch (NumberFormatException e) {

            respond(
                    request,
                    response,
                    cart,
                    0,
                    false,
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid menu ID."
            );

            return;
        }

        /*
         * =====================================================
         * ADD OR REPLACE
         *
         * add:
         * Add an item unless the cart contains items from
         * another restaurant.
         *
         * replace:
         * Replace the cart after restaurant-switch confirmation.
         * =====================================================
         */
        if ("add".equals(action) || "replace".equals(action)) {

            if (menuId <= 0) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid menu ID."
                );

                return;
            }

            Menu menu = menuDao.getMenu(menuId);

            if (menu == null) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_NOT_FOUND,
                        "Menu item not found."
                );

                return;
            }

            if (!menu.isAvailable()) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_CONFLICT,
                        "This item is currently unavailable."
                );

                return;
            }

            synchronized (session) {

                // Get the latest cart before making changes.
                cart = getSessionCart(session);

                boolean cartHasItems =
                        cart.getItems() != null
                        && !cart.getItems().isEmpty();

                boolean differentRestaurant =
                        cartHasItems
                        && cart.getRestaurantId()
                                != menu.getRestaurantId();

                /*
                 * A different restaurant was selected.
                 * Do not modify the existing cart yet.
                 */
                if ("add".equals(action) && differentRestaurant) {

                    if (isAjax(request)) {

                        sendRestaurantSwitchConfirmation(
                                response,
                                cart,
                                menuId,
                                menu.getRestaurantId()
                        );

                    } else {

                        String restaurantId =
                                request.getParameter("restaurantId");

                        if (restaurantId != null
                                && !restaurantId.isBlank()) {

                            response.sendRedirect(
                                    request.getContextPath()
                                    + "/menu?restaurantId="
                                    + restaurantId
                            );

                        } else {

                            response.sendRedirect(
                                    request.getContextPath() + "/cart"
                            );
                        }
                    }

                    return;
                }

                /*
                 * Replace the cart if the user confirmed
                 * switching to a different restaurant.
                 */
                if ("replace".equals(action)
                        && differentRestaurant) {

                    Cart replacementCart = new Cart();

                    replacementCart.setRestaurantId(
                            menu.getRestaurantId());

                    replacementCart.addItem(menu);

                    session.setAttribute(
                            "cart",
                            replacementCart
                    );

                    cart = replacementCart;

                } else {

                    // Normal Add to Cart operation.
                    cart.setRestaurantId(
                            menu.getRestaurantId());

                    cart.addItem(menu);

                    session.setAttribute("cart", cart);
                }
            }

            respond(
                    request,
                    response,
                    cart,
                    menuId,
                    true,
                    HttpServletResponse.SC_OK,
                    "replace".equals(action)
                            ? "Cart updated successfully."
                            : "Item added to cart."
            );

            return;
        }

        /*
         * =====================================================
         * UPDATE QUANTITY
         * =====================================================
         */
        if ("update".equals(action)) {

            if (menuId <= 0) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid menu ID."
                );

                return;
            }

            int quantity;

            try {

                quantity = Integer.parseInt(
                        request.getParameter("quantity"));

            } catch (NumberFormatException e) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid quantity."
                );

                return;
            }

            if (quantity < 0) {

                respond(
                        request, response, cart, menuId,
                        false, HttpServletResponse.SC_BAD_REQUEST,
                        "Quantity cannot be negative."
                );

                return;
            }

            synchronized (session) {

                cart = getSessionCart(session);

                cart.updateQuantity(menuId, quantity);

                if (cart.getItems() == null
                        || cart.getItems().isEmpty()) {

                    cart.clear();
                    session.removeAttribute("cart");

                    cart = new Cart();

                } else {

                    session.setAttribute("cart", cart);
                }
            }

            respond(
                    request,
                    response,
                    cart,
                    menuId,
                    true,
                    HttpServletResponse.SC_OK,
                    "Cart quantity updated."
            );

            return;
        }

        /*
         * =====================================================
         * REMOVE ITEM
         * =====================================================
         */
        if ("remove".equals(action)) {

            synchronized (session) {

                cart = getSessionCart(session);

                cart.removeItem(menuId);

                if (cart.getItems() == null
                        || cart.getItems().isEmpty()) {

                    cart.clear();
                    session.removeAttribute("cart");

                    cart = new Cart();

                } else {

                    session.setAttribute("cart", cart);
                }
            }

            respond(
                    request,
                    response,
                    cart,
                    menuId,
                    true,
                    HttpServletResponse.SC_OK,
                    "Item removed from cart."
            );

            return;
        }

        /*
         * =====================================================
         * INVALID ACTION
         * =====================================================
         */
        respond(
                request,
                response,
                cart,
                menuId,
                false,
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid cart action."
        );
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        Cart cart = session == null
                ? null
                : (Cart) session.getAttribute("cart");

        request.setAttribute("cart", cart);

        request.getRequestDispatcher("/cart.jsp")
               .forward(request, response);
    }
}
