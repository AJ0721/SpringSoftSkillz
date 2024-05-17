$(document).ready(function () {
    // Fetch thread details and comments
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];

    fetchThreadDetails(threadId);

    // SUBMIT ROOT POST
    $('#root-reply').click(function (e) {
        e.preventDefault();
        const postContent = $('#postContent').val();
        const postDto = {
            postContent: postContent,
            thread: { threadId: parseInt(threadId) },
            parentPost: null,
        };
        submitPost(postDto, threadId);
    });

    // CANCEL BUTTON
    $('#cancel').click(function (e) {
        window.history.go(-1);
        return false;
    });
});

// FUNCTION: FETCH THREAD DETAILS
function fetchThreadDetails(threadId) {
    fetch(`/forum/thread/find/id/${threadId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch data");
            }
            return response.json();
        })
        .then(data => {
            displayThreadDetails(data);
            fetchComments(threadId);
        })
        .catch(error => console.error('Error fetching thread details:', error));
}

// FUNCTION: DISPLAY THREAD DETAILS
function displayThreadDetails(data) {
    $('#category').text(data.forumCategory.forumCategoryName);

    let username = '管理員';
    if (data.student) {
        username = data.student.studentUsername;
    } else if (data.teacher) {
        username = data.teacher.teacherUserName;
    }

    $('#username').text(username);
    $('#threadTitle').text(data.threadTitle);
    $('#threadContent').text(data.threadContent);
}

// FUNCTION: FETCH ALL POSTS BY THREAD ID
function fetchComments(threadId) {
    fetch(`/forum/post/find-all/thread?id=${threadId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error("Failed to fetch comments");
            }
            return response.json();
        })
        .then(posts => {
            displayComments(posts, threadId);
        })
        .catch(error => console.error('Error fetching comments:', error));
}

// FUNCTION: DISPLAY POSTS IN COMMENT SECTION
function displayComments(posts, threadId) {
    const commentsSection = $('#commentsSection');
    commentsSection.empty();
    posts.sort((a, b) => new Date(b.postCreatedTime) - new Date(a.postCreatedTime));
    appendComments(posts, null, commentsSection);
    attachReplyButtonEvents(posts, threadId);
}

// FUNCTION: CREATE COMMENT HTML
function createCommentHtml(post) {
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
        <button class="btn btn-sm btn-secondary reply-btn" data-post-id="${post.postId}">回覆</button>
        <div class="reply-form-container"></div>
        <ul class="child-comments"></ul>
    </li>
    `;
}

// FUNCTION: APPEND COMMENTS RECURSIVELY
function appendComments(posts, parentPostId = null, parentElement) {
    posts.forEach(post => {
        if ((post.parentPost && post.parentPost.postId === parentPostId) || (!post.parentPost && !parentPostId)) {
            const commentHtml = createCommentHtml(post);
            parentElement.append(commentHtml);
            const commentElement = parentElement.find(`[data-post-id="${post.postId}"] .child-comments`);
            appendComments(posts, post.postId, commentElement);
        }
    });
}

// FUNCTION: ATTACH REPLY BUTTON EVENTS
function attachReplyButtonEvents(posts, threadId) {
    $('.reply-btn').click(function () {
        const postId = $(this).data('post-id');
        const replyFormHtml = `
        <form class="reply-form">
            <div class="form-group">
                <textarea class="form-control reply-content" rows="3"></textarea>
            </div>
            <button type="button" class="btn btn-secondary mt-2 cancel-reply">取消</button>
            <button type="submit" class="btn btn-primary mt-2">送出</button>
        </form>
        `;
        const commentElement = $(`[data-post-id="${postId}"] .reply-form-container`);
        commentElement.html(replyFormHtml);

        // CHILD REPLY SUBMIT
        commentElement.find('.reply-form').submit(function (e) {
            e.preventDefault();
            const postContent = commentElement.find('.reply-content').val();
            const postDto = {
                postContent: postContent,
                thread: { threadId: parseInt(threadId) },
                parentPost: { postId: parseInt(postId) }
            };

            submitPost(postDto, threadId);
        });

        // Handle reply form cancellation
        commentElement.find('.cancel-reply').click(function () {
            commentElement.empty();
        });
    });
}

// FUNCTION: SUBMIT POST
function submitPost(postDto, threadId) {
    fetch('/forum/post/insert', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(postDto)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to insert post');
            }
            return response.json();
        })
        .then(newPost => {
            console.log('New post:', newPost);
            $('#postContent').val('');
            $('#commentsSection').empty();
            fetchComments(threadId);
        })
        .catch(error => console.error('Error inserting post:', error));
}
