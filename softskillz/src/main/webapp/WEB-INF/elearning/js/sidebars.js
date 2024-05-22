document.addEventListener('DOMContentLoaded', function () {

    // Load left sidebar
    fetch('/elearning/forum/template/leftbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('leftSidebarContainer').innerHTML = html;
            // Fetch and display categories
            fetchCategories().then(categories => {
                const categoryList = document.getElementById('categoryList');
                categoryList.innerHTML = '';
                categories.forEach(category => {
                    const categoryItem = `<a href="#" class="list-group-item list-group-item-action border rounded-3 m-1">${category.forumCategoryName}</a>`;
                    categoryList.insertAdjacentHTML('beforeend', categoryItem);
                });
            });
        })
        .catch(error => console.error('Error loading left sidebar:', error));

    // Load right sidebar
    fetch('/elearning/forum/template/rightbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('rightSidebarContainer').innerHTML = html;

            document.getElementById('createThreadButton').addEventListener('click', function () {
                window.location.href = '/forum/f/thread/insert';
            });

            const { loggedInUser, userType } = retrieveUser();
            // if (loggedInUser === null) {
            //     window.location.href = '/softskillz/fhomepage'
            //     return;
            // }
            const { userId } = getLoggedInUserDetails(loggedInUser);

            // Construct URL based on user type and user ID
            const url = `/forum/f/thread/user/${userType}/${userId}`;

            // Set the href attribute of the anchor tag
            $('#my-threads-link').attr('href', url);

        })
        .catch(error => console.error('Error loading right sidebar:', error));
});

// Fetch categories function
function fetchCategories() {
    return fetch('/forum/category/find-all')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        });
}
