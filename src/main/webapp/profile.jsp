
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>

<%
    User profileUser = (User) request.getAttribute("profileUser");
    String contextPath = request.getContextPath();
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");

    String profileName = profileUser != null && profileUser.getUsername() != null
            ? profileUser.getUsername() : "Tomato User";
    String profileEmail = profileUser != null && profileUser.getEmail() != null
            ? profileUser.getEmail() : "";
    String profilePhone = profileUser != null && profileUser.getPhone() != null
            ? profileUser.getPhone() : "";
    String profileAddress = profileUser != null && profileUser.getAddress() != null
            ? profileUser.getAddress() : "";
    String profileInitial = profileName.trim().isEmpty()
            ? "T" : profileName.trim().substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TOMATO | My Profile</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

  
	<link rel="stylesheet" href="<%= contextPath %>/profile.css">

<script src="<%= contextPath %>/profile.js" defer></script>
</head>

<body>

   <%@ include file="navbar.jsp" %>

    <!-- Clearly visible floating food emojis -->
    <div class="floating-food" aria-hidden="true">
        <span>🍅</span>
        <span>🍕</span>
        <span>🍔</span>
        <span>🍟</span>
        <span>🥗</span>
        <span>🍓</span>
        <span>🍜</span>
        <span>🧁</span>
        <span>🥑</span>
        <span>🍩</span>
        <span>🍒</span>
        <span>🍰</span>
        <span>🍉</span>
        <span>🍪</span>
        <span>🌮</span>
        <span>🍇</span>
    </div>

    <main class="profile-page">

        <!-- PREMIUM TOMATO HEADER -->
        <section class="profile-banner">
            <div class="banner-glow banner-glow-one"></div>
            <div class="banner-glow banner-glow-two"></div>

            <div class="banner-content">
                <span class="banner-eyebrow">
                    <span class="eyebrow-tomato">🍅</span>
                    YOUR TOMATO ACCOUNT
                </span>

                <h1>My <span>Profile</span></h1>

                <p>
                    Manage your details and keep your account up to date.
                </p>

                <div class="banner-bottom-line">
                    <span class="banner-line"></span>
                    <span>YOUR FOOD. YOUR ACCOUNT. YOUR TOMATO.</span>
                </div>
            </div>

            <div class="banner-artwork" aria-hidden="true">
                <div class="banner-ring banner-ring-one"></div>
                <div class="banner-ring banner-ring-two"></div>
                <div class="banner-tomato">🍅</div>
                <span class="banner-food banner-food-one">🍕</span>
                <span class="banner-food banner-food-two">🍓</span>
                <span class="banner-food banner-food-three">🥑</span>
                <span class="banner-food banner-food-four">✨</span>
            </div>
        </section>

        <% if (successMessage != null && !successMessage.isEmpty()) { %>
            <div class="message success-message" role="status">
                <span>✓</span>
                <%= successMessage %>
            </div>
        <% } %>

        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="message error-message" id="serverErrorMessage" role="alert">
                <span>!</span>
                <%= errorMessage %>
            </div>
        <% } %>

        <div class="profile-layout">

            <!-- LEFT ACCOUNT CARD -->
            <aside class="account-card">

                <div class="account-card-heading">
                    <span class="heading-tomato">🍅</span>
                    <div>
                        <span class="account-heading-label">YOUR ACCOUNT</span>
                        <h2>Account overview</h2>
                    </div>
                </div>

                <div class="avatar-section">
                    <div class="avatar-frame">
                        <img id="profileImagePreview"
                             class="profile-image"
                             alt="Profile photo"
                             hidden>

                        <div id="avatarFallback" class="avatar-fallback">
                            <%= profileInitial %>
                        </div>

                        <span class="avatar-status" title="Account profile"></span>
                    </div>

                    <h3 id="profileDisplayName"><%= profileName %></h3>
                    <p class="avatar-caption">Your personal space on Tomato</p>

                    <label for="profileImageInput" class="upload-photo-button">
                        <span>📷</span> Upload photo
                    </label>

                    <input type="file"
                           id="profileImageInput"
                           accept="image/png,image/jpeg,image/webp"
                           hidden>

                    <button type="button"
                            id="removeProfileImage"
                            class="remove-photo-button"
                            hidden>
                        Remove photo
                    </button>

                    <p class="photo-hint">JPG, PNG or WEBP · Max 2 MB</p>
                    <p id="imageUploadMessage" class="image-message" aria-live="polite"></p>
                </div>

                <div class="account-divider"></div>

                <div class="account-info">

                    <div class="info-row">
                        <span class="info-icon">✉️</span>
                        <div class="info-content">
                            <span class="info-label">EMAIL ADDRESS</span>
                            <p id="sidebarEmail"><%= profileEmail.isEmpty() ? "Not available" : profileEmail %></p>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-icon">📱</span>
                        <div class="info-content">
                            <span class="info-label">PHONE NUMBER</span>
                            <p id="sidebarPhone"><%= profilePhone.isEmpty() ? "Not added yet" : profilePhone %></p>
                        </div>
                    </div>

                    <div class="info-row">
                        <span class="info-icon">📍</span>
                        <div class="info-content">
                            <span class="info-label">DELIVERY ADDRESS</span>
                            <p id="sidebarAddress"><%= profileAddress.isEmpty() ? "Not added yet" : profileAddress %></p>
                        </div>
                    </div>

                </div>

                <div class="account-tip">
                    <span>💚</span>
                    <p>Your next favourite meal is just around the corner.</p>
                </div>

            </aside>

            <!-- RIGHT PROFILE DETAILS CARD -->
            <section class="details-card">

                <div class="details-header">
                    <div>
                        <span class="section-eyebrow">PERSONAL INFORMATION</span>
                        <h2>Profile details</h2>
                        <p>Keep your contact information up to date.</p>
                    </div>

                    <span class="details-header-icon">✏️</span>
                </div>

                <div id="editModeBanner" class="edit-banner" hidden>
                    <span>✏️</span>
                    You are editing your profile. Save your changes when finished.
                </div>

                <form id="profileForm"
                      action="<%= contextPath %>/profile"
                      method="post"
                      novalidate>

                    <div class="form-grid">

                        <div class="form-group">
                            <label for="username">Full name</label>
                            <div class="input-wrap">
                                <span class="field-icon">👤</span>
                                <input type="text"
                                       id="username"
                                       name="username"
                                       value="<%= profileName %>"
                                       placeholder="Enter your name"
                                       maxlength="80"
                                       autocomplete="name"
                                       readonly>
                            </div>
                            <small id="usernameError" class="field-error"></small>
                            <small class="field-hint">Your name shown on your account.</small>
                        </div>

                        <div class="form-group">
                            <label for="email">Email address</label>
                            <div class="input-wrap">
                                <span class="field-icon">✉️</span>
                                <input type="email"
                                       id="email"
                                       value="<%= profileEmail %>"
                                       readonly>
                                <span class="verified-mark" title="Email cannot be edited here">✓</span>
                            </div>
                            <small class="field-hint">Email cannot be changed here.</small>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone number</label>
                            <div class="input-wrap">
                                <span class="field-icon">📱</span>
                                <input type="tel"
                                       id="phone"
                                       name="phone"
                                       value="<%= profilePhone %>"
                                       placeholder="Enter your phone number"
                                       maxlength="15"
                                       autocomplete="tel"
                                       readonly>
                            </div>
                            <small id="phoneError" class="field-error"></small>
                            <small class="field-hint">Enter a valid contact number.</small>
                        </div>

                        <div class="form-group address-group">
                            <div class="label-line">
                                <label for="address">Delivery address</label>
                                <span id="addressCounter">0/300</span>
                            </div>

                            <div class="input-wrap textarea-wrap">
                                <span class="field-icon address-icon">📍</span>
                                <textarea id="address"
                                          name="address"
                                          rows="3"
                                          maxlength="300"
                                          placeholder="House number, street, area, city..."
                                          autocomplete="street-address"
                                          readonly><%= profileAddress %></textarea>
                            </div>

                            <small class="field-hint">Keep your delivery address accurate.</small>
                        </div>

                    </div>

                    <div id="clientSuccessMessage" class="client-success" hidden>
                        <span>✓</span>
                        <span id="clientSuccessText">Your changes have been saved.</span>
                    </div>

                    <div class="form-actions">
                        <button type="button"
                                id="cancelEdit"
                                class="button button-light"
                                hidden>
                            Cancel
                        </button>

                        <button type="button"
                                id="editProfile"
                                class="button button-primary">
                            ✏️ Edit profile
                        </button>

                        <button type="submit"
                                id="saveProfile"
                                class="button button-primary"
                                hidden>
                            ✓ Save changes
                        </button>
                    </div>

                </form>

                <div class="privacy-note">
                    <span class="privacy-icon">🔒</span>
                    <div>
                        <strong>Your information matters</strong>
                        <p>Your account details are managed through your Tomato profile.</p>
                    </div>
                </div>

            </section>

        </div>

        <p class="page-footer-note">Made with <span>♥</span> for your next delicious meal.</p>

    </main>

    <%@ include file="Footer.jsp" %>

    <script src="<%= contextPath %>/profile.js" defer></script>

</body>
</html>
