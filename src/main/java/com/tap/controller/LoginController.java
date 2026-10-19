package com.tap.controller;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("login.jsp")
           .forward(req, resp);
    }


    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String email =
                req.getParameter("email");

        String password =
                req.getParameter("password");


        if (email == null ||
            email.trim().isEmpty() ||
            password == null ||
            password.trim().isEmpty()) {

            req.setAttribute(
                    "loginError",
                    "Please enter your email and password."
            );

            req.getRequestDispatcher("login.jsp")
               .forward(req, resp);

            return;
        }


        UserDaoImpl userDao =
                new UserDaoImpl();

        User user =
                userDao.getUserByEmail(
                        email.trim()
                );


        String en_password = BCrypt.hashpw(password, BCrypt.gensalt());
        
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            HttpSession session =
                    req.getSession();

            session.setAttribute(
                    "loggedInUser",
                    user
            );

            session.setAttribute(
                    "userId",
                    user.getUserId()
            );

            session.setAttribute(
                    "username",
                    user.getUsername()
            );

            session.setAttribute(
                    "role",
                    user.getRole()
            );


            resp.sendRedirect(
                    req.getContextPath()
                    + "/restaurant"
            );

        } else {

            req.setAttribute(
                    "loginError",
                    "Invalid email or password."
            );

            req.getRequestDispatcher("login.jsp")
               .forward(req, resp);
        }
    }
}