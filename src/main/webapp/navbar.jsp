

<%@ page language="java" pageEncoding="UTF-8"
    contentType="text/html; charset=UTF-8" %>
<%@ page import="com.tap.model.Cart, com.tap.model.CartItem, com.tap.model.User" %>

<%
    String navbarContextPath = request.getContextPath();

    Object navbarLoggedInObject = session.getAttribute("loggedInUser");
    boolean navbarIsLoggedIn = navbarLoggedInObject instanceof User;

    String navbarTheme = "light";

    Object navbarSessionTheme = session.getAttribute("theme");

    if ("dark".equalsIgnoreCase(String.valueOf(navbarSessionTheme))) {
        navbarTheme = "dark";
    }

    if (navbarIsLoggedIn) {
        User navbarUser = (User) navbarLoggedInObject;
        String savedUserTheme = navbarUser.getTheme();

        if ("dark".equalsIgnoreCase(savedUserTheme)) {
            navbarTheme = "dark";
        } else if ("light".equalsIgnoreCase(savedUserTheme)) {
            navbarTheme = "light";
        }
    }

    int navbarCartCount = 0;
    Cart navbarCart = (Cart) session.getAttribute("cart");

    if (navbarCart != null && navbarCart.getItems() != null) {
        for (CartItem navbarItem : navbarCart.getItems().values()) {
            if (navbarItem != null) {
                navbarCartCount += navbarItem.getQuantity();
            }
        }
    }
%>

<!DOCTYPE html>
<script>
(function () {
    "use strict";

    var serverTheme = "<%= navbarTheme %>";
    var isLoggedIn = <%= navbarIsLoggedIn %>;
    var selectedTheme = serverTheme;

    /*
     * For guests, restore the saved browser preference.
     * For logged-in users, the database preference is authoritative.
     */
    if (!isLoggedIn) {
        try {
            var guestTheme = localStorage.getItem("tomatoTheme");

            if (guestTheme === "dark" || guestTheme === "light") {
                selectedTheme = guestTheme;
            }
        } catch (error) {
            // Use the server-provided theme if storage is unavailable.
        }
    }

    document.documentElement.dataset.theme =
        selectedTheme === "dark" ? "dark" : "light";
})();
</script>

<style>
    :root {
        color-scheme: light;

        --tomato-page-bg: #fffdf9;
        --tomato-surface: #ffffff;
        --tomato-text: #2b1b17;
        --tomato-muted: #77716c;
        --tomato-border: #efe4dc;
        --tomato-input-bg: #ffffff;
        --tomato-hover: #fff0eb;
        --tomato-nav-bg: rgba(255, 255, 255, .97);
        --tomato-toggle-bg: #fff8f1;

        --tomato-shadow: 0 4px 18px rgba(40, 30, 20, .06);
    }

    html[data-theme="light"] {
        color-scheme: light;

        --tomato-page-bg: #fffdf9;
        --tomato-surface: #ffffff;
        --tomato-text: #2b1b17;
        --tomato-muted: #77716c;
        --tomato-border: #efe4dc;
        --tomato-input-bg: #ffffff;
        --tomato-hover: #fff0eb;
        --tomato-nav-bg: rgba(255, 255, 255, .97);
        --tomato-toggle-bg: #fff8f1;

        --tomato-shadow: 0 4px 18px rgba(40, 30, 20, .06);
    }

    html[data-theme="dark"] {
        color-scheme: dark;

        --tomato-page-bg: #171a1f;
        --tomato-surface: #222730;
        --tomato-text: #f1f1f1;
        --tomato-muted: #b6aaa1;
        --tomato-border: #3b414c;
        --tomato-input-bg: #252a32;
        --tomato-hover: #383039;
        --tomato-nav-bg: #20242b;
        --tomato-toggle-bg: #303640;

        --tomato-shadow: 0 4px 18px rgba(0, 0, 0, .20);
    }

    html {
        min-height: 100%;
        background-color: var(--tomato-page-bg);
    }

    body {
        background-color: var(--tomato-page-bg);
        color: var(--tomato-text);
        transition:
            background-color .25s ease,
            color .25s ease;
    }

    /*
     * Shared navigation
     */
    .navbar,
    .navbar * {
        box-sizing: border-box;
    }

    .navbar {
        width: 100%;
        min-height: 76px;
        padding: 14px 6%;

        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 22px;

        position: relative;
        z-index: 1000;

        background: var(--tomato-nav-bg);
        color: var(--tomato-text);

        border-bottom: 1px solid var(--tomato-border);
        box-shadow: var(--tomato-shadow);

        font-family: 'Poppins', sans-serif;

        transition:
            background-color .25s ease,
            border-color .25s ease,
            box-shadow .25s ease;
    }

    .navbar .logo {
        display: flex;
        align-items: center;
        gap: 9px;

        color: #ed4438;

        font-size: 25px;
        font-weight: 800;
        letter-spacing: -.7px;

        white-space: nowrap;
        text-decoration: none;
    }

    .navbar .tomato-logo {
        font-size: 30px;
        line-height: 1;
    }

    .navbar .nav-links {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 23px;
    }

    .navbar .nav-links > a {
        display: inline-flex;
        align-items: center;
        gap: 5px;

        color: var(--tomato-text);

        font-size: 13px;
        font-weight: 600;

        text-decoration: none;
        white-space: nowrap;

        transition:
            color .2s ease,
            transform .2s ease;
    }

    .navbar .nav-links > a:hover {
        color: #ed4438;
        transform: translateY(-1px);
    }

    .navbar #cartCount {
        min-width: 20px;
        height: 20px;
        padding: 0 5px;

        display: inline-flex;
        align-items: center;
        justify-content: center;

        border-radius: 50px;
        background: #ed4438;
        color: #ffffff;

        font-size: 10px;
        font-weight: 700;
    }

    /*
     * Theme toggle
     */
    .navbar .theme-toggle {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;

        min-height: 38px;
        padding: 8px 12px;

        border: 1px solid var(--tomato-border);
        border-radius: 30px;

        background: var(--tomato-toggle-bg);
        color: var(--tomato-text);

        font-family: inherit;
        font-size: 12px;
        font-weight: 600;

        cursor: pointer;
        white-space: nowrap;

        transition:
            background-color .2s ease,
            color .2s ease,
            border-color .2s ease,
            transform .2s ease;
    }

    .navbar .theme-toggle:hover {
        border-color: #ed4438;
        transform: translateY(-1px);
    }

    .navbar .theme-toggle:focus-visible {
        outline: 2px solid #ed4438;
        outline-offset: 3px;
    }

    .navbar .theme-toggle:disabled {
        opacity: .7;
        cursor: wait;
    }

    .navbar .theme-icon {
        font-size: 17px;
        line-height: 1;
    }

    /*
     * Profile dropdown
     */
    
    ```css
/* Profile dropdown container */
.navbar .profile-container {
    position: relative;
    display: flex;
    align-items: center;
}

/* Profile icon */
.navbar .profile-image {
    width: 38px;
    height: 38px;
    display: flex;
    align-items: center;
    justify-content: center;

    background: #fff0e9;
    border: 1px solid #ffddd2;
    border-radius: 50%;

    font-size: 19px;
    text-decoration: none;
    cursor: pointer;
}

/* Dropdown menu */
.navbar .profile-dropdown {
    display: none;

    position: absolute;
    top: 100%;
    right: 0;

    min-width: 190px;
    padding: 10px;

    background: var(--tomato-surface, #ffffff);
    color: var(--tomato-text, #2b1b17);

    border: 1px solid var(--tomato-border, #efe4dc);
    border-radius: 13px;

    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);

    z-index: 2000;
}

/* Keep the dropdown open while moving the cursor into it */
.navbar .profile-container:hover .profile-dropdown,
.navbar .profile-container:focus-within .profile-dropdown,
.navbar .profile-dropdown:hover {
    display: block;
}

/* Dropdown links */
.navbar .profile-dropdown a {
    display: block;
    padding: 11px 12px;

    border-radius: 8px;

    color: var(--tomato-text, #2b1b17);
    font-size: 12px;
    font-weight: 500;
    text-decoration: none;

    transition: background-color 0.2s ease, color 0.2s ease;
}

.navbar .profile-dropdown a:hover {
    color: #ed4438;
    background: var(--tomato-hover, #fff0eb);
}

/* Logout link */
.navbar .profile-dropdown .logout {
    color: #d92d20;
    border-top: 1px solid var(--tomato-border, #efe4dc);
    margin-top: 4px;
    padding-top: 12px;
}

/* Dark mode */
html[data-theme="dark"] .navbar .profile-dropdown {
    background: var(--tomato-surface, #222730);
    border-color: var(--tomato-border, #3b414c);
}

html[data-theme="dark"] .navbar .profile-dropdown a {
    color: var(--tomato-text, #f1f1f1);
}

html[data-theme="dark"] .navbar .profile-dropdown a:hover {
    color: #ff766c;
    background: var(--tomato-hover, #383039);
}

html[data-theme="dark"] .navbar .profile-dropdown .logout {
    color: #ff8177;
}
```
    
    
    .navbar .profile-container:hover .profile-dropdown,
    .navbar .profile-container:focus-within .profile-dropdown {
        display: block;
    }

    .navbar .profile-dropdown a {
        display: block;
        padding: 10px 12px;

        border-radius: 8px;

        color: var(--tomato-text);

        font-size: 12px;
        font-weight: 500;
        text-decoration: none;
    }

    .navbar .profile-dropdown a:hover {
        color: #ed4438;
        background: var(--tomato-hover);
    }

    .navbar .profile-dropdown .logout {
        color: #d92d20;
        border-top: 1px solid var(--tomato-border);
        margin-top: 4px;
    }

    /*
     * Login link
     */
    .navbar .login-nav-link {
        padding: 10px 20px;

        color: #ffffff !important;
        background: #ed4438;

        border-radius: 10px;

        text-decoration: none;
        font-size: 13px;
        font-weight: 600;
    }

    .navbar .login-nav-link:hover {
        background: #d92d20;
    }

    /*
     * Shared dark-mode styles for form controls and common cards.
     * Individual page styles may need their own selectors as well.
     */
    html[data-theme="dark"] input,
    html[data-theme="dark"] textarea,
    html[data-theme="dark"] select {
        background-color: var(--tomato-input-bg);
        color: var(--tomato-text);
        border-color: var(--tomato-border);
    }

    html[data-theme="dark"] input::placeholder,
    html[data-theme="dark"] textarea::placeholder {
        color: #a9b0bb;
    }

    html[data-theme="dark"] option {
        background: var(--tomato-surface);
        color: var(--tomato-text);
    }

    html[data-theme="dark"] table {
        color: var(--tomato-text);
    }

    html[data-theme="dark"] .restaurant-card,
    html[data-theme="dark"] .restaurant-info,
    html[data-theme="dark"] .profile-card,
    html[data-theme="dark"] .cart-card,
    html[data-theme="dark"] .checkout-card,
    html[data-theme="dark"] .order-card,
    html[data-theme="dark"] .menu-card {
        background-color: var(--tomato-surface);
        color: var(--tomato-text);
        border-color: var(--tomato-border);
    }

    html[data-theme="dark"] .navbar {
        box-shadow: 0 4px 18px rgba(0, 0, 0, .20);
    }

    html[data-theme="dark"] .navbar .nav-links > a {
        color: var(--tomato-text);
    }

    html[data-theme="dark"] .navbar .nav-links > a:hover {
        color: #ff766c;
    }

    html[data-theme="dark"] .navbar .profile-image {
        background: #382a2b;
        border-color: #59403e;
    }

    html[data-theme="dark"] .navbar .profile-dropdown {
        background: var(--tomato-surface);
        border-color: var(--tomato-border);
    }

    html[data-theme="dark"] .navbar .profile-dropdown .logout {
        color: #ff8177;
    }

    /*
     * Responsive layout
     */
    @media (max-width: 850px) {
        .navbar {
            padding: 13px 4%;
            flex-wrap: wrap;
        }

        .navbar .nav-links {
            gap: 14px;
            flex-wrap: wrap;
        }
    }

    @media (max-width: 560px) {
        .navbar {
            gap: 12px;
        }

        .navbar .logo {
            font-size: 22px;
        }

        .navbar .tomato-logo {
            font-size: 26px;
        }

        .navbar .nav-links {
            width: 100%;
            justify-content: space-between;
            gap: 10px;
        }

        .navbar .nav-links > a {
            font-size: 11px;
        }

        .navbar .login-nav-link {
            padding: 8px 12px;
        }

        .navbar .theme-toggle {
            padding: 7px 9px;
            font-size: 11px;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .navbar,
        .navbar * {
            transition: none !important;
        }

        body {
            transition: none !important;
        }
    }
</style>

<header class="navbar">
    <a class="logo"
       href="<%= navbarContextPath %>/restaurant"
       aria-label="Go to Tomato home">
        <span class="tomato-logo">&#127813;</span>
        <span>TOMATO</span>
    </a>

    <nav class="nav-links" aria-label="Main navigation">
        <a href="<%= navbarContextPath %>/restaurant">&#127968; Home</a>

        <a href="<%= navbarContextPath %>/restaurant">&#127860; Restaurants</a>

        <a href="<%= navbarContextPath %>/orders">&#128230; Orders</a>

        <a href="<%= navbarContextPath %>/cart">
            &#128722; Cart
            <span id="cartCount"><%= navbarCartCount %></span>
        </a>

        <button type="button"
                class="theme-toggle"
                id="themeToggle"
                aria-label="Switch to dark theme"
                aria-pressed="false">
            <span class="theme-icon" id="themeIcon">🌙</span>
            <span id="themeLabel">Dark</span>
        </button>

        <% if (navbarIsLoggedIn) { %>
            <div class="profile-container">
                <a href="<%= navbarContextPath %>/profile"
                   class="profile-image"
                   aria-label="Open profile">&#128100;</a>

                <div class="profile-dropdown">
                    <a href="<%= navbarContextPath %>/profile">My Profile</a>
                    <a href="<%= navbarContextPath %>/favourites">Favourites</a>
                    <a href="<%= navbarContextPath %>/settings">Settings</a>
                    <a href="<%= navbarContextPath %>/logout" class="logout">Logout</a>
                </div>
            </div>
        <% } else { %>
            <a href="<%= navbarContextPath %>/login"
               class="login-nav-link">Login</a>
        <% } %>
    </nav>
</header>

<script>
(function () {
    "use strict";

    var contextPath = "<%= navbarContextPath %>";
    var isLoggedIn = <%= navbarIsLoggedIn %>;

    var toggle = document.getElementById("themeToggle");
    var icon = document.getElementById("themeIcon");
    var label = document.getElementById("themeLabel");

    if (!toggle || !icon || !label) {
        return;
    }

    function applyTheme(theme) {
        var validTheme = theme === "dark" ? "dark" : "light";
        var isDark = validTheme === "dark";

        document.documentElement.dataset.theme = validTheme;

        icon.textContent = isDark ? "☀️" : "🌙";
        label.textContent = isDark ? "Light" : "Dark";

        toggle.setAttribute("aria-pressed", String(isDark));
        toggle.setAttribute(
            "aria-label",
            isDark ? "Switch to light theme" : "Switch to dark theme"
        );
    }

    toggle.addEventListener("click", async function () {
        if (toggle.disabled) {
            return;
        }

        var previousTheme =
            document.documentElement.dataset.theme || "light";

        var newTheme =
            previousTheme === "dark" ? "light" : "dark";

        /*
         * Apply immediately so the page changes without waiting for the server.
         */
        applyTheme(newTheme);

        /*
         * Guests only need a browser preference.
         */
        if (!isLoggedIn) {
            try {
                localStorage.setItem("tomatoTheme", newTheme);
            } catch (error) {
                console.warn("Could not save guest theme preference:", error);
            }

            return;
        }

        /*
         * Logged-in users save their preference through the existing endpoint.
         */
        toggle.disabled = true;

        try {
            var response = await fetch(contextPath + "/theme", {
                method: "POST",
                headers: {
                    "Content-Type":
                        "application/x-www-form-urlencoded;charset=UTF-8",
                    "Accept": "application/json"
                },
                body: "theme=" + encodeURIComponent(newTheme),
                credentials: "same-origin"
            });

            var result = null;

            try {
                result = await response.json();
            } catch (parseError) {
                throw new Error(
                    "The theme endpoint did not return valid JSON."
                );
            }

            if (!response.ok || !result || result.success !== true) {
                throw new Error(
                    result && result.message
                        ? result.message
                        : "The server could not save the theme."
                );
            }

            /*
             * Keep the new theme active after a successful save.
             */
            try {
                localStorage.setItem("tomatoTheme", newTheme);
            } catch (storageError) {
                // The logged-in user's preference has been saved on the server.
            }

        } catch (error) {
            /*
             * Do not revert the visual theme.
             * Report the save problem for debugging.
             */
            console.error("Theme preference save failed:", error);

            alert(
                "Dark/light mode has changed, but the preference could not " +
                "be saved. It may not persist after reloading the page."
            );

        } finally {
            toggle.disabled = false;
        }
    });

    /*
     * Sync the toggle's icon and label with the theme selected at page load.
     */
    applyTheme(document.documentElement.dataset.theme || "light");
})();
</script>