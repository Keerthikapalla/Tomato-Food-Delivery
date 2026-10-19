
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
    String contextPath = request.getContextPath();
    String loginError = (String) request.getAttribute("loginError");
    String registeredMessage = (String) request.getAttribute("registeredMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | TOMATO</title>
    <meta name="theme-color" content="#fff8ef">
    <meta name="description"
          content="Login to TOMATO and get your favourite food delivered fresh.">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="<%= contextPath %>/login.css">
    <script src="<%= contextPath %>/login.js" defer></script>
</head>

<body>
<div class="login-page" id="loginPage">

    <!-- VIDEO BACKGROUND -->
    <div class="video-background" aria-hidden="true">
        <video class="delivery-video"
               id="deliveryVideo"
               autoplay muted loop playsinline
               preload="metadata"
               poster="<%= contextPath %>/images/tomato-delivery-poster.jpg">
            <source src="<%= contextPath %>/videos/tomato-delivery-rider.mp4"
                    type="video/mp4">
        </video>
        <div class="video-overlay"></div>
    </div>

    <!-- BACKGROUND DECORATIONS -->
    <div class="background-orb orb-one" aria-hidden="true"></div>
    <div class="background-orb orb-two" aria-hidden="true"></div>
    <div class="background-orb orb-three" aria-hidden="true"></div>

    <div class="floating-food" aria-hidden="true">
        <span class="food food-1">🍕</span>
        <span class="food food-2">🍓</span>
        <span class="food food-3">🍔</span>
        <span class="food food-4">🍟</span>
        <span class="food food-5">🥑</span>
        <span class="food food-6">🍰</span>
        <span class="food food-7">🍅</span>
        <span class="food food-8">🥤</span>
        <span class="food food-9">🍩</span>
        <span class="food food-10">🥗</span>
        <span class="food food-11">🍒</span>
        <span class="food food-12">🍉</span>
    </div>

    <!-- TOP NAVIGATION -->
    <header class="login-navbar">
        <a href="<%= contextPath %>/restaurant"
           class="brand-logo"
           aria-label="TOMATO home">
            <span class="brand-tomato">🍅</span>
            <span>TOMATO<span class="brand-dot">.</span></span>
        </a>

        <div class="nav-register">
            <span>New to TOMATO?</span>
            <a href="<%= contextPath %>/signup.jsp">
                Create account <span aria-hidden="true">↗</span>
            </a>
        </div>
    </header>

    <!-- CENTERED LOGIN CONTENT -->
    <main class="login-main">

        <section class="login-card" id="loginCard"
                 aria-labelledby="loginHeading">

            <div class="card-top-decoration" aria-hidden="true">
                <span></span><span></span><span></span>
            </div>

            <div class="card-brand">
                <span class="card-brand-icon">🍅</span>
                <strong>TOMATO<span>.</span></strong>
            </div>

            <div class="welcome-label">
                <span class="welcome-sparkle">✦</span>
                WELCOME BACK
                <span class="welcome-sparkle">✦</span>
            </div>

            <h1 id="loginHeading">Let's <span>Login!</span> 🍅</h1>

            <p class="login-subtitle">
                Your next favourite meal is waiting.
            </p>

            <% if (registeredMessage != null
                    && !registeredMessage.trim().isEmpty()) { %>
                <div class="success-message" role="status">
                    <span class="message-icon">✓</span>
                    <span><%= registeredMessage %></span>
                </div>
            <% } %>

            <% if (loginError != null
                    && !loginError.trim().isEmpty()) { %>
                <div class="error-message" role="alert">
                    <span class="message-icon">!</span>
                    <span><%= loginError %></span>
                </div>
            <% } %>

            <!-- LOGIN FORM -->
            <form id="loginForm"
                  action="<%= contextPath %>/login"
                  method="post"
                  autocomplete="off">

                <!-- EMAIL -->
                <div class="form-group">
                    <label for="email">Email address</label>

                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none">
                                <rect x="3" y="5" width="18" height="14"
                                      rx="3" stroke="currentColor"
                                      stroke-width="1.8"/>
                                <path d="m4 7 8 6 8-6"
                                      stroke="currentColor"
                                      stroke-width="1.8"
                                      stroke-linecap="round"
                                      stroke-linejoin="round"/>
                            </svg>
                        </span>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            placeholder="Enter your email address"
                            value=""
                            autocomplete="off"
                            autocapitalize="none"
                            spellcheck="false"
                            required>
                    </div>
                </div>

                <!-- PASSWORD -->
                <div class="form-group password-group">
                    <label for="password">Password</label>

                    <div class="input-shell">
                        <span class="input-icon" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none">
                                <rect x="5" y="10" width="14" height="11"
                                      rx="2.5" stroke="currentColor"
                                      stroke-width="1.8"/>
                                <path d="M8 10V7a4 4 0 0 1 8 0v3"
                                      stroke="currentColor"
                                      stroke-width="1.8"
                                      stroke-linecap="round"/>
                                <circle cx="12" cy="15" r="1.2"
                                        fill="currentColor"/>
                            </svg>
                        </span>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            value=""
                            autocomplete="new-password"
                            required>

                        <button
                            type="button"
                            class="toggle-password"
                            id="togglePassword"
                            aria-label="Show password"
                            aria-pressed="false">

                            <svg class="eye-open"
                                 viewBox="0 0 24 24" fill="none">
                                <path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"
                                      stroke="currentColor"
                                      stroke-width="1.8"
                                      stroke-linejoin="round"/>
                                <circle cx="12" cy="12" r="3"
                                        stroke="currentColor"
                                        stroke-width="1.8"/>
                            </svg>
                        </button>
                    </div>

                    <div class="password-options">
                        <span class="password-hint">Keep your account safe</span>

                        <a href="<%= contextPath %>/forgot-password"
                           class="forgot-link">
                            Forgot password?
                            <span aria-hidden="true">↗</span>
                        </a>
                    </div>
                </div>

                <!-- LOGIN BUTTON -->
                <button type="submit"
                        class="login-button"
                        id="loginButton">
                    <span class="button-tomato" aria-hidden="true">🍅</span>
                    <span class="button-label">Login to TOMATO</span>
                    <span class="button-arrow" aria-hidden="true">→</span>
                </button>
            </form>

            <div class="divider">
                <span></span>
                <p>OR CONTINUE WITH</p>
                <span></span>
            </div>

            <div class="social-options">
                <button type="button"
                        class="social-button"
                        id="googleLoginButton"
                        aria-describedby="googleLoginNote">
                    <span class="google-icon" aria-hidden="true">G</span>
                    Continue with Google
                </button>

                <p class="google-note" id="googleLoginNote">
                    Google sign-in isn't connected yet.
                </p>
            </div>

            <p class="signup-text">
                New to TOMATO?
                <a href="<%= contextPath %>/signup.jsp">
                    Create account <span aria-hidden="true">↗</span>
                </a>
            </p>

            <div class="card-footer">
                <span>🍅</span>
                Good food, happy moments.
                <span class="footer-heart">♡</span>
            </div>
        </section>

        <!-- DELIVERY BRAND MESSAGE -->
        <div class="delivery-caption">
            <span class="caption-icon">♡</span>
            <div>
                <strong>Happiness is a bite away!</strong>
                <small>Your favourite meals, delivered fresh with a little extra love.</small>
            </div>
            <span class="caption-sparkle">✦</span>
        </div>

    </main>

    <div class="toast-message"
         id="loginToast"
         role="status"
         aria-live="polite"></div>

</div>

<!-- Clear only initial page autofill; preserve user typing and form submission. -->
<script>
(function () {
    const email = document.getElementById("email");
    const password = document.getElementById("password");

    if (email) email.value = "";
    if (password) password.value = "";

    window.addEventListener("pageshow", function (event) {
        if (event.persisted) {
            if (email) email.value = "";
            if (password) password.value = "";
        }
    });
})();
</script>

</body>
</html>
