package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDao;
import com.tap.model.Menu;
import com.tap.util.DBConnection;

public class MenuDaoImpl implements MenuDao {

    public static final String INSERT_QUERY =
            "INSERT INTO menu (restaurantId, itemName, description, price, available, imagePath) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
            "SELECT * FROM menu WHERE menuId = ?";

    public static final String SELECT_BY_RESTAURANT_QUERY =
            "SELECT * FROM menu WHERE restaurantId = ?";

    public static final String UPDATE_QUERY =
            "UPDATE menu SET restaurantId = ?, itemName = ?, description = ?, "
            + "price = ?, available = ?, imagePath = ? "
            + "WHERE menuId = ?";

    public static final String DELETE_QUERY =
            "DELETE FROM menu WHERE menuId = ?";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM menu";


    @Override
    public void addMenu(Menu menu) {

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(INSERT_QUERY);

            pstmt.setInt(1, menu.getRestaurantId());

            pstmt.setString(2, menu.getItemName());

            pstmt.setString(3, menu.getDescription());

            pstmt.setDouble(4, menu.getPrice());

            pstmt.setBoolean(5, menu.isAvailable());

            pstmt.setString(6, menu.getImagePath());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " menu inserted successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public Menu getMenu(int menuId) {

        Menu menu = null;

        Connection connection = DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(SELECT_QUERY);

            pstmt.setInt(1, menuId);

            ResultSet res = pstmt.executeQuery();

            if (res.next()) {

                menu = extractMenuFromResultSet(res);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return menu;
    }


    @Override
    public List<Menu> getMenusByRestaurantId(int restaurantId) {

        ArrayList<Menu> allMenus =
                new ArrayList<Menu>();

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(
                            SELECT_BY_RESTAURANT_QUERY
                    );

            pstmt.setInt(1, restaurantId);

            ResultSet res =
                    pstmt.executeQuery();

            while (res.next()) {

                Menu menu =
                        extractMenuFromResultSet(res);

                allMenus.add(menu);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allMenus;
    }


    private Menu extractMenuFromResultSet(ResultSet res)
            throws SQLException {

        int menuId = res.getInt("menuId");

        int restaurantId = res.getInt("restaurantId");

        String itemName = res.getString("itemName");

        String description = res.getString("description");

        double price = res.getDouble("price");

        boolean available = res.getBoolean("available");

        String imagePath = res.getString("imagePath");

        Menu menu = new Menu(
                menuId,
                restaurantId,
                itemName,
                description,
                price,
                available,
                imagePath
        );

        return menu;
    }


    @Override
    public void updateMenu(Menu menu) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(UPDATE_QUERY);

            pstmt.setInt(1, menu.getRestaurantId());

            pstmt.setString(2, menu.getItemName());

            pstmt.setString(3, menu.getDescription());

            pstmt.setDouble(4, menu.getPrice());

            pstmt.setBoolean(5, menu.isAvailable());

            pstmt.setString(6, menu.getImagePath());

            pstmt.setInt(7, menu.getMenuId());

            int rows = pstmt.executeUpdate();

            System.out.println(rows + " menu updated successfully");

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public void deleteMenu(int menuId) {

        Connection connection =
                DBConnection.getConnection();

        try {

            PreparedStatement pstmt =
                    connection.prepareStatement(DELETE_QUERY);

            pstmt.setInt(1, menuId);

            int rows =
                    pstmt.executeUpdate();

            System.out.println(
                    rows + " menu deleted successfully"
            );

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }


    @Override
    public List<Menu> getAllMenus() {

        ArrayList<Menu> allMenus =
                new ArrayList<Menu>();

        Connection connection =
                DBConnection.getConnection();

        try {

            Statement stmt =
                    connection.createStatement();

            ResultSet res =
                    stmt.executeQuery(SELECT_ALL_QUERY);

            while (res.next()) {

                Menu menu =
                        extractMenuFromResultSet(res);

                allMenus.add(menu);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return allMenus;
    }
}