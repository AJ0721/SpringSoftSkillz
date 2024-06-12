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

    fetchThreadDetails(threadId);


    //BUTTONS
    // SUBMIT POST
    $(document).on('click', '.submit-reply', function (e) {
        e.preventDefault();
        const $form = $(this).closest('form');
        const postContent = $form.find('textarea').val().trim();
        const parentPostId = $form.find('.parentPostId').val();
        if (postContent === "") {
            Swal.fire('不接受無字天書 (╯>д<)╯', '', 'error');
            return;
        }
        const postDto = {
            postContent: postContent,
            thread: { threadId: threadId },
            parentPost: parentPostId ? { postId: parentPostId } : null,
        };
        submitPost(postDto, threadId);
    });

    // EDIT THREAD
    $(document).on('click', '#edit-thread', function (e) {
        e.preventDefault(); // Prevent default action

        console.log('Edit button clicked');  // Debugging statement
        const threadTitleElement = $('#threadTitle');
        const threadContentElement = $('#threadContent');
        const originalTitle = threadTitleElement.text().trim();
        const originalContent = threadContentElement.text().trim();

        // Make content editable
        threadTitleElement.attr('contenteditable', 'true').focus();
        threadContentElement.attr('contenteditable', 'true');

        // Hide the edit and delete buttons
        $('#edit-thread, #delete-thread').hide();

        // Show the update and cancel buttons
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

            const threadDto = {
                threadTitle: updatedTitle,
                threadContent: updatedContent,
            };
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
        Swal.fire({
            title: '確認是否刪除文章?',
            text: "",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
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





//--------------------THREAD--------------------


// CANCEL BUTTON: TO PREVIOUS PAGE
$('#cancel').click(function (e) {
    window.history.go(-1);
    return false;
});

// FUNCTION: DISPLAY THREAD DETAILS
function displayThreadDetails(data) {
    const { loggedInUser } = retrieveUser();
    const { authorName, canEdit, authorType } = getUserDetails(data, loggedInUser);

    $('#category').text(data.forumCategory.forumCategoryName);
    $('#username').text(authorName).attr('class', authorType);
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
        .then(

    )
        .catch(error => console.error('Error deleting thread:', error));
}
