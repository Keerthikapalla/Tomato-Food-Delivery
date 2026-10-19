package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDao;
import com.tap.model.Restaurant;
import com.tap.util.DBConnection;

public class RestaurantDaoImpl implements RestaurantDao {

    public static final String INSERT_QUERY =
            "INSERT INTO restaurants (name, cuisineType, deliveryTime, address, "
            + "adminUserId, rating, isActive, imagePath) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
            "SELECT * FROM restaurants WHERE restaurantId = ?";

    public static final String UPDATE_QUERY =
            "UPDATE restaurants SET name = ?, cuisineType = ?, deliveryTime = ?, "
            + "address = ?, adminUserId = ?, rating = ?, isActive = ?, imagePath = ? "
            + "WHERE restaurantId = ?";

    public static final String DELETE_QUERY =
            "DELETE FROM restaurants WHERE restaurantId = ?";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM restaurants";


    @Override
    public void addRestaurant(Restaurant restaurant) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(INSERT_QUERY);

            pstmt.setString(1, restaurant.getName());

            pstmt.setString(2, restaurant.getCuisineType());

            pstmt.setString(3, restaurant.getDeliveryTime());

            pstmt.setString(4, restaurant.getAddress());

            pstmt.setInt(5, restaurant.getAdminUserId());

            pstmt.setDouble(6, restaurant.getRating());

            pstmt.setBoolean(7, restaurant.isActive());

            pstmt.setString(8, restaurant.getImagePath());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " restaurant inserted successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public Restaurant getRestaurant(int restaurantId) {

        Restaurant restaurant = null;

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(SELECT_QUERY);

            pstmt.setInt(1, restaurantId);

            ResultSet res = pstmt.executeQuery();

            if (res.next()) {

                restaurant = extractRestaurantFromResultSet(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return restaurant;
    }


    private Restaurant extractRestaurantFromResultSet(ResultSet res)
            throws SQLException {

        int restaurantId = res.getInt("restaurantId");

        String name = res.getString("name");

        String cuisineType = res.getString("cuisineType");

        String deliveryTime = res.getString("deliveryTime");

        String address = res.getString("address");

        int adminUserId = res.getInt("adminUserId");

        double rating = res.getDouble("rating");

        boolean isActive = res.getBoolean("isActive");

        String imagePath = res.getString("imagePath");

        Restaurant restaurant = new Restaurant(restaurantId, name, cuisineType,
                deliveryTime, address, adminUserId,
               rating, isActive, imagePath);

        return restaurant;
    }


    @Override
    public void updateRestaurant(Restaurant restaurant) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(UPDATE_QUERY);

            pstmt.setString(1, restaurant.getName());

            pstmt.setString(2, restaurant.getCuisineType());

            pstmt.setString(3, restaurant.getDeliveryTime());

            pstmt.setString(4, restaurant.getAddress());

            pstmt.setInt(5, restaurant.getAdminUserId());

            pstmt.setDouble(6, restaurant.getRating());

            pstmt.setBoolean(7, restaurant.isActive());

            pstmt.setString(8, restaurant.getImagePath());

            pstmt.setInt(9, restaurant.getRestaurantId());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " restaurant updated successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public void deleteRestaurant(int restaurantId) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(DELETE_QUERY);

            pstmt.setInt(1, restaurantId);

            int rows =
                    pstmt.executeUpdate();

            System.out.println(
                    rows + " restaurant deleted successfully"
            );

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public List<Restaurant> getAllRestaurants() {

        ArrayList<Restaurant> allRestaurants =
                new ArrayList<Restaurant>();

        Connection connection =
                DBConnection.getConnection();

        try {

            Statement stmt =
                    connection.createStatement();

            ResultSet res =
                    stmt.executeQuery(SELECT_ALL_QUERY);

            while (res.next()) {

                Restaurant restaurant =
                        extractRestaurantFromResultSet(res);

                allRestaurants.add(restaurant);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allRestaurants;
    }
}