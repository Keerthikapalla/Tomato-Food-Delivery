package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDao;
import com.tap.model.OrderItem;
import com.tap.util.DBConnection;

public class OrderItemDaoImpl implements OrderItemDao {

    public static final String INSERT_QUERY =
            "INSERT INTO orderitem (orderId, menuId, quantity, totalAmount) "
            + "VALUES (?, ?, ?, ?)";

    public static final String SELECT_QUERY =
            "SELECT * FROM orderitem WHERE orderItemId = ?";

    public static final String SELECT_BY_ORDER_QUERY =
            "SELECT * FROM orderitem WHERE orderId = ?";

    public static final String UPDATE_QUERY =
            "UPDATE orderitem SET orderId = ?, menuId = ?, quantity = ?, "
            + "totalAmount = ? WHERE orderItemId = ?";

    public static final String DELETE_QUERY =
            "DELETE FROM orderitem WHERE orderItemId = ?";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM orderitem";


    @Override
    public void addOrderItem(OrderItem orderItem) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(INSERT_QUERY);

            pstmt.setInt(1, orderItem.getOrderId());

            pstmt.setInt(2, orderItem.getMenuId());

            pstmt.setInt(3, orderItem.getQuantity());

            pstmt.setInt(4, orderItem.getTotalAmount());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " order item inserted successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public OrderItem getOrderItem(int orderItemId) {

        OrderItem orderItem = null;

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(SELECT_QUERY);

            pstmt.setInt(1, orderItemId);

            ResultSet res = pstmt.executeQuery();

            if (res.next()) {

                orderItem = extractOrderItemFromResultSet(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return orderItem;
    }


    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {

        ArrayList<OrderItem> allOrderItems =
                new ArrayList<OrderItem>();

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(
                            SELECT_BY_ORDER_QUERY
                    );

            pstmt.setInt(1, orderId);

            ResultSet res =
                    pstmt.executeQuery();

            while (res.next()) {

                OrderItem orderItem =
                        extractOrderItemFromResultSet(res);

                allOrderItems.add(orderItem);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allOrderItems;
    }


    private OrderItem extractOrderItemFromResultSet(ResultSet res)
            throws SQLException {

        int orderItemId = res.getInt("orderItemId");

        int orderId = res.getInt("orderId");

        int menuId = res.getInt("menuId");

        int quantity = res.getInt("quantity");

        int totalAmount = res.getInt("totalAmount");

        OrderItem orderItem = new OrderItem(
                orderItemId,
                orderId,
                menuId,
                quantity,
                totalAmount
        );

        return orderItem;
    }


    @Override
    public void updateOrderItem(OrderItem orderItem) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(UPDATE_QUERY);

            pstmt.setInt(1, orderItem.getOrderId());

            pstmt.setInt(2, orderItem.getMenuId());

            pstmt.setInt(3, orderItem.getQuantity());

            pstmt.setInt(4, orderItem.getTotalAmount());

            pstmt.setInt(5, orderItem.getOrderItemId());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " order item updated successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public void deleteOrderItem(int orderItemId) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(DELETE_QUERY);

            pstmt.setInt(1, orderItemId);

            int rows =
                    pstmt.executeUpdate();

            System.out.println(
                    rows + " order item deleted successfully"
            );

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public List<OrderItem> getAllOrderItems() {

        ArrayList<OrderItem> allOrderItems =
                new ArrayList<OrderItem>();

        Connection connection =
                DBConnection.getConnection();

        try {

            Statement stmt =
                    connection.createStatement();

            ResultSet res =
                    stmt.executeQuery(SELECT_ALL_QUERY);

            while (res.next()) {

                OrderItem orderItem =
                        extractOrderItemFromResultSet(res);

                allOrderItems.add(orderItem);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allOrderItems;
    }
}