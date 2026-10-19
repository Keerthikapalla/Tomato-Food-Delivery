
/* =========================================================
   TOMATO PROFILE PAGE
   Edit / Cancel / Save + Profile Photo Preview
========================================================= */

document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("profileForm");

    if (!form) return;

    const username = document.getElementById("username");
    const phone = document.getElementById("phone");
    const address = document.getElementById("address");

    const editButton = document.getElementById("editProfile");
    const saveButton = document.getElementById("saveProfile");
    const cancelButton = document.getElementById("cancelEdit");

    const editBanner = document.getElementById("editModeBanner");
    const addressCounter = document.getElementById("addressCounter");

    const displayName = document.getElementById("profileDisplayName");
    const sidebarPhone = document.getElementById("sidebarPhone");
    const sidebarAddress = document.getElementById("sidebarAddress");

    const avatarFallback = document.getElementById("avatarFallback");
    const imagePreview = document.getElementById("profileImagePreview");
    const imageInput = document.getElementById("profileImageInput");
    const removeImageButton = document.getElementById("removeProfileImage");
    const imageMessage = document.getElementById("imageUploadMessage");

    const usernameError = document.getElementById("usernameError");
    const phoneError = document.getElementById("phoneError");

    const clientSuccessMessage = document.getElementById("clientSuccessMessage");
    const clientSuccessText = document.getElementById("clientSuccessText");

    const IMAGE_STORAGE_KEY = "tomatoProfileImage";
    const MAX_IMAGE_SIZE = 2 * 1024 * 1024;

    let submitting = false;

    let originalValues = {
        username: username.value,
        phone: phone.value,
        address: address.value
    };

    function getInitial(name) {
        const cleanName = (name || "").trim();
        return cleanName ? cleanName.charAt(0).toUpperCase() : "T";
    }

    function updatePreview() {
        displayName.textContent = username.value.trim() || "Tomato User";
        avatarFallback.textContent = getInitial(username.value);

        sidebarPhone.textContent = phone.value.trim() || "Not added yet";
        sidebarAddress.textContent = address.value.trim() || "Not added yet";

        addressCounter.textContent = `${address.value.length}/300`;
    }

    function setEditing(enabled) {
        username.readOnly = !enabled;
        phone.readOnly = !enabled;
        address.readOnly = !enabled;

        editButton.hidden = enabled;
        saveButton.hidden = !enabled;
        cancelButton.hidden = !enabled;
        editBanner.hidden = !enabled;

        if (enabled) {
            username.focus();
        }
    }

    function clearErrors() {
        usernameError.textContent = "";
        phoneError.textContent = "";

        username.classList.remove("invalid");
        phone.classList.remove("invalid");
    }

    function validateForm() {
        clearErrors();

        let valid = true;
        const name = username.value.trim();
        const phoneValue = phone.value.trim();

        if (!name) {
            usernameError.textContent = "Please enter your name.";
            username.classList.add("invalid");
            valid = false;
        } else if (name.length < 2) {
            usernameError.textContent = "Name must contain at least 2 characters.";
            username.classList.add("invalid");
            valid = false;
        }

        if (phoneValue && !/^[0-9+\-\s()]{7,15}$/.test(phoneValue)) {
            phoneError.textContent = "Please enter a valid phone number.";
            phone.classList.add("invalid");
            valid = false;
        }

        if (!valid) {
            const firstInvalid = form.querySelector(".invalid");
            if (firstInvalid) firstInvalid.focus();
        }

        return valid;
    }

    function showImageMessage(message, isError = false) {
        imageMessage.textContent = message;
        imageMessage.style.color = isError ? "#d53139" : "#218653";
    }

    function displayImage(dataUrl) {
        if (dataUrl) {
            imagePreview.src = dataUrl;
            imagePreview.hidden = false;
            avatarFallback.hidden = true;
            removeImageButton.hidden = false;
        } else {
            imagePreview.removeAttribute("src");
            imagePreview.hidden = true;
            avatarFallback.hidden = false;
            removeImageButton.hidden = true;
        }
    }

    function loadSavedImage() {
        try {
            const savedImage = localStorage.getItem(IMAGE_STORAGE_KEY);

            if (savedImage) {
                displayImage(savedImage);
            }
        } catch (error) {
            showImageMessage(
                "Browser storage is unavailable. Your photo may not be remembered.",
                true
            );
        }
    }

    function restoreOriginalValues() {
        username.value = originalValues.username;
        phone.value = originalValues.phone;
        address.value = originalValues.address;

        clearErrors();
        updatePreview();

        clientSuccessMessage.hidden = true;
        setEditing(false);
    }

    /* PROFILE PHOTO UPLOAD */

    imageInput.addEventListener("change", () => {
        const file = imageInput.files && imageInput.files[0];

        if (!file) return;

        const allowedTypes = [
            "image/jpeg",
            "image/png",
            "image/webp"
        ];

        if (!allowedTypes.includes(file.type)) {
            showImageMessage("Choose a JPG, PNG or WEBP image.", true);
            imageInput.value = "";
            return;
        }

        if (file.size > MAX_IMAGE_SIZE) {
            showImageMessage("Your image must be smaller than 2 MB.", true);
            imageInput.value = "";
            return;
        }

        const reader = new FileReader();

        reader.onload = () => {
            const imageData = reader.result;

            try {
                localStorage.setItem(IMAGE_STORAGE_KEY, imageData);
                displayImage(imageData);
                showImageMessage("Photo updated successfully in this browser.");
            } catch (error) {
                showImageMessage(
                    "Unable to save this image in browser storage. Try a smaller photo.",
                    true
                );
            }
        };

        reader.onerror = () => {
            showImageMessage(
                "Could not read the selected image. Please try another.",
                true
            );
        };

        reader.readAsDataURL(file);
    });

    /* REMOVE PROFILE PHOTO */

    removeImageButton.addEventListener("click", () => {
        try {
            localStorage.removeItem(IMAGE_STORAGE_KEY);
            displayImage(null);
            imageInput.value = "";
            showImageMessage("Photo removed from this browser.");
        } catch (error) {
            showImageMessage("Unable to remove the saved photo.", true);
        }
    });

    /* EDIT PROFILE */

    editButton.addEventListener("click", () => {
        clientSuccessMessage.hidden = true;
        setEditing(true);
    });

    /* CANCEL EDITING */

    cancelButton.addEventListener("click", restoreOriginalValues);

    /* LIVE PROFILE PREVIEW */

    username.addEventListener("input", () => {
        updatePreview();
        usernameError.textContent = "";
        username.classList.remove("invalid");
    });

    phone.addEventListener("input", () => {
        updatePreview();
        phoneError.textContent = "";
        phone.classList.remove("invalid");
    });

    address.addEventListener("input", updatePreview);

    /* SAVE PROFILE USING THE EXISTING SERVLET */

    form.addEventListener("submit", (event) => {
        if (!validateForm()) {
            event.preventDefault();
            return;
        }

        if (submitting) {
            event.preventDefault();
            return;
        }

        submitting = true;
        saveButton.disabled = true;
        cancelButton.disabled = true;
        saveButton.textContent = "Saving...";
    });

    /* HANDLE SERVER-SIDE VALIDATION ERRORS */

    const serverError = document.getElementById("serverErrorMessage");

    if (serverError) {
        setEditing(true);

        serverError.scrollIntoView({
            behavior: "smooth",
            block: "center"
        });
    } else {
        setEditing(false);
    }

    /* INITIALIZE PAGE */

    loadSavedImage();
    updatePreview();
});
