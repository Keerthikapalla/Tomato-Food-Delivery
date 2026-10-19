
/* =========================================================
   TOMATO MENU PAGE
========================================================= */


/* =========================================================
   GLOBAL VARIABLES
========================================================= */

let lastScrollPosition = 0;
let tomatoClimberPosition = 20;
let scrollDirection = "down";
let scrollTimer = null;


/* =========================================================
   PAGE LOAD
========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    /* TOMATO OPENING ANIMATION */

    const transition = document.getElementById("tomatoTransition");

    setTimeout(function () {
        if (transition) {
            transition.classList.add("break");
        }

        playTomatoSound();
    }, 1100);

    setTimeout(function () {
        if (transition) {
            transition.classList.add("hide");
        }
    }, 2500);


    /* MENU SEARCH */

    initializeMenuSearch();


    /* TOMATO CLIMBER */

    initializeTomatoClimber();


    /* AJAX CART */

    initializeAjaxCart();

});


/* =========================================================
   TOMATO SPLASH SOUND
========================================================= */

function playTomatoSound() {

    try {
        const audio = new Audio("tomatoSplash.mp3");

        audio.volume = 0.85;
        audio.currentTime = 0;

        audio.play().catch(function (error) {
            console.log(
                "Tomato splash sound could not be played.",
                error
            );
        });

    } catch (error) {
        console.log("Tomato splash sound unavailable.");
    }

}


/* =========================================================
   TOMATO CLIMBER
========================================================= */

function initializeTomatoClimber() {

    const climber = document.getElementById("tomatoClimber");
    const tomato = document.getElementById("climbingTomato");
    const bookScrollArea = document.getElementById("bookScrollArea");

    if (!climber || !tomato || !bookScrollArea) {
        return;
    }

    tomatoClimberPosition = 20;
    tomato.style.top = tomatoClimberPosition + "px";

    lastScrollPosition = bookScrollArea.scrollTop;

    bookScrollArea.addEventListener("scroll", handleTomatoScroll, {
        passive: true
    });

    updateTomatoFromBookScroll();
    updateTomatoMessage();

}


/* =========================================================
   HANDLE INTERNAL BOOK SCROLL
========================================================= */

function handleTomatoScroll() {

    const tomato = document.getElementById("climbingTomato");
    const climber = document.getElementById("tomatoClimber");
    const bookScrollArea = document.getElementById("bookScrollArea");

    if (!tomato || !climber || !bookScrollArea) {
        return;
    }

    const currentScroll = bookScrollArea.scrollTop;

    if (currentScroll > lastScrollPosition) {
        scrollDirection = "down";
    } else if (currentScroll < lastScrollPosition) {
        scrollDirection = "up";
    }

    const scrollDifference = currentScroll - lastScrollPosition;
    const movement = scrollDifference * 0.12;

    tomatoClimberPosition += movement;

    const ropeHeight = climber.clientHeight;
    const tomatoHeight = tomato.offsetHeight;

    const minimumTop = 18;

    const maximumTop = Math.max(
        ropeHeight - tomatoHeight - 35,
        minimumTop
    );

    tomatoClimberPosition = Math.min(
        Math.max(tomatoClimberPosition, minimumTop),
        maximumTop
    );

    tomato.style.top = tomatoClimberPosition + "px";

    climber.classList.remove("scrolling-up", "scrolling-down");

    if (scrollDirection === "down") {
        climber.classList.add("scrolling-down");
    } else {
        climber.classList.add("scrolling-up");
    }

    lastScrollPosition = currentScroll;

    clearTimeout(scrollTimer);

    scrollTimer = setTimeout(function () {
        climber.classList.remove("scrolling-up", "scrolling-down");
    }, 250);

    updateTomatoMessage();

}


/* =========================================================
   UPDATE TOMATO POSITION
========================================================= */

function updateTomatoFromBookScroll() {

    const tomato = document.getElementById("climbingTomato");
    const climber = document.getElementById("tomatoClimber");
    const bookScrollArea = document.getElementById("bookScrollArea");

    if (!tomato || !climber || !bookScrollArea) {
        return;
    }

    const maxScroll = bookScrollArea.scrollHeight -
                      bookScrollArea.clientHeight;

    if (maxScroll <= 0) {
        tomatoClimberPosition = 20;
        tomato.style.top = "20px";
        return;
    }

    const progress = Math.min(
        Math.max(bookScrollArea.scrollTop / maxScroll, 0),
        1
    );

    const minimumTop = 18;

    const maximumTop = Math.max(
        climber.clientHeight - tomato.offsetHeight - 35,
        minimumTop
    );

    tomatoClimberPosition = minimumTop +
        progress * (maximumTop - minimumTop);

    tomato.style.top = tomatoClimberPosition + "px";

}


/* =========================================================
   TOMATO MESSAGE
========================================================= */

function updateTomatoMessage() {

    const message = document.getElementById("tomatoMessage");
    const bookScrollArea = document.getElementById("bookScrollArea");

    if (!message || !bookScrollArea) {
        return;
    }

    const maxScroll = bookScrollArea.scrollHeight -
                      bookScrollArea.clientHeight;

    if (maxScroll <= 0) {
        message.textContent = "Let's eat! 🍅";
        return;
    }

    const progress = bookScrollArea.scrollTop / maxScroll;

    if (progress < 0.15) {
        message.textContent = "Let's explore! 🍅";
    } else if (progress < 0.35) {
        message.textContent = "So many yummy dishes! 😍";
    } else if (progress < 0.60) {
        message.textContent = "Which one should I pick? 🤔";
    } else if (progress < 0.82) {
        message.textContent = "Keep scrolling! 🍅";
    } else {
        message.textContent = "Almost there! ❤️";
    }

}


/* =========================================================
   WINDOW RESIZE
========================================================= */

window.addEventListener("resize", function () {
    updateTomatoFromBookScroll();
});


/* =========================================================
   MENU SEARCH
========================================================= */

function initializeMenuSearch() {

    const searchInput = document.getElementById("menuSearch");

    if (!searchInput) {
        return;
    }

    searchInput.addEventListener("input", function () {

        const searchValue = searchInput.value.trim().toLowerCase();

        const spreads = document.querySelectorAll(".menu-spread");

        spreads.forEach(function (spread) {

            const itemName = spread.querySelector(".dish-info h3");
            const description = spread.querySelector(".dish-description");

            const nameText = itemName
                ? itemName.textContent.toLowerCase()
                : "";

            const descriptionText = description
                ? description.textContent.toLowerCase()
                : "";

            if (
                searchValue === "" ||
                nameText.includes(searchValue) ||
                descriptionText.includes(searchValue)
            ) {
                spread.style.display = "";
            } else {
                spread.style.display = "none";
            }

        });

    });

}


/* =========================================================
   AJAX CART
   - No page refresh
   - Preserve browser and book scroll positions
   - Support restaurant-switch confirmation
========================================================= */



function initializeAjaxCart() {

    console.log("TOMATO AJAX CART INITIALIZED 🍅");

    document.addEventListener("submit", async function (event) {

        const form = event.target;

        if (
            !(form instanceof HTMLFormElement) ||
            !form.matches(
                ".add-cart-form, .quantity-form, .remove-cart-form"
            )
        ) {
            return;
        }

        // Prevent normal form submission and page refresh.
        event.preventDefault();
        event.stopPropagation();

        const wrapper = form.closest(".cart-control-wrapper");

        if (!wrapper) {
            console.error("Cart wrapper not found for this form.");
            showCartMessage("Unable to find the cart controls.");
            return;
        }

        const cartUrl = wrapper.dataset.cartUrl || form.action;

        const bookScrollArea =
            document.getElementById("bookScrollArea");

        const savedWindowX = window.scrollX;
        const savedWindowY = window.scrollY;

        const savedBookScroll = bookScrollArea
            ? bookScrollArea.scrollTop
            : 0;

        const submitButton = form.querySelector(
            'button[type="submit"], input[type="submit"]'
        );

        if (submitButton) {
            submitButton.disabled = true;
        }

        try {

            const formData = new FormData(form);
            const action = formData.get("action") || "add";

            console.log("Cart action:", action);
            console.log("Cart endpoint:", cartUrl);

            let result = await sendCartRequest(cartUrl, formData);

            // Ask before replacing items from another restaurant.
            if (
                result.response.status === 409 &&
                result.data.requiresConfirmation === true
            ) {

                if (action !== "add") {
                    throw new Error(
                        result.data.message ||
                        "Unable to update your cart."
                    );
                }

                const confirmed = await showReplaceCartDialog();

                if (!confirmed) {
                    return;
                }

                const replacementData = new FormData(form);
                replacementData.set("action", "replace");

                result = await sendCartRequest(
                    cartUrl,
                    replacementData
                );
            }

            if (!result.response.ok || !result.data.success) {
                throw new Error(
                    result.data.message ||
                    "The server could not update your cart."
                );
            }

            // Update navbar cart count.
            updateCartCount(result.data.cartCount);

            // Update this dish's Add button or quantity controls.
            renderCartControls(wrapper, result.data.quantity);

            showCartMessage(
                result.data.message || "Cart updated successfully."
            );

            console.log("Cart updated successfully:", result.data);

        } catch (error) {

            console.error("TOMATO CART ERROR:", error);

            showCartMessage(
                error.message || "Unable to add the item to your cart."
            );

        } finally {

            requestAnimationFrame(function () {

                window.scrollTo(savedWindowX, savedWindowY);

                if (bookScrollArea) {
                    bookScrollArea.scrollTop = savedBookScroll;
                }

                updateTomatoFromBookScroll();
                updateTomatoMessage();

            });

            if (submitButton && submitButton.isConnected) {
                submitButton.disabled = false;
            }
        }

    });

}


/* =========================================================
   SEND CART REQUEST
========================================================= */


async function sendCartRequest(cartUrl, formData) {

    const parameters = new URLSearchParams();

    formData.forEach(function (value, key) {
        parameters.append(key, value);
    });

    const response = await fetch(cartUrl, {
        method: "POST",
        body: parameters,
        credentials: "same-origin",
        headers: {
            "X-Requested-With": "XMLHttpRequest",
            "Accept": "application/json"
        }
    });

    const contentType =
        response.headers.get("content-type") || "";

    if (!contentType.toLowerCase().includes("application/json")) {
        const responseText = await response.text();

        console.error(
            "Expected JSON but received:",
            response.status,
            responseText.substring(0, 500)
        );

        throw new Error(
            "The cart server returned HTML instead of JSON. " +
            "Check the /cart servlet response."
        );
    }

    const data = await response.json();

    return {
        response: response,
        data: data
    };
}


/* =========================================================
   REPLACE CART CONFIRMATION POPUP
========================================================= */

function showReplaceCartDialog() {

    return new Promise(function (resolve) {

        /*
         * Prevent duplicate dialogs.
         */
        const existingDialog =
            document.querySelector(".tomato-cart-modal-overlay");

        if (existingDialog) {
            existingDialog.remove();
        }

        const overlay = document.createElement("div");

        overlay.className = "tomato-cart-modal-overlay";
        overlay.setAttribute("role", "presentation");

        const dialog = document.createElement("div");

        dialog.className = "tomato-cart-modal";
        dialog.setAttribute("role", "dialog");
        dialog.setAttribute("aria-modal", "true");
        dialog.setAttribute("aria-labelledby", "tomatoCartDialogTitle");

        const icon = document.createElement("div");

        icon.className = "tomato-cart-modal-icon";
        icon.textContent = "🍅";

        const title = document.createElement("h2");

        title.id = "tomatoCartDialogTitle";
        title.className = "tomato-cart-modal-title";
        title.textContent = "Replace your cart?";

        const message = document.createElement("p");

        message.className = "tomato-cart-modal-message";
        message.textContent =
            "Your cart contains items from another restaurant. " +
            "Would you like to clear your existing cart and add " +
            "this item instead?";

        const buttons = document.createElement("div");

        buttons.className = "tomato-cart-modal-actions";

        const cancelButton = document.createElement("button");

        cancelButton.type = "button";
        cancelButton.className = "tomato-cart-cancel";
        cancelButton.textContent = "No, keep my cart";

        const confirmButton = document.createElement("button");

        confirmButton.type = "button";
        confirmButton.className = "tomato-cart-confirm";
        confirmButton.textContent = "Yes, replace my cart";

        buttons.appendChild(cancelButton);
        buttons.appendChild(confirmButton);

        dialog.appendChild(icon);
        dialog.appendChild(title);
        dialog.appendChild(message);
        dialog.appendChild(buttons);

        overlay.appendChild(dialog);

        document.body.appendChild(overlay);

        /*
         * Prevent background scrolling while the popup is open.
         * The previous scroll position is restored on close.
         */
        const previousBodyOverflow = document.body.style.overflow;

        document.body.style.overflow = "hidden";

        let resolved = false;

        function closeDialog(confirmed) {

            if (resolved) {
                return;
            }

            resolved = true;

            document.removeEventListener("keydown", handleKeydown);

            overlay.remove();

            document.body.style.overflow = previousBodyOverflow;

            resolve(confirmed);
        }

        function handleKeydown(event) {

            if (event.key === "Escape") {
                closeDialog(false);
            }
        }

        cancelButton.addEventListener("click", function () {
            closeDialog(false);
        });

        confirmButton.addEventListener("click", function () {
            closeDialog(true);
        });

        overlay.addEventListener("click", function (event) {

            if (event.target === overlay) {
                closeDialog(false);
            }

        });

        document.addEventListener("keydown", handleKeydown);

        confirmButton.focus();

    });

}


/* =========================================================
   UPDATE CART COUNT
========================================================= */

function updateCartCount(count) {

    const cartCount = document.querySelector(
        "#cartCount, .cart-count, [data-cart-count]"
    );

    if (cartCount && count !== undefined && count !== null) {
        cartCount.textContent = count;
    }

}


/* =========================================================
   CART MESSAGE
========================================================= */

function showCartMessage(message) {

    const messageElement = document.getElementById("cartMessage");

    if (messageElement) {
        messageElement.textContent = message;
        messageElement.hidden = false;
        return;
    }

    /*
     * No alert is shown for a cancelled replacement.
     * Other messages use the existing message element when available.
     */
    console.log("Tomato cart:", message);

}


/* =========================================================
   RENDER ADD-TO-CART / QUANTITY CONTROLS
========================================================= */

function renderCartControls(wrapper, quantity) {

    if (!wrapper) {
        return;
    }

    const menuId = wrapper.dataset.menuId;
    const restaurantId = wrapper.dataset.restaurantId;
    const cartUrl = wrapper.dataset.cartUrl;

    if (!menuId) {
        console.error("Missing menuId on cart-control-wrapper.");
        return;
    }

    const currentQuantity = Math.max(0, Number(quantity) || 0);

    wrapper.replaceChildren();

    if (currentQuantity <= 0) {

        const form = document.createElement("form");

        form.className = "add-cart-form";
        form.method = "post";
        form.action = cartUrl || getCartActionUrl();

        addHiddenInput(form, "action", "add");
        addHiddenInput(form, "menuId", menuId);
        addHiddenInput(form, "quantity", "1");
        addHiddenInput(form, "source", "menu");

        if (restaurantId) {
            addHiddenInput(form, "restaurantId", restaurantId);
        }

        /*
         * Keep the existing add-btn class and plus-sign layout.
         * No new cart-button styling is introduced here.
         */
        const button = document.createElement("button");

        button.type = "submit";
        button.className = "add-btn";

        const plusIcon = document.createElement("span");
        plusIcon.textContent = "+";

        button.appendChild(plusIcon);
        button.appendChild(
            document.createTextNode(" Add to Cart")
        );

        form.appendChild(button);
        wrapper.appendChild(form);

    } else {

        const control = document.createElement("div");

        control.className = "quantity-control";

        /* DECREASE QUANTITY */

        const minusForm = document.createElement("form");

        minusForm.className = "quantity-form";
        minusForm.method = "post";
        minusForm.action = cartUrl || getCartActionUrl();

        addHiddenInput(minusForm, "action", "update");
        addHiddenInput(minusForm, "menuId", menuId);
        addHiddenInput(
            minusForm,
            "quantity",
            String(currentQuantity - 1)
        );
        addHiddenInput(minusForm, "source", "menu");

        if (restaurantId) {
            addHiddenInput(minusForm, "restaurantId", restaurantId);
        }

        const minusButton = document.createElement("button");

        minusButton.type = "submit";
        minusButton.className = "quantity-btn";
        minusButton.textContent = "−";
        minusButton.setAttribute(
            "aria-label",
            "Decrease quantity"
        );

        minusForm.appendChild(minusButton);

        /* CURRENT QUANTITY */

        const quantityValue = document.createElement("span");

        quantityValue.className = "quantity-value";
        quantityValue.textContent = currentQuantity;

        /* INCREASE QUANTITY */

        const plusForm = document.createElement("form");

        plusForm.className = "quantity-form";
        plusForm.method = "post";
        plusForm.action = cartUrl || getCartActionUrl();

        addHiddenInput(plusForm, "action", "update");
        addHiddenInput(plusForm, "menuId", menuId);
        addHiddenInput(
            plusForm,
            "quantity",
            String(currentQuantity + 1)
        );
        addHiddenInput(plusForm, "source", "menu");

        if (restaurantId) {
            addHiddenInput(plusForm, "restaurantId", restaurantId);
        }

        const plusButton = document.createElement("button");

        plusButton.type = "submit";
        plusButton.className = "quantity-btn";
        plusButton.textContent = "+";
        plusButton.setAttribute(
            "aria-label",
            "Increase quantity"
        );

        plusForm.appendChild(plusButton);

        control.appendChild(minusForm);
        control.appendChild(quantityValue);
        control.appendChild(plusForm);

        wrapper.appendChild(control);

    }

}


/* =========================================================
   CART FORM HELPERS
========================================================= */

function getCartActionUrl() {

    const existingForm = document.querySelector(
        ".add-cart-form, .quantity-form, .remove-cart-form"
    );

    if (existingForm && existingForm.action) {
        return existingForm.action;
    }

    const contextPath = document.body.dataset.contextPath || "";

    return contextPath + "/cart";

}


function addHiddenInput(form, name, value) {

    const input = document.createElement("input");

    input.type = "hidden";
    input.name = name;
    input.value = value;

    form.appendChild(input);

}


/* =========================================================
   GO HOME
========================================================= */

function goHome() {
    window.location.href = "home.html";
}
