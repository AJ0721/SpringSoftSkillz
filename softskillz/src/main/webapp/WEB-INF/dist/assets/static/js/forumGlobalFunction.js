<<<<<<< HEAD
=======
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

    // EDIT THREAD
    $(document).on('click', '#edit-thread', function (e) {
        e.preventDefault(); // Prevent default action

        console.log('Edit button clicked');  // Debugging statement
        const threadTitleElement = $('#threadTitle');
        const threadContentElement = $('#threadContent');
        const currentTitle = threadTitleElement.text().trim();
        const currentContent = threadContentElement.text().trim();


        // Make content editable
        threadTitleElement.attr('contenteditable', 'true').focus();
        threadContentElement.attr('contenteditable', 'true');

        // Hide the edit and delete buttons
        $('#edit-thread, #delete-thread').hide();

        // Show the update and cancel buttons
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
            const threadDto = {
                threadTitle: updatedTitle,
                threadContent: updatedContent,
            };
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
>>>>>>> e4147c4ea8a33a128ade5cfded2b8544ac41532d

//--------------------USER--------------------
//USER VALIDATION
//GET LOGGED IN USER DTO
window.retrieveUser = function () {
    const loggedInUser = JSON.parse(sessionStorage.getItem('loggedInUser'));
    const userType = sessionStorage.getItem('userType');

    return { loggedInUser, userType };
}


window.validateUser = function (user) {
    if (!user) {
        window.location.href = '/admin/admin-loginPage';
        return;
    }
}

//DISPLAY LOGEGD IN USER DETAIL
window.displayUserDetails = function () {
    const { loggedInUser, userType } = retrieveUser();
    const username = getUserName(loggedInUser);
    const zhUserType = toZhUserType(userType);
    document.getElementById('user-detail').innerHTML =
        `
    <h6 class=" mb-0 text-primary" id="user-name">${zhUserType} ${username}</h6>
    `
}

//CONVERT USERTYPE TO MANDARIN FOR DISPLAY
window.toZhUserType = function (userType) {
    var zhUserType;
    switch (userType) {
        case "ADMIN":
            zhUserType = '管理員';
            break;
        case "STUDENT":
            zhUserType = '學生';
            break;
        case "TEACHER":
            zhUserType = '老師';
            break;
    }
    return zhUserType;
}

//GET LOGGED IN USER NAME
window.getUserName = function (user) {
    var username;
    switch (sessionStorage.getItem('userType')) {
        case "ADMIN":
            username = user.adminAccount;
            break;
        case "STUDENT":
            username = user.studentUsername;
            break;
        case "TEACHER":
            username = user.teacherUserName;
            break;
    }
    return username;
}


//GET POST/THREAD AUTHOR DETAILS TO DISPLAY
window.getUserDetails = function (dto, loggedInUser) {
    let authorId, authorName, authorType, canEdit = false;

    if (dto.student) {
        authorId = dto.student.studentId;
        authorName = `學生 ${dto.student.studentUsername}`;
        authorType = '學生';
        canEdit = loggedInUser.studentId === authorId;
    } else if (dto.teacher) {
        authorId = dto.teacher.teacherId;
        authorName = `老師 ${dto.teacher.teacherUserName}`;
        authorType = '老師';
        canEdit = loggedInUser.teacherId === authorId;
    } else if (dto.admin) {
        authorId = dto.admin.adminId;
        authorName = `管理員 ${dto.admin.adminAccount}`;
        authorType = '管理員';
        canEdit = loggedInUser.adminId === authorId;
    }

    return { authorId, authorName, authorType, canEdit };
}

//--------------------THREADS--------------------
//CREATE THREAD HTML
window.createThreadHtml = function (thread) {

    //VIEW REVISION
    let userId, userType;
    if (thread.student) {
        userId = (thread.student.studentId);
        userType = '學生';
    } else if (thread.teacher) {
        userId = (thread.teacher.teacherId);
        userType = '老師';
    } else if (thread.admin) {
        userId = (thread.admin.adminId);
        userType = '管理員';
    }


    // Format date to show only YYYY-MM-DD
    let formattedDate = thread.threadCreatedTime.split('T')[0];
    let status = thread.threadStatus;

    return `
    <tr class="text-nowrap">
        <td><input class="form-check-input" type="checkbox"></td>
        <td>${thread.threadId}</td>
         <td>${userType}-${userId}</td>
        <td class="text-nowrap text-truncate" style="max-width: 200px "><a href="/forum/thread/detailpage/${thread.threadId}" class="thread-link">${thread.threadTitle}</a></td>
        <td>${thread.forumCategory.forumCategoryName}</td>
        <td>${thread.threadUpvoteCount}</td>
        <td>${thread.threadResponseCount}</td>
        <td>${formattedDate}</td> 
        <td>
            <select class="status-dropdown" data-thread-id="${thread.threadId}">
                <option value="VISIBLE" ${status === 'VISIBLE' ? 'selected' : ''}>正常</option>
                <option value="LOCKED" ${status === 'LOCKED' ? 'selected' : ''}>待審</option>
                <option value="DELETED" ${status === 'DELETED' ? 'selected' : ''}>刪除</option>
            </select>
        </td>
    </tr>
        `
        ;
}


//FUCTION: FETCH ALL THREADS
// window.fetchThreads = function () {
//     return fetch('/forum/thread/find-all', {
//         method: 'GET',
//         headers: {
//             'Content-Type': 'application/json'
//         }
//     })
//         .then(response => {
//             if (!response.ok) {
//                 throw new Error('Network response was not ok ' + response.statusText);
//             } else {
//                 return response.json();
//             }
//         })
// }

window.fetchThreads = function () {
    return fetch('/forum/thread/find-all')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if ($.fn.DataTable.isDataTable('#thread-table')) {
                // If DataTable already exists, clear and add new data
                var table = $('#thread-table').DataTable();
                table.clear().rows.add(data).draw();
            } else {
                // Initialize DataTable if it doesn't exist
                $('#thread-table').DataTable({
                    data: data,
                    columns: [
                        {
                            data: null,
                            orderable: false,
                            defaultContent: '<input class="form-check-input" type="checkbox">'
                        },
                        { data: 'threadId' },
                        {
                            data: null,
                            render: function (data, type, row) {
                                let userType, userId;
                                if (row.student) {
                                    userId = row.student.studentId;
                                    userType = '學生';
                                } else if (row.teacher) {
                                    userId = row.teacher.teacherId;
                                    userType = '老師';
                                } else if (row.admin) {
                                    userId = row.admin.adminId;
                                    userType = '管理員';
                                }
                                return `${userType}-${userId}`;
                            }
                        },
                        {
                            data: 'threadTitle',
                            render: function (data, type, row) {
                                return `<a href="/forum/thread/detailpage/${row.threadId}" class="thread-link">${data}</a>`;
                            }
                        },
                        { data: 'forumCategory.forumCategoryName' },
                        { data: 'threadUpvoteCount' },
                        { data: 'threadResponseCount' },
                        {
                            data: 'threadCreatedTime',
                            render: function (data) {
                                return data.split('T')[0]; // Format date to YYYY-MM-DD
                            }
                        },
                        {
                            data: 'threadStatus',
                            orderable: false,
                            render: function (data, type, row) {
                                return `
                                    <select class="status-dropdown" data-thread-id="${row.threadId}">
                                        <option value="VISIBLE" ${data === 'VISIBLE' ? 'selected' : ''}>正常</option>
                                        <option value="LOCKED" ${data === 'LOCKED' ? 'selected' : ''}>待審</option>
                                        <option value="DELETED" ${data === 'DELETED' ? 'selected' : ''}>刪除</option>
                                    </select>
                                `;
                            }
                        },

                    ],
                    "language": {
                        "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh-HANT.json"
                    },
                    "paging": true,
                    "lengthChange": true,
                    "pageLength": 5, // Default number of entries per page
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "全部"]], // Custom options for page entries
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                    "responsive": true
                });
            }
        })
        .catch(error => console.error('Error fetching threads:', error));
}


//FUNCTION: DISPLAY THREAD IN TAB
window.displayThreadsTab = function (threads) {
    console.log('displayThreadsTab():', threads);
    if (!Array.isArray(threads)) {
        console.error('displayThreadsTab called with invalid data:', threads);
        return;  // Early return if data is not an array.
    }
    var $threadList = $('#threadList');
    $threadList.empty();
    threads.forEach(function (thread) {
        $threadList.append(`${createThreadHtml(thread)}`);
    })

}

window.setUserToDto = function (dto, loggedInUser, userType) {
    if (userType === "ADMIN") {
        dto.admin = loggedInUser;
    } else if (userType === "STUDENT") {
        dto.student = loggedInUser;
    } else if (userType === "TEACHER") {
        dto.teacher = loggedInUser;
    }
    return dto;
}



//--------------------POSTS--------------------
//CREATE POST HTML
window.createPostHtml = function (post) {

    //VIEW REVISION
    let userId, userType;
    if (post.student) {
        userId = (post.student.studentId);
        userType = '學生';
    } else if (post.teacher) {
        userId = (post.teacher.teacherId);
        userType = '老師';
    } else if (post.admin) {
        userId = (post.admin.adminId);
        userType = '管理員';
    }


    // Format date to show only YYYY-MM-DD
    let formattedDate = post.postCreatedTime.split('T')[0];
    let status = post.threadStatus;
    let parentPost = post.parentPost;
    if (post.parentPost === null) {
        parentPost = '無';
    } else { parentPost = post.parentPost.postContent; }

    let parentPostLink =
        post.parentPost
            ? `<a href="#" class="view-post-details" data-post-id="${post.parentPost.postId}" data-bs-toggle="modal" data-bs-target="#postDetailsModal">${parentPost}</a>`
            : parentPost;

    return `
    <tr class="text-nowrap">
            <td><input class="form-check-input" type="checkbox"></td>                  
            <td >${post.postId}</td>
            <td>${userType}-${userId}</td>
            
            <td class="text-nowrap text-truncate" style="max-width: 200px;">
            <a href="/forum/thread/detailpage/${post.thread.threadId}" class="thread-link"> ID: ${post.thread.threadId}<br/>${post.thread.threadTitle}
            </a></td>
           
            <td class="text-nowrap text-truncate" data-bs-toggle="modal"
            data-bs-target="#border-less" style="max-width: 200px;" >
            <a href="#" class="view-post-details" data-post-id="${post.postId}" data-bs-toggle="modal" data-bs-target="#postDetailsModal">${post.postContent}</a>
            </td>

            <td class="text-nowrap text-truncate" style="max-width: 200px;">${parentPostLink}</td>

            
            <td>${post.postUpvoteCount}</td>
            <td>${post.postResponseCount}</td>
            <td>${formattedDate}</td> 
            
            <td>
             <select class="status-dropdown" data-post-id="${post.postId}">
                    <option value="VISIBLE" ${status === 'VISIBLE' ? 'selected' : ''}>正常</option>
                    <option value="LOCKED" ${status === 'LOCKED' ? 'selected' : ''}>待審</option>
                    <option value="DELETED" ${status === 'DELETED' ? 'selected' : ''}>刪除</option>
             </select>
             </td>
           
    </tr>
    `
        ;
}

//FUCTION: FETCH ALL POSTS
// window.fetchPosts = function () {
//     return fetch('/forum/post/find-all', {
//         method: 'GET',
//         headers: {
//             'Content-Type': 'application/json'
//         }
//     })
//         .then(response => {
//             if (!response.ok) {
//                 throw new Error('Network response was not ok ' + response.statusText);
//             }
//             return response.json();
//         });

// }

window.fetchPosts = function () {
    return fetch('/forum/post/find-all')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if ($.fn.DataTable.isDataTable('#post-table')) {
                // If DataTable already exists, clear and add new data
                var table = $('#post-table').DataTable();
                table.clear().rows.add(data).draw();
            } else {
                // Initialize DataTable if it doesn't exist
                $('#post-table').DataTable({
                    data: data,
                    columns: [
                        {
                            data: null,
                            orderable: false,
                            defaultContent: '<input class="form-check-input" type="checkbox">'
                        },
                        { data: 'postId' },
                        {
                            data: null,
                            render: function (data, type, row) {
                                let userId, userType;
                                if (row.student) {
                                    userId = row.student.studentId;
                                    userType = '學生';
                                } else if (row.teacher) {
                                    userId = row.teacher.teacherId;
                                    userType = '老師';
                                } else if (row.admin) {
                                    userId = row.admin.adminId;
                                    userType = '管理員';
                                }
                                return `${userType}-${userId}`;
                            }
                        },
                        {
                            data: 'thread',
                            render: function (data, type, row) {
                                return `<a href="/forum/thread/detailpage/${data.threadId}" class="thread-link">ID: ${data.threadId}<br/>${data.threadTitle}</a>`;
                            }
                        },
                        {
                            data: 'postContent',
                            render: function (data, type, row) {
                                return `<a href="#" class="view-post-details" data-post-id="${row.postId}" data-bs-toggle="modal" data-bs-target="#postDetailsModal">${data}</a>`;
                            }
                        },
                        {
                            data: 'parentPost',
                            render: function (data, type, row) {
                                if (data === null) {
                                    return '無';
                                } else {
                                    return `<a href="#" class="view-post-details" data-post-id="${data.postId}" data-bs-toggle="modal" data-bs-target="#postDetailsModal">${data.postContent}</a>`;
                                }
                            }
                        },
                        { data: 'postUpvoteCount' },
                        { data: 'postResponseCount' },
                        {
                            data: 'postCreatedTime',
                            render: function (data) {
                                return data.split('T')[0]; // Format date to YYYY-MM-DD
                            }
                        },
                        {
                            data: 'postStatus',
                            orderable: false,
                            render: function (data, type, row) {
                                return `
                                    <select class="status-dropdown" data-post-id="${row.postId}">
                                        <option value="VISIBLE" ${data === 'VISIBLE' ? 'selected' : ''}>正常</option>
                                        <option value="LOCKED" ${data === 'LOCKED' ? 'selected' : ''}>待審</option>
                                        <option value="DELETED" ${data === 'DELETED' ? 'selected' : ''}>刪除</option>
                                    </select>
                                `;
                            }
                        }
                    ],
                    "language": {
                        "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh-HANT.json"
                    },
                    "paging": true,
                    "lengthChange": true,
                    "pageLength": 5,
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "全部"]],
                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                    "responsive": true
                });
            }
        })
        .catch(error => console.error('Error fetching posts:', error));
}

//FUNCTION: DISPLAY POSTS IN TAB
window.displayPostsTab = function (posts) {
    console.log('displayPostsTab():', posts);
    if (!Array.isArray(posts)) {
        console.error('displayPostsTab called with invalid data:', posts);
        return;  // Early return if data is not an array.
    }
    var $postList = $('#postList');
    $postList.empty();
    posts.forEach(function (post) {
        $postList.append(`${createPostHtml(post)}`);
    })

}


//--------------------CATEGORIES--------------------

window.fetchCategories = function () {
    return fetch('/forum/category/find-all')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if ($.fn.DataTable.isDataTable('#category-table')) {
                // If DataTable already exists, clear and add new data
                var table = $('#category-table').DataTable();
                table.clear().rows.add(data).draw();
            } else {
                // Initialize DataTable if it doesn't exist
                $('#category-table').DataTable({
                    data: data,
                    columns: [
                        {
                            data: null,
                            defaultContent: '<input class="form-check-input" type="checkbox">'
                        },
                        { data: 'forumCategoryId' },
                        {
                            data: 'forumCategoryName',
                            render: function (data, type, row) {
                                return `<a href="/forum/category/detailpage/${row.forumCategoryId}">${data}</a>`;
                            }
                        },
                        { data: 'forumCategoryDescription' },
                        {
                            data: null,
                            orderable: false,
                            defaultContent: `
                                <button class="edit btn btn-sm btn-primary">
                                <i class="bi bi-pencil align-middle"></i></button>`
                        }
                    ],
                    "language": {
                        "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh-HANT.json"
                    },
                    "paging": true,
                    "lengthChange": true,
                    "pageLength": 5, // Default number of entries per page
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "全部"]], // Custom options for page entries

                    "searching": false,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false,
                    "responsive": true
                });
            }
        })
        .catch(error => console.error('Error fetching categories:', error));
}

window.fetchCreateThreadCategories = function () {
    return fetch('/forum/category/find-all', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok ' + response.statusText);
        }
        return response.json();
    });
};



//CATEGORY HTML
window.createCategoryHtml = function (category) {
    return `
        <tr class="text-nowrap">
    
            <td><input class="form-check-input" type="checkbox"></td>
            <td>${category.forumCategoryId}</td>
            <td><a href="/forum/category/detailpage/${category.forumCategoryId}">${category.forumCategoryName}</a></td>
            <td>${category.forumCategoryDescription}</td>
            <td id="updateCategory class="align-middle text-center">
            <button class=" edit btn btn-sm btn-primary">
            <i class="bi bi-pencil align-middle">
            </i></button></td>            
        </tr>
    `;
}

//FUNCTION: DISPLAY CATEGORY IN TAB 
// window.displayCategoriesTab = function (categories) {
//     var $categoryList = $('#categoryList');
//     $categoryList.empty();
//     categories.forEach(function (category) {
//         $categoryList.append(`${createCategoryHtml(category)}`);
//     })

// }

window.displayCategoriesTab = function (categories) {
    if (!Array.isArray(categories)) {
        console.error('displayCategoriesTab called with invalid data:', categories);
        return;
    }
    var $categoryList = $('#categoryList');
    $categoryList.empty();
    categories.forEach(function (category) {
        $categoryList.append(`${createCategoryHtml(category)}`);
    });
}