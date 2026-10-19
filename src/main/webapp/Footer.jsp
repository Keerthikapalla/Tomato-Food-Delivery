
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .tomato-footer,
    .tomato-footer * {
        box-sizing: border-box;
    }

    .tomato-footer {
        width: 100%;
        margin-top: 65px;
        padding: 48px 0 0;
        background: #242a22;
        color: #f8f5ed;
        font-family: "Poppins", sans-serif;
    }

    .tomato-footer .footer-container {
        width: min(1250px, 100%);
        margin: auto;
        padding: 0 5%;
    }

    .tomato-footer .footer-main {
        display: grid;
        grid-template-columns: 1.4fr 0.8fr 1fr 1.1fr;
        gap: 35px;
        padding-bottom: 38px;
    }

    .tomato-footer .footer-logo {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #fff;
        text-decoration: none !important;
        font-size: 25px;
        font-weight: 800;
    }

    .tomato-footer .footer-logo span {
        font-size: 29px;
    }

    .tomato-footer .footer-brand p {
        max-width: 290px;
        margin: 15px 0 20px;
        color: #c5c8bd;
        font-size: 12px;
        line-height: 1.9;
    }

    .tomato-footer .footer-column {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 12px;
    }

    .tomato-footer .footer-column h3,
    .tomato-footer .footer-message h3 {
        margin: 4px 0 8px;
        color: #fff;
        font-size: 15px;
        font-weight: 700;
    }

    .tomato-footer .footer-column a {
        color: #c5c8bd;
        text-decoration: none !important;
        font-size: 12px;
        transition: 0.2s ease;
    }

    .tomato-footer .footer-column a:hover {
        color: #ff8b75;
        transform: translateX(3px);
    }

    .tomato-footer .footer-message {
        padding: 22px;
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 17px;
        background: linear-gradient(
            135deg,
            rgba(229, 57, 53, 0.17),
            rgba(55, 131, 75, 0.15)
        );
    }

    .tomato-footer .footer-tomato-art {
        margin-bottom: 8px;
        font-size: 32px;
        animation: tomatoFooterFloat 3s ease-in-out infinite;
    }

    .tomato-footer .footer-message p {
        margin: 0;
        color: #c5c8bd;
        font-size: 11px;
        line-height: 1.8;
    }

    .tomato-footer .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        min-height: 65px;
        border-top: 1px solid rgba(255, 255, 255, 0.12);
    }

    .tomato-footer .footer-bottom p {
        margin: 0;
        color: #b7bcb1;
        font-size: 11px;
        line-height: 1.8;
    }

    .tomato-footer .footer-made span {
        color: #ff7169;
    }

    @media (max-width: 950px) {
        .tomato-footer .footer-main {
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 30px;
        }
    }

    @media (max-width: 560px) {
        .tomato-footer {
            margin-top: 45px;
            padding-top: 35px;
        }

        .tomato-footer .footer-main {
            gap: 28px 20px;
        }

        .tomato-footer .footer-brand,
        .tomato-footer .footer-message {
            grid-column: 1 / -1;
        }

        .tomato-footer .footer-bottom {
            align-items: flex-start;
            flex-direction: column;
            justify-content: center;
            padding: 15px 0;
        }
    }

    @keyframes tomatoFooterFloat {
        0%, 100% {
            transform: translateY(0);
        }

        50% {
            transform: translateY(-5px);
        }
    }

    @media (prefers-reduced-motion: reduce) {
        .tomato-footer .footer-tomato-art {
            animation: none;
        }
    }
</style>

<footer class="tomato-footer">
    <div class="footer-container">

        <div class="footer-main">

            <div class="footer-brand">
                <a href="${pageContext.request.contextPath}/home.html"
                   class="footer-logo">
                    <span>🍅</span> TOMATO
                </a>

                <p>
                    Good food, happy moments.
                    Your favourite flavours, delivered fresh to your door.
                </p>
            </div>

            <div class="footer-column">
                <h3>Explore</h3>
                <a href="${pageContext.request.contextPath}/home.html">Home</a>
                <a href="${pageContext.request.contextPath}/restaurant">Restaurants</a>
                <a href="${pageContext.request.contextPath}/cart">Your Cart</a>
                <a href="${pageContext.request.contextPath}/profile">My Profile</a>
            </div>

            <div class="footer-column">
                <h3>Customer Care</h3>
                <a href="${pageContext.request.contextPath}/profile">My Account</a>
                <a href="${pageContext.request.contextPath}/restaurant">Browse Food</a>
                <a href="mailto:support@tomato.example">Contact Support</a>
            </div>

            <div class="footer-message">
                <div class="footer-tomato-art">🍅</div>
                <h3>Made with love.</h3>
                <p>Every meal deserves a little happiness.</p>
            </div>

        </div>

        <div class="footer-bottom">
            <p>
                &copy; <%= java.time.Year.now().getValue() %>
                TOMATO. All rights reserved.
            </p>

            <p class="footer-made">
                Fresh food <span>♥</span> Happy you
            </p>
        </div>

    </div>
</footer>