$(document).ready(function () {
    // Fetch thread details and comments
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];


    //--------------------POST--------------------

    // SUBMIT POST
    // $(document).on('click', '.reply-btn', function () {
    //     const postId = $(this).data('post-id');
    
    //     // Hide all buttons
    //     $('.edit-btn, .delete-btn, .reply-btn').hide();
    
    //     const replyFormHtml = `
    //         <form class="reply-form mt-2">
    //             <div class="form-group ">
    //                 <textarea class="form-control border border-4 rounded-4 reply-content" rows="3"></textarea>
    //             </div>
    //             <div class="d-flex justify-content-end mb-2">
    //                 <button type="button" class="btn btn-secondary mt-2 cancel-reply me-2">取消</button>
    //                 <button type="submit" class="submit-reply btn btn-primary mt-2">送出</button>
    //             </div>
    //             <input type="hidden" class="parentPostId" value="${postId}">
    //         </form>
    //     `;
    //     const commentElement = $(this).closest('li').find('.reply-form-container').first();
    //     commentElement.html(replyFormHtml);
    
    //     // Cancel Reply Button
    //     $(document).one('click', '.cancel-reply', function () {
    //         $(this).closest('.reply-form-container').empty();
    
    //         // Restore all buttons
    //         $('.edit-btn, .delete-btn, .reply-btn').show();
    //     });
    
    //     // Submit Reply Button
    //     $(document).one('click', '.submit-reply', function (e) {
    //         e.preventDefault();
    //         const replyContent = $(this).closest('form').find('.reply-content').val().trim();
    //         if (replyContent === "") {
    //             Swal.fire('不接受無字天書 (╯>д<)╯', '', 'error');
    //             return;
    //         }
    //         const parentPostId = $(this).closest('form').find('.parentPostId').val();
    //         const postDto = {
    //             postContent: replyContent,
    //             parentPost: { postId: parentPostId },
    //             thread: { threadId: threadId }
    //         };
    //         submitPost(postDto, threadId);
    
    //         // Restore all buttons
    //         $('.edit-btn, .delete-btn, .reply-btn').show();
    //     });
    // });

    //EDIT POST

   
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

    //DELETE POST
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
});



//--------------------POST--------------------

//FUNCTION: POST CAN EDIT (COMMENT HTML) 
function createCommentHtml(post) {

    const { loggedInUser } = retrieveUser();
    const { authorId, authorName, canEdit = false } = getUserDetails(post, loggedInUser);
    const formattedDate = new Date(post.postCreatedTime).toLocaleString();

    return `
    <li class="list-unstyled comment border-start border-light border-3 p-2 mb-3 pl-0" data-post-id="${post.postId}">
    <div class="d-flex justify-content-between align-items-center mb-2">
        <p><strong>${authorName} (${authorId})</strong></p>
        <span class="d-flex">
            <button class="me-2 btn btn-sm btn-success reply-btn" data-post-id="${post.postId}">回覆</button>
            ${canEdit ? `<button class="me-2 btn btn-sm btn-warning edit-btn" data-post-id="${post.postId}">編輯</button>` : ''}
            ${canEdit ? `<button class="btn btn-sm btn-danger delete-btn" data-post-id="${post.postId}">刪除</button>` : ''}
        </span>
    </div>
    <p class="post-content p-2">${post.postContent}</p>
    <p class="text-muted"><small>${formattedDate}</small></p>
    <div class="reply-form-container"></div>
    <ul class="child-comments"></ul>
</li>
    `;
}


// FUNCTION: UPDATE POST
function updatePost(postId, postDto) {
    fetch(`/forum/post/update/${postId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(postDto)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update post');
            }
            return response.json();
        })
        .then(updatedPost => {
            Swal.fire("更新成功", "", "success");
            console.log('Updated post:', updatedPost);
            fetchComments(updatedPost.thread.threadId);
        })
        .catch(error => console.error('Error updating post:', error));
}


// FUNCTION: DELETE POST
function deletePost(postId) {
    fetch(`/forum/post/delete/${postId}`, {
        method: 'DELETE'
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete post');
            }

            console.log('Deleted post ID:', postId);
            $(`li[data-post-id="${postId}"]`).remove();
        })
        .catch(error => console.error('Error deleting post:', error));
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
    $(document).on('click', '.reply-btn', function () {
        const postId = $(this).data('post-id');
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
    });

    $(document).on('click', '.cancel-reply', function () {
        $(this).closest('.reply-form-container').empty();
    });
}
// FUNCTION: SUBMIT POST
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
