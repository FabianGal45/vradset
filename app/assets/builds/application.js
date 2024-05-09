(() => {
})();
//# sourceMappingURL=/assets/application.js.map

// These are required to allow the delete method to work from a link_to tag
import Rails from '@rails/ujs';
Rails.start();


// Check if the title inoput box is displayed after 2 seconds. If not it's likely the User uses Adblocker 
document.addEventListener("DOMContentLoaded", (event) => {
    setTimeout(function() {
        var titleInputBox = document.getElementById("advertisement_title");
        var titleLabel = document.querySelector("label[for='advertisement_title']");
        if (!titleInputBox) {
            titleLabel.textContent = "If you cannot see the title field, please disable all ad blockers.";
            titleLabel.classList.add("text-danger");
        }
    }, 2000); // Run after 2 seconds
});