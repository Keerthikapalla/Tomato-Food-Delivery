
package com.tap.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tap.dao.PasswordResetOtpDao;
import com.tap.model.PasswordResetOtp;
import com.tap.util.DBConnection;

public class PasswordResetOtpDaoImpl
        implements PasswordResetOtpDao {

    private static final String SAVE_OTP_QUERY =
            "INSERT INTO password_reset_otps "
            + "(userId, otp_hash, expires_at, attempts, used) "
            + "VALUES (?, ?, ?, 0, FALSE)";

    private static final String GET_LATEST_OTP_QUERY =
            "SELECT id, userId, otp_hash, expires_at, "
            + "attempts, used, created_at "
            + "FROM password_reset_otps "
            + "WHERE userId = ? AND used = FALSE "
            + "ORDER BY created_at DESC, id DESC LIMIT 1";

    private static final String INCREMENT_ATTEMPTS_QUERY =
            "UPDATE password_reset_otps "
            + "SET attempts = attempts + 1 "
            + "WHERE id = ? AND used = FALSE AND attempts < 5";

    private static final String MARK_USED_QUERY =
            "UPDATE password_reset_otps "
            + "SET used = TRUE "
            + "WHERE id = ? AND used = FALSE";

    private static final String INVALIDATE_UNUSED_QUERY =
            "UPDATE password_reset_otps "
            + "SET used = TRUE "
            + "WHERE userId = ? AND used = FALSE";


    // =========================================================
    // SAVE OTP
    // =========================================================

    @Override
    public boolean saveOtp(PasswordResetOtp otp) {

        if (otp == null
                || otp.getUserId() <= 0
                || otp.getOtpHash() == null
                || otp.getOtpHash().trim().isEmpty()
                || otp.getExpiresAt() == null) {
            return false;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(SAVE_OTP_QUERY)) {

            pstmt.setInt(1, otp.getUserId());
            pstmt.setString(2, otp.getOtpHash());
            pstmt.setTimestamp(3, otp.getExpiresAt());

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("Error saving password reset OTP.");
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // GET LATEST UNUSED OTP
    // =========================================================

    @Override
    public PasswordResetOtp getLatestUnusedOtp(int userId) {

        if (userId <= 0) {
            return null;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return null;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(
                             GET_LATEST_OTP_QUERY)) {

            pstmt.setInt(1, userId);

            try (ResultSet res = pstmt.executeQuery()) {

                if (res.next()) {

                    PasswordResetOtp otp =
                            new PasswordResetOtp();

                    otp.setId(res.getInt("id"));
                    otp.setUserId(res.getInt("userId"));
                    otp.setOtpHash(res.getString("otp_hash"));
                    otp.setExpiresAt(res.getTimestamp("expires_at"));
                    otp.setAttempts(res.getInt("attempts"));
                    otp.setUsed(res.getBoolean("used"));
                    otp.setCreatedAt(res.getTimestamp("created_at"));

                    return otp;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving password reset OTP.");
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // INCREMENT FAILED ATTEMPTS
    // =========================================================

    @Override
    public boolean incrementAttempts(int otpId) {

        if (otpId <= 0) {
            return false;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(
                             INCREMENT_ATTEMPTS_QUERY)) {

            pstmt.setInt(1, otpId);

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("Error incrementing OTP attempts.");
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // MARK OTP AS USED
    // =========================================================

    @Override
    public boolean markOtpAsUsed(int otpId) {

        if (otpId <= 0) {
            return false;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(MARK_USED_QUERY)) {

            pstmt.setInt(1, otpId);

            return pstmt.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("Error marking OTP as used.");
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // INVALIDATE EARLIER OTP RECORDS
    // =========================================================

    @Override
    public boolean invalidateUnusedOtps(int userId) {

        if (userId <= 0) {
            return false;
        }

        Connection connection = DBConnection.getConnection();

        if (connection == null) {
            return false;
        }

        try (PreparedStatement pstmt =
                     connection.prepareStatement(
                             INVALIDATE_UNUSED_QUERY)) {

            pstmt.setInt(1, userId);

            // Success includes the case where there were no old OTPs.
            pstmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.err.println("Error invalidating previous OTPs.");
            e.printStackTrace();
            return false;
        }
    }
}
