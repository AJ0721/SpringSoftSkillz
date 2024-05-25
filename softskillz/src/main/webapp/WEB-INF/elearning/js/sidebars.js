document.addEventListener('DOMContentLoaded', function () {
    loadSidebars();
    validateUser().then(user => {
        if (user) {
            loggedInUser = user.loggedInUser;
            userType = user.userType;
            updateNavbar(userType);
        } else {
            loadNavbars(); // Load default navbars if no user is logged in
        }
      
    });
});

function loadSidebars() {
    // Load left sidebar
    fetch('/elearning/forum/template/leftbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('leftSidebarContainer').innerHTML = html;
            fetchCategories().then(categories => {
                const categoryList = document.getElementById('categoryList');
                categoryList.innerHTML = '';
                categories.forEach(category => {
                    const categoryItem = `<a href="#" class="list-group-item list-group-item-action border rounded-3 m-1" data-category-id="${category.forumCategoryId}">${category.forumCategoryName}</a>`;
                    categoryList.insertAdjacentHTML('beforeend', categoryItem);
                });

                // Add event listeners to category items
                document.querySelectorAll('#categoryList .list-group-item').forEach(item => {
                    item.addEventListener('click', function (event) {
                        event.preventDefault();
                        const categoryId = this.getAttribute('data-category-id');
                        fetchThreadsByCategory(categoryId);
                    });
                });
            });
        })
        .catch(error => console.error('Error loading left sidebar:', error));

    // Load right sidebar
    fetch('/elearning/forum/template/rightbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('rightSidebarContainer').innerHTML = html;

            // Attach event listeners for buttons after loading the sidebar
            document.getElementById('createThreadButton').addEventListener('click', function () {
                checkAndValidateUser().then(user => {
                    if (user) {
                        window.location.href = '/forum/f/thread/insert';
                    }
                });
            });
            document.getElementById('myThreadsButton').addEventListener('click', function (event) {
                event.preventDefault(); // Prevent default action
                checkAndValidateUser().then(user => {
                    if (user) {
                        const { userType, userId } = getLoggedInUserDetails(user.loggedInUser, user.userType);
                        window.location.href = `/forum/f/user/${userType}/${userId}`;
                    }
                });
            });

            // Display user details in the right sidebar
            const { loggedInUser, userType } = retrieveUser();
            if (loggedInUser) {
                const { userId } = getLoggedInUserDetails(loggedInUser, userType);
                const url = `/forum/f/user/${userType}/${userId}`;
                $('#my-threads-link').attr('href', url);
            }
        })
        .catch(error => console.error('Error loading right sidebar:', error));
}

function fetchThreadsByCategory(categoryId) {
    fetch(`/forum/thread/category/${categoryId}`)
        .then(response => response.json())
        .then(threads => {
            const threadContent = document.getElementById('threadList');
            threadContent.innerHTML = '';
            displayThreads(threads);
            document.getElementById('user-detail').innerHTML = userDetailContent;
        })
        .catch(error => console.error('Error fetching threads by category:', error));
}

function loadNavbars() {
    // Load default navbar
    fetch('/elearning/forum/template/guestNavbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('navbarContainer').innerHTML = html;
            initializePage();
        })
        .catch(error => console.error('Error loading default navbar:', error));

    // Load student navbar
    fetch('/elearning/forum/template/studentNavbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('navbarStudent').innerHTML = html;
        })
        .catch(error => console.error('Error loading student navbar:', error));

    fetch('/elearning/forum/template/teacherNavbar.html')
        .then(response => response.text())
        .then(html => {
            document.getElementById('navbarTeacher').innerHTML = html;
        })
        .catch(error => console.error('Error loading student navbar:', error));
}

function updateNavbar(userType) {
    let navbarUrl = '/elearning/forum/template/guestNavbar.html'; // Default to guest navbar

    if (userType === 'STUDENT') {
        navbarUrl = '/elearning/forum/template/studentNavbar.html';
    } else if (userType === 'TEACHER') {
        navbarUrl = '/elearning/forum/template/teacherNavbar.html';
    }

    fetch(navbarUrl)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text();
        })
        .then(html => {
            document.getElementById('navbarContainer').innerHTML = html;
        })
        .catch(error => console.error(`Error loading ${userType} navbar:`, error));
}
