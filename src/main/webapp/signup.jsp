
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

    <title>TOMATO | Create Account</title>

    <link rel="preconnect"
        href="https://fonts.googleapis.com">

    <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/signup.css">

</head>

<body>

<div class="signup-page">

    <!-- =========================================
         LEFT SIDE
    ========================================== -->

    <section class="signup-left">

        <!-- Decorative circles -->

        <div class="bg-circle circle-one"></div>
        <div class="bg-circle circle-two"></div>
        <div class="bg-circle circle-three"></div>


        <!-- Floating food decorations -->

        <div class="floating-food food-pizza">
            🍕
        </div>

        <div class="floating-food food-cupcake">
            🧁
        </div>

        <div class="floating-food food-burger">
            🍔
        </div>

        <div class="floating-food food-donut">
            🍩
        </div>

        <div class="floating-food food-drink">
            🥤
        </div>

        <div class="floating-food food-cake">
            🍰
        </div>

        <div class="floating-food food-strawberry">
            🍓
        </div>

        <div class="floating-food food-fries">
            🍟
        </div>

        <div class="floating-food food-heart">
            💗
        </div>

        <div class="floating-food food-bowl">
            🍜
        </div>


        <!-- Logo -->

        <div class="brand-area">

            <div class="brand-tomatoes">
                🍅 🍅
            </div>

            <div class="brand-name">
                TOMATO
            </div>

        </div>


        <!-- Main heading -->

        <div class="hero-content">

            <h1>
                Good food.
                <span>Good mood.</span>
                <b>♥</b>
            </h1>

            <p>
                Discover delicious food, cute little moments
                and your favourite restaurants all in one place.
            </p>

        </div>


        <!-- Food cards -->

        <div class="food-collage">

            <!-- Pizza -->

            <div class="food-card pizza-card">

                <img
                    src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=700&q=85"
                    alt="Pizza">

                <div class="food-label">
                    🍕 Pizza
                </div>

            </div>


            <!-- Burger -->

            <div class="food-card burger-card">

                <img
                    src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=700&q=85"
                    alt="Burger">

                <div class="food-label">
                    🍔 Burger
                </div>

            </div>


            <!-- Cake -->

            <div class="food-card cake-card">

                <img
                    src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=700&q=85"
                    alt="Cake">

                <div class="food-label">
                    🍰 Cake
                </div>

            </div>


            <!-- Dosa -->

            <div class="food-card dosa-card">

                <img
                    src="https://images.unsplash.com/photo-1668236543090-82eba5ee5976?auto=format&fit=crop&w=700&q=85"
                    alt="Dosa">

                <div class="food-label">
                    🥘 Dosa
                </div>

            </div>

        </div>


        <!-- Bottom badge -->

        <div class="food-lovers">

            <span>💚</span>

            Made for food lovers

        </div>

    </section>



    <!-- =========================================
         RIGHT SIDE
    ========================================== -->

    <section class="signup-right">

        <div class="signup-container">


            <!-- Heading -->

            <div class="signup-heading">

                <h2>
                    Create your account
                </h2>

                <p>
                    Join TOMATO and discover something delicious.
                </p>

            </div>


            <!-- Error message -->

            <%
                String signupError =
                    (String) request.getAttribute("signupError");

                if (signupError != null) {
            %>

                <div class="signup-error">

                    <span>⚠</span>

                    <%= signupError %>

                </div>

            <%
                }
            %>


            <!-- Success message -->

            <%
                String signupSuccess =
                    (String) request.getAttribute("signupSuccess");

                if (signupSuccess != null) {
            %>

                <div class="signup-success">

                    <span>✓</span>

                    <%= signupSuccess %>

                </div>

            <%
                }
            %>


            <!-- Signup form -->

            <form
                action="${pageContext.request.contextPath}/signup"
                method="post"
                id="signupForm"
                novalidate>


                <!-- Full Name -->

                <div class="form-group">

                    <label for="username">
                        Full Name
                    </label>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="What should we call you?"
                        autocomplete="name">

                    <small
                        class="field-error"
                        id="usernameError">
                    </small>

                </div>


                <!-- Email -->

                <div class="form-group">

                    <label for="email">
                        Email Address
                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="Enter your email"
                        autocomplete="email">

                    <small
                        class="field-error"
                        id="emailError">
                    </small>

                </div>


                <!-- Mobile -->

                <div class="form-group">

                    <label for="phone">
                        Mobile Number
                    </label>

                    <div class="phone-input">

                        <span class="country-code">
                            IN&nbsp; +91
                        </span>

                        <input
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="10 digit mobile number"
                            maxlength="10"
                            autocomplete="tel">

                    </div>

                    <small
                        class="field-error"
                        id="phoneError">
                    </small>

                </div>


                <!-- Password -->

                <div class="form-group">

                    <label for="password">
                        Password
                    </label>

                    <div class="password-wrapper">

                        <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Create a strong password"
                            autocomplete="new-password">

                        <button
                            type="button"
                            class="show-password"
                            data-target="password">
                            Show
                        </button>

                    </div>

                    <small
                        class="field-error"
                        id="passwordError">
                    </small>

                </div>


                <!-- Confirm Password -->

                <div class="form-group">

                    <label for="confirmPassword">
                        Confirm Password
                    </label>

                    <div class="password-wrapper">

                        <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Enter your password again"
                            autocomplete="new-password">

                        <button
                            type="button"
                            class="show-password"
                            data-target="confirmPassword">
                            Show
                        </button>

                    </div>

                    <small
                        class="field-error"
                        id="confirmPasswordError">
                    </small>

                </div>


                <!-- Address -->

                <div class="form-group">

                    <label for="address">
                        Address
                    </label>

                    <textarea
                        id="address"
                        name="address"
                        placeholder="Enter your delivery address"
                        rows="3"
                        autocomplete="street-address"
                        required><%= request.getParameter("address") != null
                            ? request.getParameter("address")
                            : "" %></textarea>

                    <small
                        class="field-error"
                        id="addressError">
                    </small>

                </div>


                <!-- Terms -->

                <div class="terms-area">

                    <label class="terms-label">

                        <input
                            type="checkbox"
                            id="terms"
                            name="terms">

                        <span class="custom-checkbox"></span>

                        <span class="terms-text">

                            I agree to the

                            <a href="#">
                                Terms &amp; Conditions
                            </a>

                            and

                            <a href="#">
                                Privacy Policy
                            </a>

                        </span>

                    </label>

                    <small
                        class="field-error"
                        id="termsError">
                    </small>

                </div>


                <!-- Submit -->

                <button
                    type="submit"
                    class="create-account-btn">

                    <span>
                        Create Account
                    </span>

                    <span class="btn-tomato">
                        🍅
                    </span>

                </button>

            </form>


            <!-- Login -->

            <div class="login-link">

                Already have an account?

                <a
                    href="${pageContext.request.contextPath}/login">
                    Login
                </a>

            </div>

        </div>

    </section>

</div>


<script
    src="${pageContext.request.contextPath}/signup.js">
</script>

</body>
</html>
