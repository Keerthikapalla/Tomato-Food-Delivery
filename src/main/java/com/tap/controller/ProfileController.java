
package com.tap.controller;

import java.io.IOException;

import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDaoImpl userDao = new UserDaoImpl();

    private Integer getLoggedInUserId(HttpSession session) {
        Object value = session.getAttribute("userId");

        if (value instanceof Integer) {
            return (Integer) value;
        }

        return null;
    }

    private void showProfile(
            HttpServletRequest request,
            HttpServletResponse response,
            HttpSession session,
            String errorMessage,
            String successMessage)
            throws ServletException, IOException {

        Integer userId = getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        User user = userDao.getUser(userId);

        if (user == null) {
            session.invalidate();

            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        request.setAttribute("profileUser", user);

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
        }

        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
        }

        request.getRequestDispatcher("/profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            getLoggedInUserId(session) == null) {

            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        showProfile(
            request, response, session, null, null
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null ||
            getLoggedInUserId(session) == null) {

            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        Integer userId = getLoggedInUserId(session);
        User user = userDao.getUser(userId);

        if (user == null) {
            session.invalidate();

            response.sendRedirect(
                request.getContextPath() + "/login"
            );
            return;
        }

        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        username = username == null ? "" : username.trim();
        phone = phone == null ? "" : phone.trim();
        address = address == null ? "" : address.trim();

        if (username.length() < 2 || username.length() > 80) {
            showProfile(
                request, response, session,
                "Username must contain 2–80 characters.",
                null
            );
            return;
        }

        if (!phone.isEmpty()) {
            String digits = phone.replaceAll("\\D", "");

            if (!phone.matches("[+0-9 ().-]+") ||
                digits.length() < 10 ||
                digits.length() > 15) {

                showProfile(
                    request, response, session,
                    "Enter a valid phone number containing 10–15 digits.",
                    null
                );
                return;
            }
        }

        if (address.length() > 300) {
            showProfile(
                request, response, session,
                "Address cannot exceed 300 characters.",
                null
            );
            return;
        }

        user.setUsername(username);
        user.setPhone(phone);
        user.setAddress(address);

        try {
            userDao.updateUser(user);

            // Keep the session consistent with the updated profile.
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            showProfile(
                request, response, session,
                null,
                "Your profile has been updated successfully."
            );

        } catch (Exception e) {
            getServletContext().log(
                "Failed to update Tomato user profile.", e
            );

            showProfile(
                request, response, session,
                "Unable to update your profile. Please try again.",
                null
            );
        }
    }
}
