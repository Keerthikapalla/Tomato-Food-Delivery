
/* =========================================================
   TOMATO RESTAURANT PAGE
   Search + Cuisine Filters + Navigation + Tomato Animation
========================================================= */

document.addEventListener("DOMContentLoaded", function () {
    const body = document.body;

    const contextPath = body.dataset.contextPath || "";

    const searchInput = document.getElementById("searchInput");
    const clearSearch = document.getElementById("clearSearch");

    const restaurantGrid = document.getElementById("restaurantGrid");
    const noResults = document.getElementById("noResults");
    const subtitle = document.getElementById("restaurantSubtitle");

    const filterButtons = Array.from(
        document.querySelectorAll(".filter")
    );

    const resetFilters = document.getElementById("resetFilters");

    const cards = restaurantGrid
        ? Array.from(restaurantGrid.querySelectorAll(".restaurant-card"))
        : [];

    let activeCuisine = "all";


    /* ================= TEXT NORMALIZATION ================= */

    function normalize(value) {
        return String(value || "")
            .toLocaleLowerCase()
            .normalize("NFD")
            .replace(/[\u0300-\u036f]/g, "")
            .replace(/\s+/g, " ")
            .trim();
    }


    /* ================= CUISINE MATCHING ================= */

    function matchesCuisine(cardCuisine, selectedFilter) {
        if (selectedFilter === "all") {
            return true;
        }

        const cuisine = normalize(cardCuisine);
        const selected = normalize(selectedFilter);

        /*
         * The visible Italian button uses data-filter="Pizza".
         * Support common cuisine labels without changing database data.
         */
        const cuisineAliases = {
            "pizza": ["pizza", "italian"],
            "burgers": ["burger", "burgers", "american", "fast food"],
            "desserts": [
                "dessert", "desserts", "sweet", "sweets",
                "bakery", "cake", "ice cream"
            ],
            "south indian": ["south indian", "south-indian"],
            "north indian": ["north indian", "north-indian"],
            "chinese": ["chinese", "indo chinese", "indo-chinese"]
        };

        const alternatives = cuisineAliases[selected] || [selected];

        return alternatives.some(function (term) {
            return cuisine.includes(term);
        });
    }


    /* ================= SEARCH AND FILTER ================= */

    function filterRestaurants() {
        if (!restaurantGrid) {
            return;
        }

        const query = normalize(searchInput ? searchInput.value : "");

        let visibleCount = 0;

        cards.forEach(function (card) {
            const name = normalize(card.dataset.name);
            const cuisine = normalize(card.dataset.cuisine);
            const address = normalize(card.dataset.address);

            /*
             * Search across restaurant name, cuisine and address.
             * Matching is case-insensitive and supports partial words.
             */
            const matchesSearch =
                query === "" ||
                name.includes(query) ||
                cuisine.includes(query) ||
                address.includes(query);

            const matchesSelectedCuisine = matchesCuisine(
                card.dataset.cuisine,
                activeCuisine
            );

            const shouldShow = matchesSearch && matchesSelectedCuisine;

            card.hidden = !shouldShow;

            if (shouldShow) {
                visibleCount++;
            }
        });

        // Display the no-results message only when no card matches.
        if (noResults) {
            noResults.hidden = visibleCount > 0;
        }

        // Show the clear button only when the search has text.
        if (clearSearch && searchInput) {
            clearSearch.hidden = searchInput.value.length === 0;
        }

        // Update the subtitle with the filtered result count.
        if (subtitle) {
            if (query !== "" || activeCuisine !== "all") {
                subtitle.textContent =
                    visibleCount === 1
                        ? "1 restaurant found"
                        : visibleCount + " restaurants found";
            } else {
                subtitle.textContent =
                    "Discover the best restaurants in Bengaluru";
            }
        }
    }


    /* ================= LIVE SEARCH ================= */

    if (searchInput) {
        searchInput.addEventListener("input", filterRestaurants);

        searchInput.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                searchInput.value = "";
                filterRestaurants();
            }
        });
    }


    /* ================= CLEAR SEARCH ================= */

    if (clearSearch && searchInput) {
        clearSearch.addEventListener("click", function () {
            searchInput.value = "";
            filterRestaurants();
            searchInput.focus();
        });
    }


    /* ================= CUISINE FILTER BUTTONS ================= */

    filterButtons.forEach(function (button) {
        button.addEventListener("click", function () {
            filterButtons.forEach(function (item) {
                item.classList.remove("active");
            });

            button.classList.add("active");

            activeCuisine = button.dataset.filter || "all";

            filterRestaurants();
        });
    });


    /* ================= RESET ALL FILTERS ================= */

    if (resetFilters) {
        resetFilters.addEventListener("click", function () {
            activeCuisine = "all";

            if (searchInput) {
                searchInput.value = "";
            }

            filterButtons.forEach(function (button) {
                button.classList.toggle(
                    "active",
                    button.dataset.filter === "all"
                );
            });

            filterRestaurants();

            if (searchInput) {
                searchInput.focus();
            }
        });
    }


    /* ================= TOMATO ROPE MESSAGE ================= */

    const ropeTomato = document.getElementById("ropeTomato");
    const tomatoMessage = document.getElementById("tomatoMessage");

    if (ropeTomato && tomatoMessage) {
        const messages = [
            "Let's explore! 🍅",
            "Find your favourite! ❤️",
            "Something tasty awaits! 😋",
            "Good food, good mood! 🍽️"
        ];

        let messageIndex = 0;

        ropeTomato.addEventListener("click", function () {
            messageIndex = (messageIndex + 1) % messages.length;
            tomatoMessage.textContent = messages[messageIndex];
            tomatoMessage.style.opacity = "1";
            tomatoMessage.style.transform = "translateX(0)";
        });
    }


    /* ================= LOGO KEYBOARD SUPPORT ================= */

    const logo = document.querySelector(".logo");

    if (logo) {
        logo.addEventListener("keydown", function (event) {
            if (event.key === "Enter" || event.key === " ") {
                event.preventDefault();
                goHome();
            }
        });
    }


    /* ================= INITIAL FILTER STATE ================= */

    filterRestaurants();
});


/* ================= HOME NAVIGATION ================= */

function goHome() {
    const contextPath =
        document.body.dataset.contextPath || "";

    window.location.href = contextPath + "/restaurant";
}


/* ================= RESTAURANT MENU NAVIGATION ================= */

function viewMenu(restaurantId) {
    const contextPath =
        document.body.dataset.contextPath || "";

    window.location.href =
        contextPath +
        "/menu?restaurantId=" +
        encodeURIComponent(restaurantId);
}
