$(document).ready(function () {

    // USER VALIDATION
    const { loggedInUser = {} } = retrieveUser() || {};    // validateUser


    // Fetch thread details and comments
    const pathname = window.location.pathname;
    const parts = pathname.split("/");
    const threadId = parts[parts.length - 1];

    //--------------------THREAD--------------------

    fetchThreadDetails(threadId);



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

    // DELETE THREAD
    $(document).on('click', '#delete-thread', function (e) {
        e.preventDefault();


        const threadId = $(this).data('thread-id');

        if (!loggedInUser) {
            Swal.fire('請先登入', '', 'warning');
            return;
        }

        Swal.fire({
            title: '確認是否刪除文章?',
            text: "",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                deleteThread(threadId);
                Swal.fire("刪除成功", "", "success")
                window.location.href = `/forum/home`
            }
        });
    });



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
    const { authorName, canEdit , authorType} = getUserDetails(data, loggedInUser);

    $('#category').text(data.forumCategory.forumCategoryName);

    // Apply the appropriate class based on the author's role


    $('#username').text(authorName).addClass(authorType);

    $('#threadTitle').text(data.threadTitle);
    $('#threadContent').text(data.threadContent);

    if (canEdit) {
        $('#can-edit').html(`
            <div class="d-flex justify-content-end">
                <button class="btn  btn-warning me-2  border rounded-3" id="edit-thread"><i class="bi bi-pencil-square "></i></button>
                <button class="btn  border rounded-3 btn-danger" id="delete-thread" data-thread-id="${data.threadId}"><i class="bi bi-trash"></i></button>
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
            Swal.fire({
                title: '更新成功',
                text: '',
                icon: 'success',
                confirmButtonText: '確認'
            });
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
            // Remove the deleted thread from the DOM
            Swal.fire({
                title: '刪除成功',
                text: '',
                icon: 'success',
                showConfirmButton: true
            });

        })
        .catch(error => {
            console.error('Error deleting thread:', error);
            Swal.fire('錯誤', '刪除失敗，請重試。', 'error');
        });
}




