
package com.tap.dao;

import com.tap.model.PasswordResetOtp;

public interface PasswordResetOtpDao {

    // Save a new OTP hash and its expiry time.
    boolean saveOtp(PasswordResetOtp otp);

    // Retrieve the latest unused OTP record for a user.
    PasswordResetOtp getLatestUnusedOtp(int userId);

    // Increment failed verification attempts.
    boolean incrementAttempts(int otpId);

    // Mark an OTP as used.
    boolean markOtpAsUsed(int otpId);

    // Invalidate earlier unused OTPs for a user.
    boolean invalidateUnusedOtps(int userId);
}
