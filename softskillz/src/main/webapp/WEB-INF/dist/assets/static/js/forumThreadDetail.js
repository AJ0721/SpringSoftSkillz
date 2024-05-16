
$(document).ready(function () {
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];

    fetch("/forum/thread/find/id/" + threadId)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch data");
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
            document.getElementById('category').innerHTML = data.forumCategory.forumCategoryName;

            let username = '管理員';
            if (data.student) {
                username = data.student.studentUsername;
            } else if (data.teacher) {
                username = data.teacher.teacherUserName;
            }

            document.getElementById('username').innerHTML = username;
            document.getElementById('threadTitle').innerHTML = data.threadTitle;
            document.getElementById('threadContent').innerHTML = data.threadContent;

            // Fetch comments for the thread
            fetchComments(threadId);
        })
        .catch(error => console.error('Error fetching thread details:', error));



    //PAGE REDIRECT
    $('#cancel').click(function (e) {
        window.location.href = '/forum/adminhome#nav-thread';
    });

});

// Fetch comments function
function fetchComments(threadId) {
    fetch("/forum/post/find-all/thread?id=" + threadId)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch comments");
            }
            return response.json();
        })
        .then(posts => {
            // Display comments
            displayComments(posts);
        })
        .catch(error => console.error('Error fetching comments:', error));
}

// Display comments function
function displayComments(posts) {
    const commentsSection = document.getElementById('commentsSection');
    commentsSection.innerHTML = ''; // Clear any existing comments

    // Sort posts by creation time in descending order
    posts.sort((a, b) => new Date(b.postCreatedTime) - new Date(a.postCreatedTime));

    // Create a map of comments by their IDs
    const commentMap = new Map();
    posts.forEach(post => {
        commentMap.set(post.postId, post);
    });

    // Function to create a comment HTML
    function createCommentHtml(post, level = 0) {
        let userId, userName, userType;
        if (post.student) {
            userId = post.student.studentId;
            userName = post.student.studentUsername;
            userType = '學生';
        } else if (post.teacher) {
            userId = post.teacher.teacherId;
            userName = post.teacher.teacherUserName;
            userType = '老師';
        } else if (post.admin) {
            userId = post.admin.adminId;
            userName = '';
            userType = '管理員';
        }

        const formattedDate = new Date(post.postCreatedTime).toLocaleString();

        return `
        <li class="comment border p-2 mb-2" data-post-id="${post.postId}">
            <p><strong>${userType} - ${userName} (${userId})</strong></p>
            <p>${post.postContent}</p>
            <p class="text-muted"><small>${formattedDate}</small></p>
            <ul class="child-comments"></ul>
        </li>
    `;
    }

    // Recursive function to append comments to their respective parents or the root
    function appendComments(posts, parentPostId = null, parentElement) {
        posts.forEach(post => {
            if (post.parentPost && post.parentPost.postId === parentPostId || (!post.parentPost && !parentPostId)) {
                const commentHtml = createCommentHtml(post);
                parentElement.innerHTML += commentHtml;
                const commentElement = parentElement.querySelector(`[data-post-id="${post.postId}"] .child-comments`);
                appendComments(posts, post.postId, commentElement);
            }
        });
    }

    appendComments(posts, null, commentsSection);
}


