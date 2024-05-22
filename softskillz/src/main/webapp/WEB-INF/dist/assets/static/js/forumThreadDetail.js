$(document).ready(function () {

    //USER VALIDATION
    const { loggedInUser } = retrieveUser();
    validateUser(loggedInUser);
    displayUserDetails();


    // Fetch thread details and comments
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];

    //--------------------THREAD--------------------
<<<<<<< HEAD

    fetchThreadDetails(threadId);

    // EDIT THREAD
    $(document).on('click', '#edit-thread', function (e) {
        e.preventDefault(); // Prevent default action

        console.log('Edit button clicked');  // Debugging statement
        const threadTitleElement = $('#threadTitle');
        const threadContentElement = $('#threadContent');
        const originalTitle = threadTitleElement.text().trim();
        const originalContent = threadContentElement.text().trim();
=======

    fetchThreadDetails(threadId);

    // EDIT THREAD
    $(document).on('click', '#edit-thread', function (e) {
        e.preventDefault(); // Prevent default action

        console.log('Edit button clicked');  // Debugging statement
        const threadTitleElement = $('#threadTitle');
        const threadContentElement = $('#threadContent');
        const currentTitle = threadTitleElement.text().trim();
        const currentContent = threadContentElement.text().trim();

>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d

        // Make content editable
        threadTitleElement.attr('contenteditable', 'true').focus();
        threadContentElement.attr('contenteditable', 'true');

        // Hide the edit and delete buttons
        $('#edit-thread, #delete-thread').hide();

        // Show the update and cancel buttons
<<<<<<< HEAD
        $('#can-edit').html(`
            <div class="d-flex justify-content-end">
                <button class="btn btn-sm btn-primary me-2" id="update-thread">更新</button>
                <button class="btn btn-sm btn-secondary" id="cancel-edit-thread">取消</button>
            </div>
        `);

        // Update Button
        $(document).on('click', '#update-thread', function (e) {
            e.preventDefault();
            const updatedTitle = $('#threadTitle').text().trim();
            const updatedContent = $('#threadContent').text().trim();

            if (updatedTitle === "" || updatedContent === "") {

                Swal.fire('不接受無字天書 (╯>д<)╯', '', 'error');
                return;
            }

=======
        $('#can-edit').append(`
            <button class="btn btn-sm btn-primary me-2" id="update-thread">更新</button>
            <button class="btn btn-sm btn-secondary" id="cancel-edit-thread">取消</button>
        `);

        // Update Button
        $('#update-thread').off('click').on('click', function () {
            const updatedTitle = threadTitleElement.text().trim();
            const updatedContent = threadContentElement.text().trim();
            if (updatedTitle === "" || updatedContent === "") {
                Swal.fire('標題和內容不可空白 (╯>д<)╯', '', 'error');
                return;
            }
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
            const threadDto = {
                threadTitle: updatedTitle,
                threadContent: updatedContent,
            };
<<<<<<< HEAD
            console.log('Updating thread with data:', threadDto);
            updateThread(threadId, threadDto);
        });


    });



    // Cancel Edit Button
    $('#cancel-edit-thread').off('click').on('click', function (e) {
        e.preventDefault();
        threadTitleElement.text(originalTitle).attr('contenteditable', 'false');
        threadContentElement.text(originalContent).attr('contenteditable', 'false');
        $('#update-thread, #cancel-edit-thread').remove();
        $('#edit-thread, #delete-thread').show(); // Show the edit and delete buttons again
    });

    // DELETE THREAD
    $(document).on('click', '#delete-thread', function (e) {
        e.preventDefault();
=======
            updateThread(threadId, threadDto);
        });

        // Cancel Edit Button
        $('#cancel-edit-thread').off('click').on('click', function () {
            threadTitleElement.text(currentTitle).attr('contenteditable', 'false');
            threadContentElement.text(currentContent).attr('contenteditable', 'false');
            $('#update-thread, #cancel-edit-thread').remove();
            $('#edit-thread, #delete-thread').show(); // Show the edit and delete buttons again
        });
    });


    // DELETE THREAD
    $(document).on('click', '#delete-thread', function (e) {
        e.preventDefault(); // Prevent default action
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
        Swal.fire({
            title: '確認是否刪除文章?',
            text: "",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
<<<<<<< HEAD
                return deleteThread(threadId);
            } else {
                return Promise.reject('Delete canceled');
            }
        }).then(() => {
            return Swal.fire({
                title: '文章已刪除',
                text: '',
                icon: 'success',

            });
        }).then(() => {
            window.location.href = '/forum/adminhome#nav-thread'; // Redirect to the home or thread list page
        }).catch((error) => {
            if (error !== 'Delete canceled') {
                Swal.fire('錯誤', '刪除失敗，請重試。', 'error');
            }
        });
    })
});





=======
                deleteThread(threadId);
            }
        });
    });




});

>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
//--------------------THREAD--------------------


// CANCEL BUTTON: TO PREVIOUS PAGE
$('#cancel').click(function (e) {
    window.history.go(-1);
    return false;
});

// FUNCTION: DISPLAY THREAD DETAILS
function displayThreadDetails(data) {
<<<<<<< HEAD
    const { loggedInUser } = retrieveUser();
    const { authorName, canEdit } = getUserDetails(data, loggedInUser);
=======
    const { loggedInUser } = retrieveUser();
    const { authorName, canEdit } = getUserDetails(data, loggedInUser);

    $('#category').text(data.forumCategory.forumCategoryName);
    $('#username').text(authorName);
    $('#threadTitle').text(data.threadTitle);
    $('#threadContent').text(data.threadContent);

    if (canEdit) {
        $('#can-edit').html(`
        <div class="d-flex justify-content-end">
                <button class="btn btn-sm btn-warning me-2" id="edit-thread">編輯</button>
                <button class="btn btn-sm btn-danger" id="delete-thread">刪除</button>
            </div>
            `);
    }
}

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

// FUNCTION: UPDATE THREAD
function updateThread(threadId, threadDto) {
    fetch(`/forum/thread/update/${threadId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(threadDto)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update thread');
            }
            return response.json();
        })
        .then(updatedThread => {
            Swal.fire("更新成功", "", "success");
            console.log('Updated thread:', updatedThread);
            fetchThreadDetails(updatedThread.threadId);
        })
        .catch(error => console.error('Error updating thread:', error));
}

// FUNCTION: DELETE THREAD
function deleteThread(threadId) {
    fetch(`/forum/thread/delete/${threadId}`, {
        method: 'DELETE'
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete thread');
            }
            console.log('Deleted thread ID:', threadId);
            window.history.go(-1);
        })
        .catch(error => console.error('Error deleting thread:', error));
}





//--------------------POST--------------------

//FUNCTION: POST CAN EDIT (COMMENT HTML) 
function createCommentHtml(post) {

    const { loggedInUser } = retrieveUser();
    const { authorId, authorName, canEdit = false } = getUserDetails(post, loggedInUser);
    const formattedDate = new Date(post.postCreatedTime).toLocaleString();
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d

    $('#category').text(data.forumCategory.forumCategoryName);
    $('#username').text(authorName);
    $('#threadTitle').text(data.threadTitle);
    $('#threadContent').text(data.threadContent);

    if (canEdit) {
        $('#can-edit').html(`
        <div class="d-flex justify-content-end">
                <button class="btn btn-sm btn-warning me-2" id="edit-thread">編輯</button>
                <button class="btn btn-sm btn-danger" id="delete-thread">刪除</button>
            </div>
            `);
    }
}


// FUNCTION: UPDATE THREAD
function updateThread(threadId, threadDto) {
    fetch(`/forum/thread/update/${threadId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(threadDto)
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to update thread');
            }
            return response.json();
        })
        .then(updatedThread => {
            console.log('Updated thread:', updatedThread);
            Swal.fire({
                title: '更新成功',
                text: '',
                icon: 'success',
                showConfirmButton: true
            })
            fetchThreadDetails(updatedThread.threadId);


        })
        .catch(error => {
            console.error('Error updating thread:', error);

        });
}

// FUNCTION: DELETE THREAD
function deleteThread(threadId) {
    fetch(`/forum/thread/delete/${threadId}`, {
        method: 'DELETE'
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Failed to delete thread');
            }
            console.log('Deleted thread ID:', threadId);

        })
<<<<<<< HEAD
        .then(

    )
        .catch(error => console.error('Error deleting thread:', error));
=======
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
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d
}
