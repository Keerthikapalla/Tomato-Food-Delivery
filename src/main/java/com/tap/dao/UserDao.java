
package com.tap.dao;

import java.util.List;

import com.tap.model.User;

public interface UserDao {

    void addUser(User user);

    User getUserByEmail(String userEmail);

    User getUser(int userId);

    List<User> getAllUsers();

    void updateUser(User user);

    void deleteUser(int userId);

    // Update the password hash for a specific user.
    boolean updatePassword(int userId, String hashedPassword);

    // Save the theme preference for a specific user.
    boolean updateTheme(int userId, String theme);
}
