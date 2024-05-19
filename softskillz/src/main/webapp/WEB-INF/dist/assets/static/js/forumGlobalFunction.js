//--------------------USER--------------------
//USER VALIDATION
window.validateUser = function (user) {
    if (!user) {
        window.location.href = '/admin/admin-loginPage';
        return;
    }
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

//GET LOGGED IN USER DTO
window.retrieveUser = function () {
    const loggedInUser = JSON.parse(sessionStorage.getItem('loggedInUser'));
    const userType = sessionStorage.getItem('userType');

    return { loggedInUser, userType };
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
        <td id="updateThread" class="align-middle text-center">
        <button class="edit btn btn-sm btn-primary">
        <i class="bi bi-pencil align-middle">
        </i></button></td>
    </tr>
        `
        ;
}


//FUCTION: FETCH ALL THREADS
window.fetchThreads = function () {
    return fetch('/forum/thread/find-all', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            } else {
                return response.json();
            }
        })
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
window.fetchPosts = function () {
    return fetch('/forum/post/find-all', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        });

}

//FUNCTION: DISPLAY POSTS IN TAB
window.displayPostsTab = function (posts) {
    console.log('displayPostsTab():', posts);
    if (!Array.isArray(posts)) {
        console.error('displayThreadsTab called with invalid data:', posts);
        return;  // Early return if data is not an array.
    }
    var $postList = $('#postList');
    $postList.empty();
    posts.forEach(function (post) {
        $postList.append(`${createPostHtml(post)}`);
    })

}


//--------------------CATEGORIES--------------------
//FUNCTION: FETCH ALL CATEGORIES (returns a jQuery promise)
window.fetchCategories = function () {
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
            <td id="updatePost" class="align-middle text-center">
            <button class=" edit btn btn-sm btn-primary">
            <i class="bi bi-pencil align-middle">
            </i></button></td>            
        </tr>
    `;
}

//FUNCTION: DISPLAY CATEGORY IN TAB 
window.displayCategoriesTab = function (categories) {
    var $categoryList = $('#categoryList');
    $categoryList.empty();
    categories.forEach(function (category) {
        $categoryList.append(`${createCategoryHtml(category)}`);
    })

}



