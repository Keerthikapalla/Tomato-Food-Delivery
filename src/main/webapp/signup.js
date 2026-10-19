/* =========================================================
   TOMATO SIGNUP PAGE
========================================================= */


document.addEventListener(
    "DOMContentLoaded",
    function () {


        /* =================================================
           ELEMENTS
        ================================================= */

        const signupForm =
            document.getElementById("signupForm");

        const username =
            document.getElementById("username");

        const email =
            document.getElementById("email");

        const phone =
            document.getElementById("phone");

        const password =
            document.getElementById("password");

        const confirmPassword =
            document.getElementById("confirmPassword");

        const terms =
            document.getElementById("terms");


        /* =================================================
           PASSWORD SHOW / HIDE
        ================================================= */

        const showButtons =
            document.querySelectorAll(".show-password");


        showButtons.forEach(
            function (button) {

                button.addEventListener(
                    "click",
                    function () {

                        const targetId =
                            button.getAttribute(
                                "data-target"
                            );

                        const target =
                            document.getElementById(
                                targetId
                            );


                        if (target.type === "password") {

                            target.type = "text";

                            button.textContent =
                                "Hide";

                        } else {

                            target.type = "password";

                            button.textContent =
                                "Show";
                        }

                    }
                );

            }
        );


        /* =================================================
           CLEAR ERROR
        ================================================= */

        function clearErrors() {

            document
                .querySelectorAll(".field-error")
                .forEach(
                    function (error) {
                        error.textContent = "";
                    }
                );


            document
                .querySelectorAll(".input-error")
                .forEach(
                    function (input) {
                        input.classList.remove(
                            "input-error"
                        );
                    }
                );

        }


        /* =================================================
           SHOW ERROR
        ================================================= */

        function showError(
            input,
            errorId,
            message
        ) {

            if (input) {

                input.classList.add(
                    "input-error"
                );

            }


            const errorElement =
                document.getElementById(
                    errorId
                );


            if (errorElement) {

                errorElement.textContent =
                    message;

            }

        }


        /* =================================================
           EMAIL VALIDATION
        ================================================= */

        function isValidEmail(value) {

            const emailPattern =
                /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            return emailPattern.test(value);

        }


        /* =================================================
           PHONE VALIDATION
        ================================================= */

        function isValidPhone(value) {

            return /^[6-9]\d{9}$/.test(value);

        }


        /* =================================================
           PASSWORD VALIDATION
        ================================================= */

        function isStrongPassword(value) {

            return (
                value.length >= 6 &&
                /[A-Za-z]/.test(value) &&
                /\d/.test(value)
            );

        }


        /* =================================================
           FORM SUBMIT
        ================================================= */

        signupForm.addEventListener(
            "submit",
            function (event) {


                clearErrors();


                let isValid = true;


                const usernameValue =
                    username.value.trim();

                const emailValue =
                    email.value.trim();

                const phoneValue =
                    phone.value.trim();

                const passwordValue =
                    password.value;

                const confirmPasswordValue =
                    confirmPassword.value;


                /* =========================================
                   USERNAME
                ========================================= */

                if (usernameValue.length < 2) {

                    showError(
                        username,
                        "usernameError",
                        "Please enter your full name."
                    );

                    isValid = false;
                }


                /* =========================================
                   EMAIL
                ========================================= */

                if (emailValue === "") {

                    showError(
                        email,
                        "emailError",
                        "Please enter your email address."
                    );

                    isValid = false;

                } else if (
                    !isValidEmail(emailValue)
                ) {

                    showError(
                        email,
                        "emailError",
                        "Please enter a valid email address."
                    );

                    isValid = false;
                }


                /* =========================================
                   PHONE
                ========================================= */

                if (phoneValue === "") {

                    showError(
                        phone,
                        "phoneError",
                        "Please enter your mobile number."
                    );

                    isValid = false;

                } else if (
                    !isValidPhone(phoneValue)
                ) {

                    showError(
                        phone,
                        "phoneError",
                        "Enter a valid 10 digit mobile number."
                    );

                    isValid = false;
                }


                /* =========================================
                   PASSWORD
                ========================================= */

                if (passwordValue === "") {

                    showError(
                        password,
                        "passwordError",
                        "Please create a password."
                    );

                    isValid = false;

                } else if (
                    !isStrongPassword(passwordValue)
                ) {

                    showError(
                        password,
                        "passwordError",
                        "Password must be at least 6 characters with a letter and number."
                    );

                    isValid = false;
                }


                /* =========================================
                   CONFIRM PASSWORD
                ========================================= */

                if (confirmPasswordValue === "") {

                    showError(
                        confirmPassword,
                        "confirmPasswordError",
                        "Please confirm your password."
                    );

                    isValid = false;

                } else if (
                    passwordValue !==
                    confirmPasswordValue
                ) {

                    showError(
                        confirmPassword,
                        "confirmPasswordError",
                        "Passwords do not match."
                    );

                    isValid = false;
                }


                /* =========================================
                   TERMS
                ========================================= */

                if (!terms.checked) {

                    const termsError =
                        document.getElementById(
                            "termsError"
                        );

                    termsError.textContent =
                        "Please accept the Terms & Conditions.";

                    isValid = false;
                }


                /* =========================================
                   STOP SUBMISSION
                ========================================= */

                if (!isValid) {

                    event.preventDefault();

                    return;
                }


                /* =========================================
                   BUTTON STATE
                ========================================= */

                const button =
                    signupForm.querySelector(
                        ".create-account-btn"
                    );


                if (button) {

                    button.disabled = true;

                    button.querySelector(
                        "span:first-child"
                    ).textContent =
                        "Creating Account...";

                }

            }
        );


        /* =================================================
           PHONE INPUT
        ================================================= */

        phone.addEventListener(
            "input",
            function () {

                this.value =
                    this.value.replace(
                        /\D/g,
                        ""
                    ).slice(0, 10);

            }
        );


        /* =================================================
           LIVE PASSWORD MATCH
        ================================================= */

        confirmPassword.addEventListener(
            "input",
            function () {

                if (
                    confirmPassword.value !== "" &&
                    confirmPassword.value !==
                    password.value
                ) {

                    showError(
                        confirmPassword,
                        "confirmPasswordError",
                        "Passwords do not match."
                    );

                } else {

                    confirmPassword.classList.remove(
                        "input-error"
                    );

                    document.getElementById(
                        "confirmPasswordError"
                    ).textContent = "";

                }

            }
        );


    }
);