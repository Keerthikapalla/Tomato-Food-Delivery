<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    String contextPath = request.getContextPath();

    String stage = (String) request.getAttribute("stage");
    if (stage == null) {
        stage = "email";
    }

    String message = (String) request.getAttribute("message");
    Boolean success = (Boolean) request.getAttribute("success");
    boolean passwordResetSuccess = Boolean.TRUE.equals(success);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>TOMATO | Forgot Password</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --tomato: #e52b2b;
            --tomato-dark: #c91f1f;
            --green: #438b35;
            --cream: #fffaf2;
            --text: #29251f;
            --muted: #77716a;
            --white: #ffffff;
        }

        body {
            min-height: 100vh;
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            color: var(--text);
            background:
                radial-gradient(circle at 10% 15%,
                    rgba(229, 43, 43, 0.10), transparent 28%),
                radial-gradient(circle at 90% 85%,
                    rgba(67, 139, 53, 0.12), transparent 30%),
                linear-gradient(135deg, #fffaf2, #fff1e4);
        }

        .reset-card {
            width: 100%;
            max-width: 445px;
            padding: 38px 34px;
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid rgba(229, 43, 43, 0.10);
            border-radius: 28px;
            box-shadow: 0 20px 60px rgba(79, 47, 25, 0.12);
            animation: cardAppear 0.5s ease both;
        }

        @keyframes cardAppear {
            from {
                opacity: 0;
                transform: translateY(18px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 9px;
            margin-bottom: 28px;
            color: var(--tomato);
            font-size: 28px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .logo-icon {
            font-size: 34px;
            line-height: 1;
        }

        .eyebrow {
            margin-bottom: 8px;
            color: var(--green);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-align: center;
            text-transform: uppercase;
        }

        h1 {
            margin-bottom: 10px;
            color: var(--text);
            font-size: 27px;
            font-weight: 800;
            line-height: 1.3;
            text-align: center;
        }

        .description {
            margin-bottom: 25px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.8;
            text-align: center;
        }

        .message {
            margin-bottom: 20px;
            padding: 13px 14px;
            border-radius: 12px;
            background: #fff5e9;
            border: 1px solid #f3dfc9;
            color: #79532d;
            font-size: 12px;
            line-height: 1.7;
            overflow-wrap: anywhere;
        }

        .message.success {
            background: #eff9eb;
            border-color: #d1e9c7;
            color: #2f7028;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #39332e;
            font-size: 12px;
            font-weight: 600;
        }

        input {
            display: block;
            width: 100%;
            min-height: 49px;
            padding: 13px 15px;
            border: 1px solid #e8dfd5;
            border-radius: 13px;
            outline: none;
            background: #fffdfa;
            color: var(--text);
            font-family: inherit;
            font-size: 13px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus {
            border-color: var(--tomato);
            box-shadow: 0 0 0 4px rgba(229, 43, 43, 0.09);
        }

        input::placeholder {
            color: #aaa29a;
        }

        .primary-button {
            display: block;
            width: 100%;
            min-height: 49px;
            margin-top: 8px;
            border: none;
            border-radius: 14px;
            background: var(--tomato);
            color: var(--white);
            font-family: inherit;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(229, 43, 43, 0.19);
            transition: background 0.2s, transform 0.2s;
        }

        .primary-button:hover {
            background: var(--tomato-dark);
            transform: translateY(-1px);
        }

        .back-link {
            display: block;
            margin-top: 23px;
            color: var(--green);
            font-size: 12px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
        }

        .back-link:hover {
            color: var(--tomato);
        }

        .security-note {
            margin-top: 18px;
            color: #989087;
            font-size: 10px;
            line-height: 1.7;
            text-align: center;
        }

        @media (max-width: 480px) {
            body {
                padding: 15px;
            }

            .reset-card {
                padding: 30px 22px;
                border-radius: 23px;
            }

            h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

    <main class="reset-card">

        <div class="logo">
            <span class="logo-icon">🍅</span>
            <span>TOMATO</span>
        </div>

        <% if ("email".equals(stage)) { %>

            <div class="eyebrow">Account security</div>

            <h1>Forgot Password?</h1>

            <p class="description">
                Don't worry! Enter your registered email address
                and we'll help you reset your password.
            </p>

        <% } else if ("otp".equals(stage)) { %>

            <div class="eyebrow">Step 1 of 2</div>

            <h1>Verify Your OTP</h1>

            <p class="description">
                Enter the six-digit OTP sent to your email.
                It is valid for five minutes.
            </p>

        <% } else if ("password".equals(stage)) { %>

            <div class="eyebrow">Almost there</div>

            <h1>Create New Password</h1>

            <p class="description">
                Your OTP has been verified. Choose a new password
                to secure your TOMATO account.
            </p>

        <% } %>

        <% if (message != null && !message.trim().isEmpty()) { %>
            <div class="message <%= passwordResetSuccess ? "success" : "" %>">
                <%= message %>
            </div>
        <% } %>

        <% if ("email".equals(stage)) { %>

            <form action="<%= contextPath %>/forgot-password"
                  method="post">

                <input type="hidden" name="action" value="requestOtp">

                <div class="form-group">
                    <label for="email">Registered Email Address</label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your registered email"
                        autocomplete="email"
                        maxlength="254"
                        required>
                </div>

                <button type="submit" class="primary-button">
                    Send OTP
                </button>

            </form>

        <% } else if ("otp".equals(stage)) { %>

            <form action="<%= contextPath %>/forgot-password"
                  method="post">

                <input type="hidden" name="action" value="verifyOtp">

                <div class="form-group">
                    <label for="otp">Six-Digit OTP</label>

                    <input
                        type="text"
                        id="otp"
                        name="otp"
                        placeholder="Enter your 6-digit OTP"
                        inputmode="numeric"
                        pattern="[0-9]{6}"
                        minlength="6"
                        maxlength="6"
                        autocomplete="one-time-code"
                        required>
                </div>

                <button type="submit" class="primary-button">
                    Verify OTP
                </button>

            </form>

            <form action="<%= contextPath %>/forgotPassword"
                  method="post">

                <input type="hidden" name="action" value="requestOtp">

                <input type="hidden" name="email"
                       value="<%= request.getSession(false) != null
                           && request.getSession(false).getAttribute("resetEmail") != null
                           ? request.getSession(false).getAttribute("resetEmail")
                           : "" %>">

                <button type="submit"
                        class="primary-button"
                        style="margin-top: 12px; background: var(--green); box-shadow: none;">
                    Send a New OTP
                </button>

            </form>

        <% } else if ("password".equals(stage)) { %>

            <form action="<%= contextPath %>/forgot-password"
                  method="post">

                <input type="hidden" name="action" value="resetPassword">

                <div class="form-group">
                    <label for="newPassword">New Password</label>

                    <input
                        type="password"
                        id="newPassword"
                        name="newPassword"
                        placeholder="Create a new password"
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password"
                        required>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>

                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        placeholder="Re-enter your new password"
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password"
                        required>
                </div>

                <button type="submit" class="primary-button">
                    Reset Password
                </button>

            </form>

        <% } %>

        <a class="back-link" href="<%= contextPath %>/login">
            ← Back to Login
        </a>

        <div class="security-note">
            🔒 Your account security matters to us.
            Never share your OTP with anyone.
        </div>

    </main>

</body>
</html>