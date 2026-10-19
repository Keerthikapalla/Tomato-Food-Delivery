
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TOMATO | Order Success</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

<style>
/* ==================================================
   TOMATO ORDER SUCCESS — SINGLE FILE
================================================== */




:root {
    --tomato: #f04438;
    --tomato-dark: #d92d20;
    --green: #238653;
    --green-light: #eaf7ed;
    --cream: #fffaf0;
    --ink: #262626;
    --muted: #777;
    --border: #eeeeea;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    color: var(--ink);
    background:
        radial-gradient(circle at 8% 8%, #ffe5d8 0, transparent 24%),
        radial-gradient(circle at 95% 15%, #e2f5e5 0, transparent 25%),
        #fffdf8;
    overflow-x: hidden;
}

button, a {
    font: inherit;
}

button {
    cursor: pointer;
}

a {
    text-decoration: none;
    color: inherit;
}

/* Floating food decorations */

.food-float {
    position: fixed;
    z-index: 0;
    pointer-events: none;
    opacity: .16;
    font-size: 28px;
    animation: floatFood 6s ease-in-out infinite;
}

.food-one { top: 18%; left: 3%; }
.food-two { top: 45%; right: 3%; animation-delay: 1s; }
.food-three { bottom: 12%; left: 5%; animation-delay: 2s; }
.food-four { top: 72%; right: 7%; animation-delay: 1.5s; }

@keyframes floatFood {
    0%, 100% { transform: translateY(0) rotate(-8deg); }
    50% { transform: translateY(-16px) rotate(8deg); }
}

/* Navbar */

.navbar {
    position: relative;
    z-index: 5;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 17px 7%;
    background: rgba(255,255,255,.9);
    border-bottom: 1px solid rgba(0,0,0,.05);
    backdrop-filter: blur(12px);
}

.brand {
    display: flex;
    align-items: center;
    gap: 9px;
    font-size: 25px;
    font-weight: 800;
    letter-spacing: -.8px;
    color: var(--tomato);
}

.brand-icon {
    display: inline-grid;
    place-items: center;
    width: 38px;
    height: 38px;
    border-radius: 13px;
    background: #fff0eb;
    font-size: 23px;
}

.nav-tag {
    color: var(--green);
    background: #eff9f0;
    border: 1px solid #dcefe0;
    border-radius: 30px;
    padding: 8px 14px;
    font-size: 12px;
    font-weight: 600;
}

/* Main content */

.page {
    position: relative;
    z-index: 1;
    width: min(1080px, 92%);
    margin: 32px auto 45px;
}

/* Celebration section */

.success-hero {
    position: relative;
    text-align: center;
    overflow: hidden;
    padding: 29px 20px 31px;
    border-radius: 25px;
    background: linear-gradient(135deg, #fff 0%, #fffaf0 100%);
    border: 1px solid #f4eee3;
    box-shadow: 0 12px 38px rgba(69, 52, 25, .06);
    animation: appear .7s ease both;
}

.success-hero::before,
.success-hero::after {
    content: "";
    position: absolute;
    width: 150px;
    height: 150px;
    border-radius: 50%;
    background: #e9f7e8;
    opacity: .65;
}

.success-hero::before {
    left: -75px;
    top: -90px;
}

.success-hero::after {
    right: -70px;
    bottom: -100px;
    background: #ffe2d8;
}

.celebration {
    position: relative;
    z-index: 1;
    font-size: 38px;
    line-height: 1.2;
    margin-bottom: 10px;
    animation: partyPop 1.1s ease-in-out infinite alternate;
}

@keyframes partyPop {
    from { transform: scale(1) rotate(-4deg); }
    to { transform: scale(1.09) rotate(4deg); }
}

.success-check {
    position: relative;
    z-index: 1;
    display: grid;
    place-items: center;
    margin: 0 auto 12px;
    width: 56px;
    height: 56px;
    border-radius: 50%;
    background: var(--green);
    color: white;
    font-size: 30px;
    font-weight: 700;
    box-shadow: 0 0 0 9px #e8f6e9;
    animation: checkPop .65s cubic-bezier(.2,.9,.3,1.3) both;
}

@keyframes checkPop {
    from { transform: scale(0); }
    to { transform: scale(1); }
}

.success-hero h1 {
    position: relative;
    z-index: 1;
    font-size: clamp(23px, 3.5vw, 33px);
    font-weight: 800;
    line-height: 1.3;
    margin-bottom: 8px;
}

.success-hero h1 span {
    color: var(--green);
}

.success-hero p {
    position: relative;
    z-index: 1;
    color: var(--muted);
    font-size: 13px;
    line-height: 1.8;
}

.order-chip {
    position: relative;
    z-index: 1;
    display: inline-flex;
    align-items: center;
    gap: 7px;
    margin-top: 15px;
    padding: 8px 14px;
    background: white;
    border: 1px solid #eae8df;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 600;
}

.order-chip strong {
    color: var(--tomato);
}

/* Confetti */

.confetti-layer {
    position: absolute;
    inset: 0;
    z-index: 2;
    overflow: hidden;
    pointer-events: none;
}

.confetti {
    position: absolute;
    top: -15px;
    width: 8px;
    height: 13px;
    opacity: .9;
    animation: confettiFall linear forwards;
}

@keyframes confettiFall {
    to {
        transform: translateY(360px) rotate(720deg);
        opacity: 0;
    }
}

/* Tracker layout */

.tracker-layout {
    display: grid;
    grid-template-columns: minmax(0, 1.65fr) minmax(280px, .85fr);
    gap: 20px;
    margin-top: 22px;
    align-items: stretch;
    animation: appear .8s ease both;
}

.panel {
    background: white;
    border: 1px solid #eeeee8;
    border-radius: 22px;
    box-shadow: 0 10px 32px rgba(42, 51, 36, .055);
    overflow: hidden;
}

.panel-heading {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    padding: 19px 21px 14px;
}

.panel-heading h2 {
    font-size: 16px;
    font-weight: 700;
}

.live-demo {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: var(--green);
    font-size: 10px;
    font-weight: 700;
    background: #edf8ee;
    padding: 6px 9px;
    border-radius: 20px;
}

.live-dot {
    width: 6px;
    height: 6px;
    background: #2aa65a;
    border-radius: 50%;
    animation: pulse 1.4s infinite;
}

@keyframes pulse {
    50% { opacity: .3; transform: scale(.75); }
}

/* Map */

.map {
    position: relative;
    height: 310px;
    margin: 0 13px 13px;
    border-radius: 17px;
    overflow: hidden;
    background-color: #eaf4e5;
    background-image:
        linear-gradient(30deg, transparent 47%, rgba(255,255,255,.7) 48%, rgba(255,255,255,.7) 51%, transparent 52%),
        linear-gradient(120deg, transparent 42%, rgba(255,255,255,.75) 43%, rgba(255,255,255,.75) 46%, transparent 47%),
        linear-gradient(75deg, transparent 72%, rgba(255,255,255,.6) 73%, rgba(255,255,255,.6) 75%, transparent 76%);
    background-size: 170px 150px, 210px 190px, 240px 200px;
}

.park {
    position: absolute;
    border-radius: 35% 65% 52% 48%;
    background: rgba(155, 210, 144, .4);
}

.park-one {
    width: 100px;
    height: 72px;
    top: 25px;
    left: 35px;
    transform: rotate(-18deg);
}

.park-two {
    width: 90px;
    height: 110px;
    bottom: 17px;
    right: 30px;
    transform: rotate(23deg);
}

.road {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
}

.route-base {
    fill: none;
    stroke: #d4dfd0;
    stroke-width: 15;
    stroke-linecap: round;
    stroke-linejoin: round;
}

.route-line {
    fill: none;
    stroke: #ffffff;
    stroke-width: 8;
    stroke-linecap: round;
    stroke-linejoin: round;
}

.route-progress {
    fill: none;
    stroke: var(--green);
    stroke-width: 4;
    stroke-linecap: round;
    stroke-dasharray: 8 8;
    stroke-linejoin: round;
    opacity: .9;
}

.map-label {
    position: absolute;
    z-index: 2;
    display: flex;
    align-items: center;
    gap: 7px;
    background: white;
    padding: 7px 10px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,.1);
    font-size: 10px;
    font-weight: 700;
    white-space: nowrap;
}

.restaurant-label {
    top: 12px;
    left: 12px;
}

.home-label {
    right: 12px;
    bottom: 12px;
}

.map-pin {
    display: grid;
    place-items: center;
    width: 27px;
    height: 27px;
    border-radius: 9px;
    color: white;
    background: var(--tomato);
    font-size: 14px;
}

.home-label .map-pin {
    background: var(--green);
}

.scooter {
    position: absolute;
    z-index: 3;
    width: 43px;
    height: 43px;
    display: grid;
    place-items: center;
    border: 3px solid white;
    border-radius: 50%;
    background: #fff0d8;
    box-shadow: 0 4px 15px rgba(0,0,0,.18);
    font-size: 22px;
    transform: translate(-50%, -50%);
    transition: left .12s linear, top .12s linear;
}

.map-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    padding: 0 18px 16px;
    font-size: 10px;
    color: var(--muted);
}

.map-footer strong {
    color: var(--green);
}

/* ETA card */

.eta-panel {
    padding: 22px;
    display: flex;
    flex-direction: column;
}

.eta-topline {
    color: var(--muted);
    font-size: 12px;
    font-weight: 500;
}

.eta-number {
    color: var(--green);
    font-size: 39px;
    font-weight: 800;
    letter-spacing: -1.5px;
    line-height: 1.2;
    margin: 6px 0 3px;
}

.eta-number span {
    font-size: 15px;
    letter-spacing: 0;
    font-weight: 600;
}

.eta-description {
    font-size: 11px;
    color: var(--muted);
}

.delivery-person {
    display: flex;
    align-items: center;
    gap: 11px;
    margin: 19px 0;
    padding: 12px;
    border-radius: 14px;
    background: #fff8ef;
    border: 1px solid #f6ead9;
}

.person-avatar {
    display: grid;
    place-items: center;
    width: 43px;
    height: 43px;
    flex-shrink: 0;
    border-radius: 50%;
    background: #ffe5d7;
    font-size: 23px;
}

.person-info {
    flex: 1;
    min-width: 0;
}

.person-info strong {
    display: block;
    font-size: 12px;
}

.person-info span {
    color: var(--muted);
    font-size: 10px;
}

.demo-pill {
    flex-shrink: 0;
    color: #956313;
    background: #fff0c9;
    padding: 5px 7px;
    border-radius: 8px;
    font-size: 9px;
    font-weight: 700;
}

/* Timeline */

.timeline-title {
    font-size: 13px;
    font-weight: 700;
    margin-bottom: 16px;
}

.timeline {
    list-style: none;
    position: relative;
}

.timeline li {
    position: relative;
    display: flex;
    gap: 12px;
    padding-bottom: 17px;
}

.timeline li:last-child {
    padding-bottom: 0;
}

.timeline li:not(:last-child)::after {
    content: "";
    position: absolute;
    top: 26px;
    left: 11px;
    width: 2px;
    height: calc(100% - 20px);
    background: #e8e8e1;
}

.timeline li.done:not(:last-child)::after {
    background: #9fd4a9;
}

.step-icon {
    position: relative;
    z-index: 1;
    display: grid;
    place-items: center;
    width: 24px;
    height: 24px;
    flex-shrink: 0;
    border-radius: 50%;
    background: #f0f0ed;
    color: #888;
    font-size: 11px;
    font-weight: 700;
}

.timeline li.done .step-icon {
    background: #e4f5e7;
    color: var(--green);
}

.timeline li.active .step-icon {
    color: white;
    background: var(--green);
    box-shadow: 0 0 0 5px #e7f6e9;
}

.step-copy {
    padding-top: 2px;
}

.step-copy strong {
    display: block;
    font-size: 11px;
    line-height: 1.5;
}

.step-copy span {
    display: block;
    margin-top: 3px;
    font-size: 10px;
    color: var(--muted);
    line-height: 1.5;
}

.timeline li:not(.done):not(.active) .step-copy strong {
    color: #96968f;
}

/* Buttons and footer */

.action-row {
    display: flex;
    gap: 10px;
    margin-top: 19px;
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 7px;
    border: 0;
    border-radius: 11px;
    padding: 11px 15px;
    font-size: 11px;
    font-weight: 700;
    transition: transform .2s, background .2s;
}

.btn:hover {
    transform: translateY(-2px);
}

.btn-primary {
    color: white;
    background: var(--tomato);
    flex: 1;
}

.btn-primary:hover {
    background: var(--tomato-dark);
}

.btn-secondary {
    color: var(--green);
    background: #edf7ee;
}

.note {
    margin-top: 15px;
    padding: 11px 12px;
    border-radius: 11px;
    background: #f7f8f4;
    color: #777;
    font-size: 10px;
    line-height: 1.7;
}

.footer {
    padding: 24px 10px 0;
    text-align: center;
    color: #96968f;
    font-size: 10px;
}

.footer strong {
    color: var(--tomato);
}

.hidden {
    display: none !important;
}

@keyframes appear {
    from { opacity: 0; transform: translateY(12px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Responsive */

@media (max-width: 760px) {
    .navbar {
        padding: 14px 5%;
    }

    .brand {
        font-size: 22px;
    }

    .page {
        width: 94%;
        margin-top: 18px;
    }

    .success-hero {
        padding: 25px 15px;
        border-radius: 21px;
    }

    .tracker-layout {
        grid-template-columns: 1fr;
        gap: 15px;
        margin-top: 16px;
    }

    .map {
        height: 280px;
    }

    .eta-panel {
        padding: 20px;
    }

    .eta-number {
        font-size: 34px;
    }
}

@media (max-width: 420px) {
    .nav-tag {
        font-size: 10px;
        padding: 7px 9px;
    }

    .success-hero h1 {
        font-size: 23px;
    }

    .success-hero p {
        font-size: 12px;
    }

    .map {
        height: 245px;
        margin: 0 8px 10px;
    }

    .panel-heading {
        padding: 16px 14px 12px;
    }

    .map-label {
        font-size: 9px;
        padding: 6px 7px;
    }

    .home-label {
        right: 7px;
        bottom: 8px;
    }

    .restaurant-label {
        left: 7px;
        top: 8px;
    }

    .action-row {
        flex-direction: column;
    }

    .btn-secondary {
        min-height: 40px;
    }
}

@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: .01ms !important;
        animation-iteration-count: 1 !important;
        scroll-behavior: auto !important;
    }
}






/* =====================================================
   TOMATO ORDER SUCCESS — RED & CREAM THEME
   Complete dark/light mode support
===================================================== */

/* LIGHT MODE — TOMATO RED + WARM CREAM */

html[data-theme="light"] body,
html:not([data-theme="dark"]) body {
    color: #262626;
    background:
        radial-gradient(circle at 8% 8%, #ffe2d8 0, transparent 25%),
        radial-gradient(circle at 95% 15%, #f5e6c9 0, transparent 26%),
        #fff4e6;
}

html[data-theme="light"] .navbar,
html:not([data-theme="dark"]) .navbar {
    background: rgba(255, 244, 230, 0.96);
    border-bottom: 1px solid #f0d8c8;
}

html[data-theme="light"] .success-hero,
html:not([data-theme="dark"]) .success-hero {
    background: linear-gradient(135deg, #fffaf2, #fff0df);
    border-color: #f1d9c5;
}

html[data-theme="light"] .panel,
html:not([data-theme="dark"]) .panel {
    background: #fffaf2;
    border-color: #f0dfcf;
}

html[data-theme="light"] .order-chip,
html:not([data-theme="dark"]) .order-chip {
    background: #fff4e6;
    border-color: #ecd6c2;
    color: #262626;
}

html[data-theme="light"] .delivery-person,
html:not([data-theme="dark"]) .delivery-person {
    background: #fff0df;
    border-color: #f0d6bd;
}

html[data-theme="light"] .note,
html:not([data-theme="dark"]) .note {
    background: #f8ecdc;
    color: #5d5148;
}

html[data-theme="light"] .map-label,
html:not([data-theme="dark"]) .map-label {
    background: #fffaf2;
    color: #262626;
}

html[data-theme="light"] .btn-primary,
html:not([data-theme="dark"]) .btn-primary {
    background: #E63946;
    color: #ffffff;
}

html[data-theme="light"] .btn-primary:hover,
html:not([data-theme="dark"]) .btn-primary:hover {
    background: #C62836;
}

html[data-theme="light"] .btn-secondary,
html:not([data-theme="dark"]) .btn-secondary {
    background: #eaf7ed;
    color: #17663c;
}

html[data-theme="light"] .footer,
html:not([data-theme="dark"]) .footer {
    color: #776b60;
}

/* DARK MODE — CHARCOAL + CREAM + TOMATO RED */

html[data-theme="dark"],
html[data-theme="dark"] body {
    color-scheme: dark;
    background: #151515 !important;
    color: #FFF4E6 !important;
}

/* Main page background */
html[data-theme="dark"] body {
    background:
        radial-gradient(circle at 8% 8%, #321c1c 0, transparent 27%),
        radial-gradient(circle at 95% 15%, #202a20 0, transparent 27%),
        #151515 !important;
}

/* Navbar */
html[data-theme="dark"] .navbar {
    background: rgba(29, 27, 27, 0.97) !important;
    color: #FFF4E6 !important;
    border-bottom: 1px solid #39302e !important;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.25);
}

html[data-theme="dark"] .navbar a,
html[data-theme="dark"] .navbar span,
html[data-theme="dark"] .navbar button {
    color: #FFF4E6;
}

/* Brand colors */
html[data-theme="dark"] .brand {
    color: #FF625F !important;
}

html[data-theme="dark"] .brand-icon {
    background: #3b2020 !important;
}

html[data-theme="dark"] .nav-tag {
    background: #203528 !important;
    color: #bce8c8 !important;
    border-color: #365b40 !important;
}

/* Success banner */
html[data-theme="dark"] .success-hero {
    background: linear-gradient(135deg, #282020, #24231c) !important;
    border: 1px solid #49312d !important;
    box-shadow: 0 12px 38px rgba(0, 0, 0, 0.3) !important;
}

html[data-theme="dark"] .success-hero h1 {
    color: #FFF4E6 !important;
}

html[data-theme="dark"] .success-hero h1 span {
    color: #FF625F !important;
}

html[data-theme="dark"] .success-hero p {
    color: #d3c7bd !important;
}

html[data-theme="dark"] .success-hero::before {
    background: #23402b !important;
    opacity: 0.5;
}

html[data-theme="dark"] .success-hero::after {
    background: #572b2b !important;
    opacity: 0.5;
}

/* Success check */
html[data-theme="dark"] .success-check {
    background: #238653 !important;
    color: #ffffff !important;
    box-shadow: 0 0 0 9px #263b2b !important;
}

/* Order ID chip */
html[data-theme="dark"] .order-chip {
    background: #302724 !important;
    color: #FFF4E6 !important;
    border-color: #55403a !important;
}

html[data-theme="dark"] .order-chip strong {
    color: #FF625F !important;
}

/* Panels */
html[data-theme="dark"] .panel {
    background: #202020 !important;
    color: #FFF4E6 !important;
    border: 1px solid #38302e !important;
    box-shadow: 0 10px 32px rgba(0, 0, 0, 0.28) !important;
}

html[data-theme="dark"] .panel-heading h2,
html[data-theme="dark"] .timeline-title {
    color: #FFF4E6 !important;
}

html[data-theme="dark"] .live-demo {
    background: #203528 !important;
    color: #bce8c8 !important;
}

/* Delivery map */
html[data-theme="dark"] .map {
    background-color: #303a30 !important;
    background-image:
        linear-gradient(30deg, transparent 47%, rgba(220, 220, 200, .10) 48%, rgba(220, 220, 200, .10) 51%, transparent 52%),
        linear-gradient(120deg, transparent 42%, rgba(220, 220, 200, .12) 43%, rgba(220, 220, 200, .12) 46%, transparent 47%),
        linear-gradient(75deg, transparent 72%, rgba(220, 220, 200, .10) 73%, rgba(220, 220, 200, .10) 75%, transparent 76%) !important;
    background-size: 170px 150px, 210px 190px, 240px 200px !important;
}

html[data-theme="dark"] .park {
    background: rgba(78, 131, 76, 0.35) !important;
}

html[data-theme="dark"] .route-base {
    stroke: #596254 !important;
}

html[data-theme="dark"] .route-line {
    stroke: #d8d9cb !important;
}

html[data-theme="dark"] .route-progress {
    stroke: #54bd7c !important;
}

html[data-theme="dark"] .map-label {
    background: #262522 !important;
    color: #FFF4E6 !important;
    border: 1px solid #4a413a !important;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.35) !important;
}

html[data-theme="dark"] .map-pin {
    background: #E63946 !important;
    color: #ffffff !important;
}

html[data-theme="dark"] .home-label .map-pin {
    background: #238653 !important;
}

html[data-theme="dark"] .scooter {
    background: #47372a !important;
    border-color: #eee0cf !important;
}

/* Map footer */
html[data-theme="dark"] .map-footer {
    color: #c9bfb5 !important;
}

html[data-theme="dark"] .map-footer strong {
    color: #7cdaa0 !important;
}

/* Estimated delivery time */
html[data-theme="dark"] .eta-topline,
html[data-theme="dark"] .eta-description {
    color: #c8bdb4 !important;
}

html[data-theme="dark"] .eta-number {
    color: #7cdaa0 !important;
}

/* Delivery partner */
html[data-theme="dark"] .delivery-person {
    background: #30251f !important;
    border-color: #514034 !important;
}

html[data-theme="dark"] .person-avatar {
    background: #49312b !important;
}

html[data-theme="dark"] .person-info strong {
    color: #FFF4E6 !important;
}

html[data-theme="dark"] .person-info span {
    color: #c8bdb4 !important;
}

html[data-theme="dark"] .demo-pill {
    background: #4b3b22 !important;
    color: #ffdf99 !important;
}

/* Timeline */
html[data-theme="dark"] .timeline li:not(:last-child)::after {
    background: #48433d !important;
}

html[data-theme="dark"] .timeline li.done:not(:last-child)::after {
    background: #398354 !important;
}

html[data-theme="dark"] .step-icon {
    background: #343434 !important;
    color: #c9c0b7 !important;
}

html[data-theme="dark"] .timeline li.done .step-icon {
    background: #24452f !important;
    color: #a9e5b8 !important;
}

html[data-theme="dark"] .timeline li.active .step-icon {
    background: #238653 !important;
    color: #ffffff !important;
    box-shadow: 0 0 0 5px #263b2b !important;
}

html[data-theme="dark"] .step-copy strong {
    color: #FFF4E6 !important;
}

html[data-theme="dark"] .step-copy span {
    color: #c8bdb4 !important;
}

html[data-theme="dark"] .timeline li:not(.done):not(.active) .step-copy strong {
    color: #a7a097 !important;
}

/* Buttons */
html[data-theme="dark"] .btn-primary {
    background: #E63946 !important;
    color: #ffffff !important;
}

html[data-theme="dark"] .btn-primary:hover {
    background: #C62836 !important;
}

html[data-theme="dark"] .btn-secondary {
    background: #263b2c !important;
    color: #c1f0cd !important;
    border: 1px solid #365b40 !important;
}

/* Informational note */
html[data-theme="dark"] .note {
    background: #292825 !important;
    color: #d6c9bd !important;
    border: 1px solid #403a33 !important;
}

html[data-theme="dark"] .note strong {
    color: #b9e7c4 !important;
}

/* Footer */
html[data-theme="dark"] .footer {
    color: #c1b5aa !important;
}

html[data-theme="dark"] .footer strong {
    color: #FF625F !important;
}

/* Keep text readable inside the page */
html[data-theme="dark"] .page,
html[data-theme="dark"] .tracker-layout {
    color: #FFF4E6;
}

/* Print should remain readable on paper */
@media print {
    html[data-theme="dark"] body,
    html[data-theme="dark"] .panel,
    html[data-theme="dark"] .success-hero {
        background: #ffffff !important;
        color: #222222 !important;
        box-shadow: none !important;
    }
}















</style>
</head>

<body>

<div class="food-float food-one">🍕</div>
<div class="food-float food-two">🍔</div>
<div class="food-float food-three">🍟</div>
<div class="food-float food-four">🍰</div>

<header class="navbar">
   <%@ include file="navbar.jsp" %>
</header>

<main class="page">

    <!-- ORDER SUCCESS CELEBRATION -->
    <section class="success-hero" id="successHero">
        <div class="confetti-layer" id="confettiLayer"></div>

        <div class="celebration">🎉 🥳 🎉</div>
        <div class="success-check">✓</div>

        <h1>Order placed <span>successfully!</span></h1>
        <p>Your delicious food is getting ready.<br>
           Sit back, relax, and let TOMATO handle the rest!</p>

        <div class="order-chip">
            🍅 Order ID:
            <strong id="orderId">
                <%= request.getAttribute("orderId") != null
                    ? request.getAttribute("orderId") : "TOMATO-DEMO" %>
            </strong>
        </div>
    </section>

    <!-- DELIVERY TRACKER -->
    <section class="tracker-layout hidden" id="trackerLayout">

        <div class="panel">
            <div class="panel-heading">
                <h2>Track your delivery 🛵</h2>
                <span class="live-demo">
                    <span class="live-dot"></span>
                    DEMO TRACKER
                </span>
            </div>

            <div class="map" id="deliveryMap">

                <div class="park park-one"></div>
                <div class="park park-two"></div>

                <div class="map-label restaurant-label">
                    <span class="map-pin">🍽️</span>
                    <span>Restaurant</span>
                </div>

                <div class="map-label home-label">
                    <span class="map-pin">🏠</span>
                    <span>Your home</span>
                </div>

                <svg class="road" id="routeSvg"
                     viewBox="0 0 600 400"
                     preserveAspectRatio="none"
                     aria-label="Illustrative delivery route">

                    <path id="routePath"
                        d="M 70 90
                           C 140 90, 125 175, 210 175
                           S 290 65, 365 135
                           S 380 260, 465 260
                           S 515 315, 545 335"
                        class="route-base"/>

                    <path
                        d="M 70 90
                           C 140 90, 125 175, 210 175
                           S 290 65, 365 135
                           S 380 260, 465 260
                           S 515 315, 545 335"
                        class="route-line"/>

                    <path
                        d="M 70 90
                           C 140 90, 125 175, 210 175
                           S 290 65, 365 135
                           S 380 260, 465 260
                           S 515 315, 545 335"
                        class="route-progress"/>
                </svg>

                <div class="scooter" id="scooter" aria-label="Delivery scooter">
                    🛵
                </div>
            </div>

            <div class="map-footer">
                <span>📍 Restaurant → Your doorstep</span>
                <strong>Illustrative route</strong>
            </div>
        </div>

        <!-- ETA AND STATUS -->
        <aside class="panel eta-panel">

            <div class="eta-topline">Estimated delivery time</div>
            <div class="eta-number">
                <span id="etaValue">18</span>
                <span id="etaUnit">min</span>
            </div>
            <div class="eta-description" id="etaDescription">
                Your order is being prepared with care.
            </div>

            <div class="delivery-person">
                <div class="person-avatar">🛵</div>
                <div class="person-info">
                    <strong>TOMATO delivery partner</strong>
                    <span id="partnerStatus">Getting your order ready</span>
                </div>
                <span class="demo-pill">PREVIEW</span>
            </div>

            <h3 class="timeline-title">Delivery updates</h3>

            <ul class="timeline" id="timeline">
                <li class="done active" data-step="0">
                    <span class="step-icon">✓</span>
                    <div class="step-copy">
                        <strong>Order confirmed</strong>
                        <span>Your order has been received.</span>
                    </div>
                </li>

                <li data-step="1">
                    <span class="step-icon">2</span>
                    <div class="step-copy">
                        <strong>Preparing your food</strong>
                        <span>The restaurant is preparing your meal.</span>
                    </div>
                </li>

                <li data-step="2">
                    <span class="step-icon">3</span>
                    <div class="step-copy">
                        <strong>On the way</strong>
                        <span>Your delivery partner is heading to you.</span>
                    </div>
                </li>

                <li data-step="3">
                    <span class="step-icon">4</span>
                    <div class="step-copy">
                        <strong>Delivered</strong>
                        <span>Enjoy your delicious meal!</span>
                    </div>
                </li>
            </ul>

            <div class="action-row">
                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/restaurant.jsp">
                    🍔 Order more
                </a>

                <button class="btn btn-secondary" type="button"
                        onclick="window.print()">
                    🖨 Print
                </button>
            </div>

            <div class="note">
                💚 <strong>Tracking preview:</strong> The scooter, route,
                status updates, and ETA are animated for demonstration.
                Live driver location and real delivery estimates require
                delivery-tracking data from your backend.
            </div>
        </aside>
    </section>

    <footer class="footer">
        Made with ❤️ by <strong>TOMATO</strong> · Good food, happy moments.
    </footer>
</main>

<script>
/* ==================================================
   TOMATO ORDER SUCCESS — JAVASCRIPT
================================================== */

(function () {
    "use strict";

    const successHero = document.getElementById("successHero");
    const trackerLayout = document.getElementById("trackerLayout");
    const confettiLayer = document.getElementById("confettiLayer");
    const scooter = document.getElementById("scooter");
    const routeSvg = document.getElementById("routeSvg");
    const routePath = document.getElementById("routePath");
    const etaValue = document.getElementById("etaValue");
    const etaUnit = document.getElementById("etaUnit");
    const etaDescription = document.getElementById("etaDescription");
    const partnerStatus = document.getElementById("partnerStatus");
    const timelineSteps = Array.from(
        document.querySelectorAll("#timeline li")
    );

    const reducedMotion = window.matchMedia(
        "(prefers-reduced-motion: reduce)"
    ).matches;

    /* Celebration confetti */

    function createConfetti() {
        const colors = [
            "#f04438", "#238653", "#ffc857",
            "#ff8c69", "#77bd83", "#ffb3a7"
        ];

        for (let i = 0; i < 55; i++) {
            const piece = document.createElement("span");
            piece.className = "confetti";
            piece.style.left = Math.random() * 100 + "%";
            piece.style.background =
                colors[Math.floor(Math.random() * colors.length)];
            piece.style.animationDuration =
                (2.1 + Math.random() * 2.2) + "s";
            piece.style.animationDelay =
                (Math.random() * 1.2) + "s";
            piece.style.width = (5 + Math.random() * 6) + "px";
            piece.style.height = (7 + Math.random() * 10) + "px";

            confettiLayer.appendChild(piece);

            window.setTimeout(function () {
                piece.remove();
            }, 5500);
        }
    }

    createConfetti();

    /* Show delivery tracker after celebration */

    window.setTimeout(function () {
        trackerLayout.classList.remove("hidden");

        window.setTimeout(function () {
            trackerLayout.scrollIntoView({
                behavior: reducedMotion ? "auto" : "smooth",
                block: "start"
            });

            startDeliveryPreview();
        }, 150);
    }, 3000);

    /* Put the scooter at the beginning of the route */

    function positionScooter(progress) {
        const totalLength = routePath.getTotalLength();
        const point = routePath.getPointAtLength(
            totalLength * progress
        );

        const svgRect = routeSvg.getBoundingClientRect();
        const viewBox = routeSvg.viewBox.baseVal;

        const x = svgRect.left +
            (point.x / viewBox.width) * svgRect.width;

        const y = svgRect.top +
            (point.y / viewBox.height) * svgRect.height;

        const mapRect = document.getElementById(
            "deliveryMap"
        ).getBoundingClientRect();

        scooter.style.left = (x - mapRect.left) + "px";
        scooter.style.top = (y - mapRect.top) + "px";
    }

    /* Responsive route positioning */

    function placeScooter(progress) {
        if (!routePath || !routeSvg) return;

        const point = routePath.getPointAtLength(
            routePath.getTotalLength() * progress
        );

        const viewBox = routeSvg.viewBox.baseVal;
        const svgRect = routeSvg.getBoundingClientRect();
        const mapRect = document.getElementById(
            "deliveryMap"
        ).getBoundingClientRect();

        const x = svgRect.left +
            (point.x / viewBox.width) * svgRect.width;

        const y = svgRect.top +
            (point.y / viewBox.height) * svgRect.height;

        scooter.style.left = (x - mapRect.left) + "px";
        scooter.style.top = (y - mapRect.top) + "px";
    }

    function updateTimeline(step) {
        timelineSteps.forEach(function (item, index) {
            item.classList.remove("done", "active");

            const icon = item.querySelector(".step-icon");

            if (index < step) {
                item.classList.add("done");
                icon.textContent = "✓";
            } else if (index === step) {
                item.classList.add("done", "active");
                icon.textContent = "●";
            } else {
                icon.textContent = String(index + 1);
            }
        });

        const statuses = [
            "Getting your order ready",
            "The restaurant is preparing your food",
            "Delivery partner is on the way",
            "Demo delivery complete"
        ];

        const descriptions = [
            "Your order is being prepared with care.",
            "Fresh food is getting packed for delivery.",
            "Your food is on its way in this tracking preview.",
            "The delivery animation has reached the destination."
        ];

        partnerStatus.textContent = statuses[step];
        etaDescription.textContent = descriptions[step];
    }

    function startDeliveryPreview() {
        if (!routePath || !routeSvg) return;

        if (reducedMotion) {
            placeScooter(1);
            updateTimeline(1);
            etaValue.textContent = "18";
            etaUnit.textContent = "min";
            return;
        }

        const duration = 16000;
        const startTime = performance.now();

        function animate(now) {
            const elapsed = now - startTime;
            const progress = Math.min(elapsed / duration, 1);

            /* Ease-in/ease-out movement */
            const easedProgress =
                progress < 0.5
                    ? 2 * progress * progress
                    : 1 - Math.pow(-2 * progress + 2, 2) / 2;

            placeScooter(easedProgress);

            if (progress < 0.25) {
                updateTimeline(1);
                etaValue.textContent = "18";
                etaUnit.textContent = "min";
            } else if (progress < 0.72) {
                updateTimeline(2);
                etaValue.textContent = "12";
                etaUnit.textContent = "min";
            } else if (progress < 1) {
                updateTimeline(2);
                etaValue.textContent = "5";
                etaUnit.textContent = "min";
            } else {
                updateTimeline(3);
                etaValue.textContent = "Arrived";
                etaUnit.textContent = "";
                etaDescription.textContent =
                    "The scooter reached the destination in this demo.";
                partnerStatus.textContent = "Demo route completed";
            }

            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        }

        requestAnimationFrame(animate);
    }

    /* Reposition the scooter if the browser window changes size */

    window.addEventListener("resize", function () {
        if (!trackerLayout.classList.contains("hidden")) {
            placeScooter(0.5);
        }
    });

    /* Initial scooter position */

    positionScooter(0);
})();
</script>

</body>
</html>