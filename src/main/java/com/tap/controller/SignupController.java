
package com.tap.controller;

import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

import com.tap.daoImpl.UserDaoImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("signup.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String username =
                req.getParameter("username");

        String email =
                req.getParameter("email");

        String phone =
                req.getParameter("phone");

        String password =
                req.getParameter("password");

        String confirmPassword =
                req.getParameter("confirmPassword");

        String address =
                req.getParameter("address");

        String terms =
                req.getParameter("terms");


        // =========================================
        // BASIC VALIDATION
        // =========================================

        if (username == null ||
            username.trim().isEmpty() ||

            email == null ||
            email.trim().isEmpty() ||

            phone == null ||
            phone.trim().isEmpty() ||

            password == null ||
            password.trim().isEmpty() ||

            confirmPassword == null ||
            confirmPassword.trim().isEmpty() ||

            address == null ||
            address.trim().isEmpty()) {

            req.setAttribute(
                    "signupError",
                    "Please fill in all the required fields."
            );

            req.getRequestDispatcher(
                    "signup.jsp"
            ).forward(req, resp);

            return;
        }


        // =========================================
        // TERMS CHECK
        // =========================================

        if (terms == null) {

            req.setAttribute(
                    "signupError",
                    "Please accept the Terms & Conditions."
            );

            req.getRequestDispatcher(
                    "signup.jsp"
            ).forward(req, resp);

            return;
        }


        // =========================================
        // PASSWORD CHECK
        // =========================================

        if (!password.equals(confirmPassword)) {

            req.setAttribute(
                    "signupError",
                    "Passwords do not match."
            );

            req.getRequestDispatcher(
                    "signup.jsp"
            ).forward(req, resp);

            return;
        }


        // =========================================
        // DAO
        // =========================================

        UserDaoImpl userDao =
                new UserDaoImpl();


        // =========================================
        // CHECK EXISTING EMAIL
        // =========================================

        User existingUser =
                userDao.getUserByEmail(
                        email.trim()
                );

        if (existingUser != null) {

            req.setAttribute(
                    "signupError",
                    "An account with this email already exists."
            );

            req.getRequestDispatcher(
                    "signup.jsp"
            ).forward(req, resp);

            return;
        }


        // =========================================
        // CREATE USER
        // =========================================

        User user =
                new User();

        user.setUsername(
                username.trim()
        );

        String en_password = BCrypt.hashpw(password, BCrypt.gensalt());
        
        user.setPassword(
                en_password
        );

        user.setEmail(
                email.trim()
        );

        user.setPhone(
                phone.trim()
        );

        // IMPORTANT:
        // Save the address entered by the user.
        user.setAddress(
                address.trim()
        );

        user.setRole(
                "CUSTOMER"
        );


        // =========================================
        // INSERT USER
        // =========================================

        userDao.addUser(user);


        // =========================================
        // VERIFY INSERTION
        // =========================================

        User savedUser =
                userDao.getUserByEmail(
                        email.trim()
                );

        if (savedUser == null) {

            req.setAttribute(
                    "signupError",
                    "Signup failed. User details could not be saved."
            );

            req.getRequestDispatcher(
                    "signup.jsp"
            ).forward(req, resp);

            return;
        }


        // =========================================
        // AUTOMATIC LOGIN
        // =========================================

        HttpSession session =
                req.getSession();

        session.setAttribute(
                "loggedInUser",
                savedUser
        );

        session.setAttribute(
                "userId",
                savedUser.getUserId()
        );

        session.setAttribute(
                "username",
                savedUser.getUsername()
        );

        session.setAttribute(
                "role",
                savedUser.getRole()
        );


        // =========================================
        // REDIRECT TO RESTAURANT PAGE
        // =========================================

        resp.sendRedirect(
                req.getContextPath()
                + "/restaurant"
        );
    }
}