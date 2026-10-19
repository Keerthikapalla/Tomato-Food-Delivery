package com.tap.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.dao.UserDao;
import com.tap.dao.PasswordResetOtpDao;
import com.tap.daoImpl.UserDaoImpl;
import com.tap.daoImpl.PasswordResetOtpDaoImpl;
import com.tap.model.User;
import com.tap.model.PasswordResetOtp;
import com.tap.util.MailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int OTP_VALIDITY_MINUTES = 5;
    private static final int MAX_OTP_ATTEMPTS = 5;

    private final UserDao userDao = new UserDaoImpl();
    private final PasswordResetOtpDao otpDao = new PasswordResetOtpDaoImpl();

    private final SecureRandom secureRandom = new SecureRandom();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            session.removeAttribute("resetEmail");
            session.removeAttribute("verifiedResetUserId");
            session.removeAttribute("verifiedResetOtpId");
        }

        request.setAttribute("stage", "email");
        request.getRequestDispatcher("/forgotPassword.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            action = "requestOtp";
        }

        switch (action) {
            case "requestOtp":
                requestOtp(request, response);
                break;

            case "verifyOtp":
                verifyOtp(request, response);
                break;

            case "resetPassword":
                resetPassword(request, response);
                break;

            default:
                request.setAttribute("stage", "email");
                request.setAttribute("message",
                        "Invalid request. Please try again.");
                request.getRequestDispatcher("/forgotPassword.jsp")
                       .forward(request, response);
                break;
        }
    }

    private void requestOtp(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()
                || !email.trim().matches(
                    "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

            request.setAttribute("stage", "email");
            request.setAttribute("message",
                    "Please enter a valid email address.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        email = email.trim().toLowerCase();

        HttpSession session = request.getSession();

        // Clear any previous reset verification from this session.
        session.removeAttribute("verifiedResetUserId");
        session.removeAttribute("verifiedResetOtpId");

        // Keep the email in the session for the next stages.
        session.setAttribute("resetEmail", email);

        User user = userDao.getUserByEmail(email);

        /*
         * Use the same outward response for registered and
         * unregistered email addresses to avoid exposing accounts.
         */
        String message =
                "If an account exists for that email, an OTP will be sent. "
              + "Please check your inbox and Spam folder.";

        if (user != null) {
            int userId = user.getUserId();

            // Invalidate previously unused OTPs.
            otpDao.invalidateUnusedOtps(userId);

            int otpNumber = 100000 + secureRandom.nextInt(900000);
            String otp = String.valueOf(otpNumber);

            String otpHash = BCrypt.hashpw(otp, BCrypt.gensalt(12));

            long expiryMillis = System.currentTimeMillis()
                    + (OTP_VALIDITY_MINUTES * 60L * 1000L);

            PasswordResetOtp resetOtp = new PasswordResetOtp();
            resetOtp.setUserId(userId);
            resetOtp.setOtpHash(otpHash);
            resetOtp.setExpiresAt(new Timestamp(expiryMillis));
            resetOtp.setAttempts(0);
            resetOtp.setUsed(false);

            boolean saved = otpDao.saveOtp(resetOtp);

            if (saved) {
                try {
                    String subject = "TOMATO - Password Reset OTP";

                    String body =
                            "Hello " + user.getUsername() + ",\n\n"
                          + "Your TOMATO password-reset OTP is: " + otp + "\n\n"
                          + "This OTP expires in 5 minutes and can be used "
                          + "only once.\n"
                          + "If you did not request a password reset, "
                          + "please ignore this email.\n\n"
                          + "Regards,\nTOMATO Team";

                    MailUtil.sendEmail(email, subject, body);

                } catch (Exception e) {
                    otpDao.invalidateUnusedOtps(userId);

                    message =
                            "We couldn't send the OTP right now. "
                          + "Please try again later.";
                }
            } else {
                message =
                        "We couldn't process your request right now. "
                      + "Please try again later.";
            }
        }

        /*
         * Always display the OTP stage after a syntactically valid
         * email is submitted, so the response doesn't reveal whether
         * the email is registered.
         */
        request.setAttribute("stage", "otp");
        request.setAttribute("email", email);
        request.setAttribute("message", message);

        request.getRequestDispatcher("/forgotPassword.jsp")
               .forward(request, response);
    }

    private void verifyOtp(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("resetEmail") == null) {

            request.setAttribute("stage", "email");
            request.setAttribute("message",
                    "Your reset session has expired. Please start again.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        String email = (String) session.getAttribute("resetEmail");
        String enteredOtp = request.getParameter("otp");

        if (enteredOtp == null
                || !enteredOtp.trim().matches("\\d{6}")) {

            request.setAttribute("stage", "otp");
            request.setAttribute("email", email);
            request.setAttribute("message",
                    "Enter the six-digit OTP sent to your email.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        User user = userDao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("stage", "otp");
            request.setAttribute("email", email);
            request.setAttribute("message",
                    "The OTP is invalid or expired. Please request a new one.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        PasswordResetOtp savedOtp =
                otpDao.getLatestUnusedOtp(user.getUserId());

        if (savedOtp == null
                || savedOtp.getAttempts() >= MAX_OTP_ATTEMPTS
                || savedOtp.getExpiresAt() == null
                || !savedOtp.getExpiresAt().after(
                        new Timestamp(System.currentTimeMillis()))) {

            request.setAttribute("stage", "otp");
            request.setAttribute("email", email);
            request.setAttribute("message",
                    "The OTP is invalid or expired. Please request a new one.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        boolean matches;

        try {
            matches = BCrypt.checkpw(
                    enteredOtp.trim(), savedOtp.getOtpHash());
        } catch (IllegalArgumentException e) {
            matches = false;
        }

        if (!matches) {
            otpDao.incrementAttempts(savedOtp.getId());

            request.setAttribute("stage", "otp");
            request.setAttribute("email", email);
            request.setAttribute("message",
                    "Incorrect OTP. Please check it and try again. "
                  + "A maximum of five attempts is allowed.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        // Record verification on the server, not in a client-side field.
        session.setAttribute("verifiedResetUserId", user.getUserId());
        session.setAttribute("verifiedResetOtpId", savedOtp.getId());

        request.setAttribute("stage", "password");
        request.setAttribute("message",
                "OTP verified successfully. Set your new password.");

        request.getRequestDispatcher("/forgotPassword.jsp")
               .forward(request, response);
    }

    private void resetPassword(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("resetEmail") == null
                || session.getAttribute("verifiedResetUserId") == null
                || session.getAttribute("verifiedResetOtpId") == null) {

            request.setAttribute("stage", "email");
            request.setAttribute("message",
                    "Please verify your OTP before resetting your password.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        int userId = (Integer) session.getAttribute("verifiedResetUserId");
        int otpId = (Integer) session.getAttribute("verifiedResetOtpId");
        String email = (String) session.getAttribute("resetEmail");

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword == null || confirmPassword == null
                || newPassword.length() < 8
                || newPassword.length() > 72) {

            request.setAttribute("stage", "password");
            request.setAttribute("message",
                    "Your password must contain between 8 and 72 characters.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("stage", "password");
            request.setAttribute("message",
                    "The passwords do not match. Please try again.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        User user = userDao.getUserByEmail(email);

        if (user == null || user.getUserId() != userId) {
            clearResetSession(session);

            request.setAttribute("stage", "email");
            request.setAttribute("message",
                    "Your reset session is invalid. Please start again.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        /*
         * Recheck the OTP record when the password is submitted.
         * A previously verified OTP must still be the latest unused,
         * unexpired OTP and must belong to this user.
         */
        PasswordResetOtp savedOtp =
                otpDao.getLatestUnusedOtp(userId);

        if (savedOtp == null
                || savedOtp.getId() != otpId
                || savedOtp.getAttempts() >= MAX_OTP_ATTEMPTS
                || savedOtp.getExpiresAt() == null
                || !savedOtp.getExpiresAt().after(
                        new Timestamp(System.currentTimeMillis()))) {

            clearResetSession(session);

            request.setAttribute("stage", "email");
            request.setAttribute("message",
                    "Your OTP has expired or is no longer valid. "
                  + "Please request a new one.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        String hashedPassword =
                BCrypt.hashpw(newPassword, BCrypt.gensalt(12));

        boolean updated = userDao.updatePassword(userId, hashedPassword);

        if (!updated) {
            request.setAttribute("stage", "password");
            request.setAttribute("message",
                    "We couldn't update your password. Please try again.");
            request.getRequestDispatcher("/forgotPassword.jsp")
                   .forward(request, response);
            return;
        }

        // Invalidate the OTP after a successful password update.
        otpDao.markOtpAsUsed(otpId);
        otpDao.invalidateUnusedOtps(userId);

        clearResetSession(session);

        request.setAttribute("stage", "email");
        request.setAttribute("success", true);
        request.setAttribute("message",
                "Your password has been reset successfully. "
              + "You can now log in with your new password.");

        request.getRequestDispatcher("/forgotPassword.jsp")
               .forward(request, response);
    }

    private void clearResetSession(HttpSession session) {
        session.removeAttribute("resetEmail");
        session.removeAttribute("verifiedResetUserId");
        session.removeAttribute("verifiedResetOtpId");
    }
}