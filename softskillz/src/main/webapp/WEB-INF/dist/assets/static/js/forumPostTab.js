// GLOBAL FUNCTION: SHOW TABS IN HOMEPAGE WHEN REDIRECT

//POST HTML
window.createPostHtml = function (post) {

    //VIEW REVISION
    let userId = post.studentId || post.teacherId || post.adminId;
    let userType = post.studentId ? '學生' : post.teacherId ? '老師' : '管理員';

    // Format date to show only YYYY-MM-DD
    let formattedDate = post.threadCreatedTime.split('T')[0];

    return `
        <tr>
                <td><input class="form-check-input" type="checkbox"></td>                  
                <td class="text-nowrap">${post.postId}</td>
                <td class="text-nowrap"><a href="/forum/thread/detailpage/${post.threadId}" class="thread-link"> ${post.threadTitle}(${post.threadId})</a></td>
                <td class="text-nowrap">${post.threadParentPost}</td>
                <td class="text-nowrap">${userType}-${userId}</td>
                <td class="text-nowrap">${post.threadUpvoteCount}</td>
                <td class="text-nowrap">${post.threadResponseCount}</td>
                <td class="text-nowrap">${formattedDate}</td> 
                <td class="text-nowrap">${post.forumThreadStatus}</td>
                <td id="updateThread" class="edit btn btn-sm icon btn-primary text-nowrap"><i class="bi bi-pencil"></i></td>
        </tr>
        `
        ;
}