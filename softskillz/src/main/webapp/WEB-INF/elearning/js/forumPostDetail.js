$(document).ready(function () {
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];

    //--------------------POST--------------------

    // SUBMIT POST
    $(document).on('click', '.reply-btn', function () {
        const postId = $(this).data('post-id');

        // Hide all buttons
        $('.edit-btn, .delete-btn, .reply-btn').hide();

        const replyFormHtml = `
            <form class="reply-form mt-2">
                <div class="form-group ">
                    <textarea class="form-control border border-4 rounded-4 reply-content" rows="3"></textarea>
                </div>
                <div class="d-flex justify-content-end mb-2">
                    <button type="button" class="btn btn-secondary mt-2 cancel-reply me-2">取消</button>
                    <button type="submit" class="submit-reply btn btn-primary mt-2">送出</button>
                </div>
                <input type="hidden" class="parentPostId" value="${postId}">
            </form>
        `;
        const commentElement = $(this).closest('li').find('.reply-form-container').first();
        commentElement.html(replyFormHtml);

        // Cancel Reply Button
        $(document).one('click', '.cancel-reply', function () {
            $(this).closest('.reply-form-container').empty();

            // Restore all buttons
            $('.edit-btn, .delete-btn, .reply-btn').show();
        });

        // Submit Reply Button
        $(document).getElementById('commentsSection').one('click', '.submit-reply', function (e) {
            e.preventDefault();
            const replyContent = $(this).closest('form').find('.reply-content').val().trim();
            if (replyContent === "") {
                Swal.fire('不接受無字天書 (╯>д<)╯', '', 'error');
                return;
            }
            const parentPostId = $(this).closest('form').find('.parentPostId').val();
            const postDto = {
                postContent: replyContent,
                parentPost: { postId: parentPostId },
                thread: { threadId: threadId }
            };
            submitPost(postDto, threadId);

            // Restore all buttons
            $('.edit-btn, .delete-btn, .reply-btn').show();
        });
    });

    // EDIT POST
    $(document).on('click', '.edit-btn', function () {
        const postId = $(this).data('post-id');
        const postElement = $(this).closest('li');
        const postContentElement = postElement.find('.post-content').first();
        const currentContent = postContentElement.text().trim();

        // Hide all buttons
        $('.edit-btn, .delete-btn, .reply-btn').hide();

        // Make content editable
        postContentElement.attr('contenteditable', 'true').focus();

        // Show the update and cancel buttons
        $(this).after(`
            <button class="btn btn-sm btn-primary update-btn me-2" data-post-id="${postId}">更新</button>
            <button class="btn btn-sm btn-secondary cancel-edit" data-post-id="${postId}">取消</button>
        `);

        // Update Button
        $(document).one('click', '.update-btn', function () {
            const updatedContent = postContentElement.text().trim();
            if (updatedContent === "") {
                Swal.fire('不接受無字天書 (╯>д<)╯', '', 'error');
                return;
            }
            const postDto = {
                postContent: updatedContent,
                thread: { threadId: threadId }
            };
            updatePost(postId, postDto);

            // Restore all buttons
            $('.edit-btn, .delete-btn, .reply-btn').show();
            postElement.find('.update-btn, .cancel-edit').remove();
            postContentElement.attr('contenteditable', 'false');
        });

        // Cancel Edit Button
        $(document).one('click', '.cancel-edit', function () {
            postContentElement.text(currentContent).attr('contenteditable', 'false');
            $(this).siblings('.update-btn').remove();
            $(this).remove();

            // Restore all buttons
            $('.edit-btn, .delete-btn, .reply-btn').show();
        });
    });

    // DELETE POST
    $(document).on('click', '.delete-btn', function () {
        const postId = $(this).data('post-id');
        Swal.fire({
            title: '確認是否刪除留言?',
            text: "",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                deletePost(postId);
            }
        });
    });

    // Fetch comments on page load
    fetchComments(threadId);
});

function deletePost(postId) {
    fetch(`/forum/post/soft-delete/${postId}`, {
        method: 'DELETE'
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete post');
            }

            console.log('Deleted post ID:', postId);
            // Select the post element by its specific id
            const postElement = $(`li[data-post-id="${postId}"]`);
            // Ensure only the selected post's content is updated
            postElement.children('.post-content').text('已刪除').addClass('deleted-post');
            // Hide the action buttons for the deleted post
            postElement.children('.post-actions').find('.edit-btn, .delete-btn, .reply-btn').hide();
        })
        .catch(error => console.error('Error deleting post:', error));
}


// Ensure that child posts are not affected
function createCommentHtml(post) {
    const { loggedInUser } = retrieveUser();
    const { authorType, authorName, canEdit = false } = getUserDetails(post, loggedInUser);
    const formattedDate = new Date(post.postCreatedTime).toLocaleString();

    return `
    <li class="list-unstyled comment border-start border-primary border-3 p-2 ml-0 mb-3 pl-0" data-post-id="${post.postId}">
        <div class="d-flex justify-content-between align-items-center mb-0">
            <div class="d-flex justify-content-start">   
                <p class="me-3 ${authorType}"><strong>${authorName}</strong></p> class="">
                <span class="text-muted">${formattedDate}</span>
            </div>
            <span class="d-flex post-actions">
                ${post.postStatus !== 'DELETED' ? `
                <button class="me-2 btn btn-success reply-btn border rounded-3" data-post-id="${post.postId}"><i class="bi bi-reply-fill"></i></button>
                ${canEdit ? `<button class="me-2 btn btn-warning edit-btn border rounded-3" data-post-id="${post.postId}"><i class="bi bi-pencil-square"></i></button>` : ''}
                ${canEdit ? `<button class="btn btn-danger delete-btn border rounded-3" data-post-id="${post.postId}"><i class="bi bi-trash"></i></button>` : ''}
                ` : ''}
            </span>
        </div>
        <p class="post-content p-2 ${post.postStatus === 'DELETED' ? 'deleted-post' : ''}">${post.postStatus === 'DELETED' ? '已刪除' : post.postContent}</p>
        <div class="reply-form-container"></div>
        <ul class="child-comments"></ul>
    </li>
    `;
}

// Ensure fetchComments handles both active and deleted posts correctly
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

function displayComments(posts, threadId) {
    const commentsSection = $('#commentsSection');
    commentsSection.empty();
    posts.sort((a, b) => new Date(b.postCreatedTime) - new Date(a.postCreatedTime));
    appendComments(posts, null, commentsSection);
    attachReplyButtonEvents(posts, threadId);
}

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

function attachReplyButtonEvents(posts, threadId) {
    $(document).on('click', '.reply-btn', function () {
        const postId = $(this).data('post-id');
        const replyFormHtml = `
        <form class="reply-form mt-2">
            <div class="form-group">
                <textarea class="form-control border border-4 rounded-4 reply-content" rows="3"></textarea>
            </div>
            <div class="d-flex justify-content-end mb-2">
                <button type="button" class="btn btn-secondary mt-2 cancel-reply me-2 border rounded-3">取消</button>
                <button type="submit" class="submit-reply btn btn-primary mt-2 border rounded-3">送出</button>
            </div>
            <input type="hidden" class="parentPostId" value="${postId}">
        </form>
        `;
        const commentElement = $(this).closest('li').find('.reply-form-container').first();
        commentElement.html(replyFormHtml);
    });

    $(document).on('click', '.cancel-reply', function () {
        $(this).closest('.reply-form-container').empty();
    });
}

function submitPost(postDto, threadId) {
    const { loggedInUser, userType } = retrieveUser();
    setUserToDto(postDto, loggedInUser, userType);

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
