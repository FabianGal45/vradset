
// Check if the title inoput box is displayed after 2 seconds. If not it's likely the User uses Adblocker 
document.addEventListener("DOMContentLoaded", (event) => {
    setTimeout(function() {
        // Check if the user is on /advertisements/new route
        if(window.location.pathname === "/advertisements/new"){
            // Grab the title box id and the title label
            var titleInputBox = document.getElementById("advertisement_title");
            var titleLabel = document.querySelector("label[for='advertisement_title']");
            if (!titleInputBox) {
                // Replace the title label with the following text and make it red
                titleLabel.textContent = "If you cannot see the title field, please disable all ad blockers.";
                titleLabel.classList.add("text-danger");
            }
        }
    }, 2000); // Run after 2 seconds
});