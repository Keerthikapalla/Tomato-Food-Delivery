/* =========================================================
   TOMATO LOGIN PAGE JAVASCRIPT
========================================================= */

document.addEventListener("DOMContentLoaded", function () {
    "use strict";

    const passwordInput = document.getElementById("password");
    const togglePassword = document.getElementById("togglePassword");
    const loginForm = document.getElementById("loginForm");
    const loginButton = document.getElementById("loginButton");
    const buttonLabel = loginButton
        ? loginButton.querySelector(".button-label")
        : null;

    const googleLoginButton = document.getElementById("googleLoginButton");
    const toast = document.getElementById("loginToast");
    const deliveryVideo = document.getElementById("deliveryVideo");

    let toastTimeout;

    /* =====================================================
       TOAST MESSAGE
    ===================================================== */

    function showToast(message) {
        if (!toast) {
            return;
        }

        toast.textContent = message;
        toast.classList.add("show");

        window.clearTimeout(toastTimeout);

        toastTimeout = window.setTimeout(function () {
            toast.classList.remove("show");
        }, 3200);
    }

    /* =====================================================
       SHOW / HIDE PASSWORD
    ===================================================== */

    if (passwordInput && togglePassword) {
        togglePassword.addEventListener("click", function () {
            const currentlyHidden = passwordInput.type === "password";

            passwordInput.type = currentlyHidden ? "text" : "password";

            togglePassword.setAttribute(
                "aria-label",
                currentlyHidden ? "Hide password" : "Show password"
            );

            togglePassword.setAttribute(
                "aria-pressed",
                currentlyHidden ? "true" : "false"
            );

            passwordInput.focus();
        });
    }

    /* =====================================================
       LOGIN FORM
       The form continues to submit to the existing servlet.
    ===================================================== */

    if (loginForm && loginButton) {
        loginForm.addEventListener("submit", function (event) {
            /*
             * Keep the browser's native required/email validation.
             * Do not prevent the normal POST to /login.
             */
            if (!loginForm.checkValidity()) {
                return;
            }

            if (loginButton.dataset.submitting === "true") {
                event.preventDefault();
                return;
            }

            loginButton.dataset.submitting = "true";
            loginButton.setAttribute("aria-busy", "true");

            if (buttonLabel) {
                buttonLabel.textContent = "Logging in...";
            }

            loginButton.disabled = true;
        });
    }

    /*
     * If the login page is rendered again with a server-side error,
     * the page starts fresh and the button is enabled by default.
     */

    /* =====================================================
       GOOGLE SIGN-IN
       OAuth is not connected in this project yet.
    ===================================================== */

    if (googleLoginButton) {
        googleLoginButton.addEventListener("click", function () {
            showToast(
                "Google sign-in isn't connected yet. Please log in using your email and password."
            );
        });
    }

    /* =====================================================
       VIDEO BACKGROUND
       Video source:
       /videos/tomato-delivery-rider.mp4
    ===================================================== */

    if (deliveryVideo) {
        deliveryVideo.muted = true;
        deliveryVideo.loop = true;
        deliveryVideo.playsInline = true;

        const playVideo = function () {
            const playPromise = deliveryVideo.play();

            if (playPromise && typeof playPromise.catch === "function") {
                playPromise.catch(function () {
                    /*
                     * Browsers may block autoplay in some situations.
                     * The page remains usable if the video cannot play.
                     */
                });
            }
        };

        if (deliveryVideo.readyState >= 2) {
            playVideo();
        } else {
            deliveryVideo.addEventListener("canplay", playVideo, {
                once: true
            });
        }

        deliveryVideo.addEventListener("error", function () {
            /*
             * A missing or unsupported MP4 leaves the cream CSS
             * background visible rather than breaking the login page.
             */
            deliveryVideo.style.display = "none";
        });
    }

    /* =====================================================
       SUBTLE PARALLAX FOR FLOATING FOOD DECORATIONS
       Disabled on touch screens and reduced-motion devices.
    ===================================================== */

    const loginPage = document.getElementById("loginPage");

    const prefersReducedMotion = window.matchMedia &&
        window.matchMedia("(prefers-reduced-motion: reduce)").matches;

    const supportsFinePointer = window.matchMedia &&
        window.matchMedia("(pointer: fine)").matches;

    if (loginPage && !prefersReducedMotion && supportsFinePointer) {
        let animationFrame = null;

        loginPage.addEventListener("pointermove", function (event) {
            if (animationFrame !== null) {
                window.cancelAnimationFrame(animationFrame);
            }

            animationFrame = window.requestAnimationFrame(function () {
                const x = (event.clientX / window.innerWidth - 0.5) * 2;
                const y = (event.clientY / window.innerHeight - 0.5) * 2;

                const foodItems = loginPage.querySelectorAll(".food");

                foodItems.forEach(function (item, index) {
                    const strength = 3 + (index % 4) * 1.5;

                    item.style.setProperty(
                        "--pointer-x",
                        (x * strength).toFixed(2) + "px"
                    );

                    item.style.setProperty(
                        "--pointer-y",
                        (y * strength).toFixed(2) + "px"
                    );
                });
            });
        });

        loginPage.addEventListener("pointerleave", function () {
            const foodItems = loginPage.querySelectorAll(".food");

            foodItems.forEach(function (item) {
                item.style.removeProperty("--pointer-x");
                item.style.removeProperty("--pointer-y");
            });
        });
    }
});
