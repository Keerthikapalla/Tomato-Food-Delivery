
package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.UserDao;
import com.tap.model.User;
import com.tap.util.DBConnection;

public class UserDaoImpl implements UserDao {

    public static final String INSERT_QUERY =
            "INSERT INTO users "
            + "(username, password, email, phone, address, role, theme) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    public static final String SELECT_QUERY =
            "SELECT * FROM users WHERE userId = ?";

    public static final String GET_USER_BY_EMAIL =
            "SELECT * FROM users WHERE email = ?";

    public static final String UPDATE_QUERY =
            "UPDATE users SET "
            + "username = ?, "
            + "password = ?, "
            + "email = ?, "
            + "phone = ?, "
            + "address = ?, "
            + "role = ?, "
            + "theme = ? "
            + "WHERE userId = ?";

    public static final String DELETE_QUERY =
            "DELETE FROM users WHERE userId = ?";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM users";

    public static final String UPDATE_PASSWORD_QUERY =
            "UPDATE users SET password = ? WHERE userId = ?";

    public static final String UPDATE_THEME_QUERY =
            "UPDATE users SET theme = ? WHERE userId = ?";


    // ADD USER
    @Override
    public void addUser(User user) {

        if (user == null) {
            return;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            System.out.println("Database connection is unavailable.");
            return;
        }

        try (PreparedStatement pstmt = connection.prepareStatement(
                INSERT_QUERY, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setString(7, normalizeTheme(user.getTheme()));

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                try (ResultSet keys = pstmt.getGeneratedKeys()) {
                    if (keys.next()) {
                        user.setUserId(keys.getInt(1));
                    }
                }

                System.out.println("User inserted successfully.");
            }

        } catch (SQLException e) {
            System.out.println("Error while inserting user:");
            e.printStackTrace();
        }
    }


    // GET USER BY ID
    @Override
    public User getUser(int userId) {

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return null;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(SELECT_QUERY)) {

            pstmt.setInt(1, userId);

            try (ResultSet res = pstmt.executeQuery()) {
                if (res.next()) {
                    return extractUserFromResultSet(res);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error while retrieving user:");
            e.printStackTrace();
        }

        return null;
    }


    // GET USER BY EMAIL
    @Override
    public User getUserByEmail(String userEmail) {

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return null;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(GET_USER_BY_EMAIL)) {

            pstmt.setString(1, userEmail);

            try (ResultSet res = pstmt.executeQuery()) {
                if (res.next()) {
                    return extractUserFromResultSet(res);
                }
            }

        } catch (SQLException e) {
            System.out.println("Error while finding user by email:");
            e.printStackTrace();
        }

        return null;
    }


    // MAP DATABASE ROW TO USER
    private User extractUserFromResultSet(ResultSet res)
            throws SQLException {

        User user = new User();

        user.setUserId(res.getInt("userId"));
        user.setUsername(res.getString("username"));
        user.setPassword(res.getString("password"));
        user.setEmail(res.getString("email"));
        user.setPhone(res.getString("phone"));
        user.setAddress(res.getString("address"));
        user.setRole(res.getString("role"));

        // Load the saved theme from MySQL.
        user.setTheme(res.getString("theme"));

        return user;
    }


    // UPDATE USER PROFILE
    @Override
    public void updateUser(User user) {

        if (user == null) {
            return;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(UPDATE_QUERY)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            pstmt.setString(6, user.getRole());
            pstmt.setString(7, normalizeTheme(user.getTheme()));
            pstmt.setInt(8, user.getUserId());

            int rows = pstmt.executeUpdate();
            System.out.println(rows + " user record(s) updated.");

        } catch (SQLException e) {
            System.out.println("Error while updating user:");
            e.printStackTrace();
        }
    }


    // UPDATE PASSWORD
    @Override
    public boolean updatePassword(int userId, String hashedPassword) {

        if (userId <= 0 || hashedPassword == null
                || hashedPassword.trim().isEmpty()) {
            return false;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(UPDATE_PASSWORD_QUERY)) {

            pstmt.setString(1, hashedPassword);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            System.out.println("Error while updating password:");
            e.printStackTrace();
            return false;
        }
    }


    // SAVE THEME PREFERENCE
    @Override
    public boolean updateTheme(int userId, String theme) {

        if (userId <= 0
                || theme == null
                || (!"light".equalsIgnoreCase(theme.trim())
                && !"dark".equalsIgnoreCase(theme.trim()))) {
            return false;
        }

        String normalizedTheme = theme.trim().toLowerCase();
        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            System.out.println("Cannot save theme: database unavailable.");
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(UPDATE_THEME_QUERY)) {

            pstmt.setString(1, normalizedTheme);
            pstmt.setInt(2, userId);

            int rows = pstmt.executeUpdate();
            return rows == 1;

        } catch (SQLException e) {
            System.out.println("Error while saving theme preference:");
            e.printStackTrace();
            return false;
        }
    }


    // DELETE USER
    @Override
    public void deleteUser(int userId) {

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(DELETE_QUERY)) {

            pstmt.setInt(1, userId);

            int rows = pstmt.executeUpdate();
            System.out.println(rows + " user record(s) deleted.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    // GET ALL USERS
    @Override
    public List<User> getAllUsers() {

        List<User> allUsers = new ArrayList<>();
        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return allUsers;
        }

        try (Statement stmt = connection.createStatement();
             ResultSet res = stmt.executeQuery(SELECT_ALL_QUERY)) {

            while (res.next()) {
                allUsers.add(extractUserFromResultSet(res));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return allUsers;
    }


    // VALIDATE THE THEME VALUE
    private String normalizeTheme(String theme) {
        return "dark".equalsIgnoreCase(theme) ? "dark" : "light";
    }
}
