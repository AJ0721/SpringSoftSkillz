
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