package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderDao;
import com.tap.model.Order;
import com.tap.util.DBConnection;

public class OrderDaoImpl implements OrderDao {

    public static final String INSERT_QUERY =
            "INSERT INTO orders (userId, restaurantId, orderDate, totalAmount, status, paymentMode) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
            "SELECT * FROM orders WHERE orderId = ?";

    public static final String SELECT_BY_USER_QUERY =
            "SELECT * FROM orders WHERE userId = ?";

    public static final String UPDATE_QUERY =
            "UPDATE orders SET userId = ?, restaurantId = ?, orderDate = ?, "
            + "totalAmount = ?, status = ?, paymentMode = ? "
            + "WHERE orderId = ?";

    public static final String DELETE_QUERY =
            "DELETE FROM orders WHERE orderId = ?";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM orders";



    @Override
    public void addOrder(Order order) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(INSERT_QUERY,Statement.RETURN_GENERATED_KEYS);

            pstmt.setInt(1,order.getUserId());

            pstmt.setInt(2,order.getRestaurantId());

            pstmt.setString(3,order.getOrderDate());

            pstmt.setDouble(4,order.getTotalAmount());

            pstmt.setString(5,order.getStatus());

            pstmt.setString(6,order.getPaymentMode());

            int rows = pstmt.executeUpdate();

            if (rows > 0) {

                ResultSet generatedKeys =
                        pstmt.getGeneratedKeys();

                if (generatedKeys.next()) {

                    int generatedOrderId =
                            generatedKeys.getInt(1);

                    order.setOrderId(
                            generatedOrderId
                    );
                }

                generatedKeys.close();

                System.out.println(
                        rows
                        + " order inserted successfully");

                System.out.println(
                        "Generated Order ID: "
                        + order.getOrderId());

            } else {

                System.out.println("Order was not inserted.");
            }

            pstmt.close();

        } catch (SQLException e) {

            System.out.println("Error while inserting order:");

            e.printStackTrace();
        }
    }


    @Override
    public Order getOrder(int orderId) {

        Order order = null;

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(SELECT_QUERY);

            pstmt.setInt(1, orderId);

            ResultSet res = pstmt.executeQuery();

            if (res.next()) {

                order = extractOrderFromResultSet(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return order;
    }


    @Override
    public List<Order> getOrdersByUserId(int userId) {

        ArrayList<Order> allOrders =
                new ArrayList<Order>();

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(
                            SELECT_BY_USER_QUERY
                    );

            pstmt.setInt(1, userId);

            ResultSet res =
                    pstmt.executeQuery();

            while (res.next()) {

                Order order =
                        extractOrderFromResultSet(res);

                allOrders.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allOrders;
    }


    private Order extractOrderFromResultSet(ResultSet res)
            throws SQLException {

        int orderId = res.getInt("orderId");

        int userId = res.getInt("userId");

        int restaurantId = res.getInt("restaurantId");

        String orderDate = res.getString("orderDate");

        double totalAmount = res.getDouble("totalAmount");

        String status = res.getString("status");

        String paymentMode = res.getString("paymentMode");

        Order order = new Order(
                orderId,
                userId,
                restaurantId,
                orderDate,
                totalAmount,
                status,
                paymentMode
        );

        return order;
    }


    @Override
    public void updateOrder(Order order) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(UPDATE_QUERY);

            pstmt.setInt(1, order.getUserId());

            pstmt.setInt(2, order.getRestaurantId());

            pstmt.setString(3, order.getOrderDate());

            pstmt.setDouble(4, order.getTotalAmount());

            pstmt.setString(5, order.getStatus());

            pstmt.setString(6, order.getPaymentMode());

            pstmt.setInt(7, order.getOrderId());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " order updated successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrder(int orderId) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(DELETE_QUERY);

            pstmt.setInt(1, orderId);

            int rows =
                    pstmt.executeUpdate();

            System.out.println(
                    rows + " order deleted successfully"
            );

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public List<Order> getAllOrders() {

        ArrayList<Order> allOrders =
                new ArrayList<Order>();

        Connection connection =
                DBConnection.getConnection();

        try {

            Statement stmt =
                    connection.createStatement();

            ResultSet res =
                    stmt.executeQuery(SELECT_ALL_QUERY);

            while (res.next()) {

                Order order =
                        extractOrderFromResultSet(res);

                allOrders.add(order);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allOrders;
    }
}