
document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("checkoutForm");
    const paymentMode = document.getElementById("paymentMode");
    const paymentHint = document.getElementById("paymentHint");
    const paymentOptions = document.querySelectorAll(".payment-option");
    const paymentRadios = document.querySelectorAll('input[name="onlineMethod"]');
    const placeOrderBtn = document.getElementById("placeOrderBtn");

    const hints = {
        COD: "💚 Pay with cash when your delicious order arrives.",
        UPI: "📱 UPI selected. Online payment must be enabled by your payment backend.",
        CARD: "💳 Card selected. Card processing must be enabled by your payment backend."
    };

    function updatePayment() {
        const selected = document.querySelector('input[name="onlineMethod"]:checked');
        const method = selected ? selected.value : "COD";

        paymentMode.value = method === "COD" ? "COD" : "ONLINE";
        paymentHint.textContent = hints[method] || hints.COD;

        paymentOptions.forEach(option => {
            const radio = option.querySelector('input[type="radio"]');
            option.classList.toggle("selected", Boolean(radio && radio.checked));
        });
    }

    paymentRadios.forEach(radio => {
        radio.addEventListener("change", updatePayment);
    });

    form.addEventListener("submit", event => {
        if (!form.checkValidity()) {
            event.preventDefault();
            form.reportValidity();
            return;
        }

        updatePayment();

        placeOrderBtn.disabled = true;
        placeOrderBtn.textContent = "Placing your order...";
    });

    updatePayment();
});
