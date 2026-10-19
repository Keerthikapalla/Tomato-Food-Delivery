
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

@WebServlet("/theme")
public class ThemeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final UserDaoImpl userDao = new UserDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-store");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            writeJson(response, HttpServletResponse.SC_UNAUTHORIZED,
                    "{\"success\":false,"
                    + "\"message\":\"Please log in first.\"}");
            return;
        }

        int userId;

        try {
            Object sessionUserId = session.getAttribute("userId");

            if (sessionUserId instanceof Number) {
                userId = ((Number) sessionUserId).intValue();
            } else {
                userId = Integer.parseInt(sessionUserId.toString());
            }

        } catch (NumberFormatException e) {
            writeJson(response, HttpServletResponse.SC_UNAUTHORIZED,
                    "{\"success\":false,"
                    + "\"message\":\"Invalid user session.\"}");
            return;
        }

        if (userId <= 0) {
            writeJson(response, HttpServletResponse.SC_UNAUTHORIZED,
                    "{\"success\":false,"
                    + "\"message\":\"Invalid user session.\"}");
            return;
        }

        String theme = request.getParameter("theme");

        if (theme == null) {
            writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    "{\"success\":false,"
                    + "\"message\":\"Theme is required.\"}");
            return;
        }

        theme = theme.trim().toLowerCase();

        if (!"light".equals(theme) && !"dark".equals(theme)) {
            writeJson(response, HttpServletResponse.SC_BAD_REQUEST,
                    "{\"success\":false,"
                    + "\"message\":\"Invalid theme.\"}");
            return;
        }

        boolean updated = userDao.updateTheme(userId, theme);

        if (!updated) {
            writeJson(response,
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "{\"success\":false,"
                    + "\"message\":\"Could not save theme.\"}");
            return;
        }

        Object loggedInObject = session.getAttribute("loggedInUser");

        if (loggedInObject instanceof User) {
            User loggedInUser = (User) loggedInObject;
            loggedInUser.setTheme(theme);
            session.setAttribute("loggedInUser", loggedInUser);
        }

        session.setAttribute("theme", theme);

        writeJson(response, HttpServletResponse.SC_OK,
                "{\"success\":true,\"theme\":\"" + theme + "\"}");
    }

    private void writeJson(HttpServletResponse response,
                           int status,
                           String json) throws IOException {

        response.setStatus(status);
        response.getWriter().write(json);
    }
}
