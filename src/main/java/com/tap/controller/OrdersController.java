package com.tap.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.daoImpl.MenuDaoImpl;
import com.tap.daoImpl.OrderDaoImpl;
import com.tap.daoImpl.OrderItemDaoImpl;
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

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = user.getUserId();

        OrderDaoImpl orderDao = new OrderDaoImpl();
        OrderItemDaoImpl orderItemDao = new OrderItemDaoImpl();
        MenuDaoImpl menuDao = new MenuDaoImpl();

        List<Order> orders = orderDao.getOrdersByUserId(userId);

        Map<Integer, List<OrderItem>> orderItemsMap =
                new HashMap<Integer, List<OrderItem>>();

        Map<Integer, Menu> menuMap =
                new HashMap<Integer, Menu>();

        if (orders != null) {

            for (Order order : orders) {

                int orderId = order.getOrderId();

                List<OrderItem> orderItems =
                        orderItemDao.getOrderItemsByOrderId(orderId);

                if (orderItems == null) {
                    orderItems = new ArrayList<OrderItem>();
                }

                orderItemsMap.put(orderId, orderItems);

                for (OrderItem orderItem : orderItems) {

                    int menuId = orderItem.getMenuId();

                    if (!menuMap.containsKey(menuId)) {

                        Menu menu = menuDao.getMenu(menuId);

                        if (menu != null) {
                            menuMap.put(menuId, menu);
                        }
                    }
                }
            }
        }

        req.setAttribute("orders", orders);
        req.setAttribute("orderItemsMap", orderItemsMap);
        req.setAttribute("menuMap", menuMap);
        req.setAttribute("user", user);

        RequestDispatcher rd =
                req.getRequestDispatcher("orders.jsp");

        rd.forward(req, resp);
    }
}