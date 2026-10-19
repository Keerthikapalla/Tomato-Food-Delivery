
/* =========================================================
   TOMATO CART - QUANTITY, REMOVE, CLEAR AND TOTALS
   File: src/main/webapp/cart.js
========================================================= */

"use strict";

/* ---------------------------------------------------------
   CONTEXT PATH
--------------------------------------------------------- */

function getContextPath() {
    const body = document.body;

    if (body && body.dataset.contextPath !== undefined) {
        return body.dataset.contextPath;
    }

    const path = window.location.pathname;
    const parts = path.split("/").filter(Boolean);

    return parts.length > 0 ? "/" + parts[0] : "";
}

/* ---------------------------------------------------------
   GENERAL HELPERS
--------------------------------------------------------- */

function parseMoney(value) {
    if (value === null || value === undefined) {
        return 0;
    }

    const cleaned = String(value).replace(/[^\d.-]/g, "");
    const number = Number(cleaned);

    return Number.isFinite(number) ? number : 0;
}

function formatMoney(value) {
    return "₹" + Number(value || 0).toFixed(2);
}

function showCartMessage(message) {
    let toast = document.getElementById("cartToast");

    if (!toast) {
        toast = document.createElement("div");
        toast.id = "cartToast";

        Object.assign(toast.style, {
            position: "fixed",
            right: "24px",
            bottom: "24px",
            zIndex: "99999",
            maxWidth: "360px",
            padding: "14px 20px",
            borderRadius: "12px",
            background: "#c91f1f",
            color: "#ffffff",
            fontFamily: "Arial, sans-serif",
            fontSize: "14px",
            boxShadow: "0 8px 24px rgba(0,0,0,0.18)"
        });

        document.body.appendChild(toast);
    }

    toast.textContent = message;
    toast.style.display = "block";

    if (toast._hideTimer) {
        clearTimeout(toast._hideTimer);
    }

    toast._hideTimer = setTimeout(function () {
        toast.style.display = "none";
    }, 3000);
}

function closeError() {
    const error = document.querySelector(".cart-error");

    if (error) {
        error.remove();
    }
}

function confirmClearCart() {
    return window.confirm("Are you sure you want to clear your cart?");
}

function browseRestaurants() {
    window.location.href = getContextPath() + "/restaurant";
}

function goHome() {
    window.location.href = getContextPath() + "/restaurant";
}

/* ---------------------------------------------------------
   CART COUNT
--------------------------------------------------------- */

function updateCartCount(count) {
    const cartCount = document.getElementById("cartCount");

    if (!cartCount) {
        return;
    }

    if (Number.isFinite(Number(count))) {
        cartCount.textContent = String(Number(count));
    }
}

/* ---------------------------------------------------------
   FIND CART ITEM
--------------------------------------------------------- */

function getCartItem(form) {
    return form ? form.closest(".cart-item") : null;
}

/* ---------------------------------------------------------
   QUANTITY CONTROLS
--------------------------------------------------------- */

function updateQuantityControls(item, quantity) {
    if (!item) {
        return;
    }

    const quantityValue = item.querySelector(".quantity-value");

    if (quantityValue) {
        quantityValue.textContent = String(quantity);
    }

    const forms = item.querySelectorAll(".cart-update-form");

    forms.forEach(function (form) {
        const quantityInput = form.querySelector(
            'input[name="quantity"]'
        );

        const button = form.querySelector("button");

        if (!quantityInput || !button) {
            return;
        }

        const action = button.textContent.trim();

        if (action === "−" || action === "-") {
            quantityInput.value = Math.max(0, quantity - 1);
            button.disabled = quantity <= 1;
        } else if (action === "+") {
            quantityInput.value = quantity + 1;
            button.disabled = false;
        }
    });
}

/* ---------------------------------------------------------
   RECALCULATE CART TOTALS
--------------------------------------------------------- */

function refreshCartSummary() {
    const items = Array.from(
        document.querySelectorAll(".cart-item")
    );

    let subtotal = 0;
    let totalQuantity = 0;

    items.forEach(function (item) {
        const priceElement = item.querySelector(".item-price");
        const quantityElement = item.querySelector(".quantity-value");
        const totalElement = item.querySelector(".cart-item-total");

        const price = parseMoney(
            priceElement ? priceElement.textContent : 0
        );

        const quantity = parseInt(
            quantityElement ? quantityElement.textContent : "0",
            10
        ) || 0;

        const itemTotal = price * quantity;

        subtotal += itemTotal;
        totalQuantity += quantity;

        if (totalElement) {
            totalElement.textContent = formatMoney(itemTotal);
        }
    });

    const delivery = items.length > 0 ? 40 : 0;
    const platform = items.length > 0 ? 10 : 0;
    const taxes = subtotal * 0.05;
    const grandTotal = subtotal + delivery + platform + taxes;

    /*
     * Update summary rows using their visible labels.
     * This keeps the existing cart.jsp structure intact.
     */
    document.querySelectorAll(".summary-row").forEach(function (row) {
        const text = row.textContent.toLowerCase();
        const valueElement = row.querySelector("span:last-child");

        if (!valueElement) {
            return;
        }

        if (text.includes("subtotal")) {
            valueElement.textContent = formatMoney(subtotal);
        } else if (text.includes("delivery")) {
            valueElement.textContent = formatMoney(delivery);
        } else if (text.includes("platform")) {
            valueElement.textContent = formatMoney(platform);
        } else if (text.includes("tax")) {
            valueElement.textContent = formatMoney(taxes);
        }
    });

    const grandTotalElement = document.querySelector(
        ".summary-total strong"
    );

    if (grandTotalElement) {
        grandTotalElement.textContent = formatMoney(grandTotal);
    }

    /*
     * The cartCount shown in the navbar represents total quantity.
     */
    updateCartCount(totalQuantity);

    return {
        subtotal: subtotal,
        delivery: delivery,
        platform: platform,
        taxes: taxes,
        grandTotal: grandTotal,
        cartCount: totalQuantity
    };
}

/* ---------------------------------------------------------
   EMPTY CART
--------------------------------------------------------- */

function showEmptyCart() {
    const layout = document.querySelector(".cart-layout");

    if (!layout || document.querySelector(".empty-cart")) {
        return;
    }

    const emptyCart = document.createElement("section");
    emptyCart.className = "empty-cart";

    emptyCart.innerHTML = `
        <div class="empty-cart-content">
            <div class="empty-cart-icon">🍅</div>
            <h2>Your cart is feeling lonely!</h2>
            <p>Add some delicious dishes to get started.</p>
            <button type="button" class="browse-restaurants-btn">
                Explore Restaurants
            </button>
        </div>
    `;

    const browseButton = emptyCart.querySelector(
        ".browse-restaurants-btn"
    );

    browseButton.addEventListener("click", browseRestaurants);

    layout.replaceWith(emptyCart);
}

/* ---------------------------------------------------------
   SEND AJAX REQUEST
--------------------------------------------------------- */

async function sendCartRequest(form) {
    const formData = new FormData(form);
    const params = new URLSearchParams();

    formData.forEach(function (value, key) {
        params.append(key, value);
    });

    const response = await fetch(form.action, {
        method: "POST",
        body: params,
        headers: {
            "X-Requested-With": "XMLHttpRequest",
            "Accept": "application/json"
        },
        credentials: "same-origin",
        cache: "no-store"
    });

    const contentType = response.headers.get("content-type") || "";

    if (!contentType.toLowerCase().includes("application/json")) {
        throw new Error(
            "The server did not return JSON. Falling back to normal submission."
        );
    }

    const data = await response.json();

    if (!response.ok || data.success === false) {
        if (data.message) {
            throw new Error(data.message);
        }

        throw new Error("The cart could not be updated.");
    }

    return data;
}

/* ---------------------------------------------------------
   CART FORM SUBMISSION
--------------------------------------------------------- */

function initializeAjaxCart() {
    document.addEventListener("submit", async function (event) {
        const form = event.target;

        if (!(form instanceof HTMLFormElement)) {
            return;
        }

        /*
         * Do not depend on a particular wrapper class.
         * Handle the cart forms present in cart.jsp.
         */
        const actionInput = form.querySelector('input[name="action"]');

        if (!actionInput) {
            return;
        }

        const action = actionInput.value;

        if (!["update", "remove", "clear"].includes(action)) {
            return;
        }

        /*
         * Only intercept forms that submit to the cart endpoint.
         */
        const formUrl = new URL(form.action, window.location.href);
        const cartUrl = new URL(
            getContextPath() + "/cart",
            window.location.origin
        );

        if (formUrl.pathname !== cartUrl.pathname) {
            return;
        }

        /*
         * For clear-cart forms, keep the confirmation.
         */
        if (action === "clear" && !form.dataset.confirmed) {
            event.preventDefault();

            if (!confirmClearCart()) {
                return;
            }

            form.dataset.confirmed = "true";

            /*
             * Re-dispatch through the same submit handler.
             */
            form.requestSubmit();
            return;
        }

        event.preventDefault();

        if (form.dataset.processing === "true") {
            return;
        }

        form.dataset.processing = "true";

        const item = getCartItem(form);
        const oldScrollY = window.scrollY;
        const oldItemTop = item
            ? item.getBoundingClientRect().top
            : null;

        const buttons = Array.from(
            form.querySelectorAll('button[type="submit"], button:not([type])')
        );

        buttons.forEach(function (button) {
            button.disabled = true;
        });

        try {
            const data = await sendCartRequest(form);

            if (action === "update") {
                const requestedQuantity = parseInt(
                    form.querySelector('input[name="quantity"]')?.value || "0",
                    10
                );

                const newQuantity = Number.isFinite(Number(data.quantity))
                    ? Number(data.quantity)
                    : requestedQuantity;

                if (newQuantity <= 0) {
                    if (item) {
                        item.remove();
                    }
                } else {
                    updateQuantityControls(item, newQuantity);
                }
            } else if (action === "remove") {
                if (item) {
                    item.remove();
                }
            } else if (action === "clear") {
                document.querySelectorAll(".cart-item").forEach(function (row) {
                    row.remove();
                });
            }

            const totals = refreshCartSummary();

            if (Number.isFinite(Number(data.cartCount))) {
                updateCartCount(Number(data.cartCount));
            } else {
                updateCartCount(totals.cartCount);
            }

            if (document.querySelectorAll(".cart-item").length === 0) {
                showEmptyCart();
            }

            if (data.message) {
                showCartMessage(data.message);
            }

            /*
             * Keep the page at its previous scroll position.
             */
            requestAnimationFrame(function () {
                if (item && oldItemTop !== null && item.isConnected) {
                    const newItemTop = item.getBoundingClientRect().top;
                    window.scrollBy(0, newItemTop - oldItemTop);
                } else {
                    window.scrollTo(0, oldScrollY);
                }
            });

        } catch (error) {
            console.error("TOMATO cart AJAX error:", error);

            /*
             * Important fallback:
             * if AJAX fails, let the servlet process the original POST
             * normally instead of leaving the button doing nothing.
             */
            form.dataset.processing = "false";
            form.dataset.confirmed = "true";

            HTMLFormElement.prototype.submit.call(form);
            return;

        } finally {
            /*
             * Do not reset the form while a fallback navigation is starting.
             */
            if (form.dataset.processing === "true") {
                form.dataset.processing = "false";

                buttons.forEach(function (button) {
                    button.disabled = false;
                });
            }
        }
    });
}

/* ---------------------------------------------------------
   INITIALIZE
--------------------------------------------------------- */

document.addEventListener("DOMContentLoaded", function () {
    initializeAjaxCart();
    refreshCartSummary();

    console.log("TOMATO CART INITIALIZED 🍅");
});
