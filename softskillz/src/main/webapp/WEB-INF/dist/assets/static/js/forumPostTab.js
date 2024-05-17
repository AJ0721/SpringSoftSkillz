// GLOBAL FUNCTION: SHOW TABS IN HOMEPAGE WHEN REDIRECT

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
               
                 <td id="updatePost" class="align-middle text-center">
                 <button class="btn btn-sm btn-primary">
                 <i class="bi bi-pencil align-middle">
                 </i></button></td>
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




$(document).ready(function () {


        //SHOW MODAL
        $(document).on('click', '.view-post-details', function (e) {
                e.preventDefault(); // Prevent the default link behavior
                var postId = $(this).data('post-id');

                fetch(`/forum/post/find/id/${postId}`)
                        .then(response => {
                                if (!response.ok) {
                                        throw new Error('Network response was not ok ' + response.statusText);
                                }
                                return response.json();
                        })
                        .then(post => {
                                // Determine user type, ID, and username
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
                                        userName = "";
                                        userType = '管理員';
                                }

                                // Populate modal with post details
                                $('#modalPostId').text(post.postId);
                                $('#modalUserId').text(`${userType}(ID:${userId}) ${userName}`);
                                $('#modalPostContent').text(post.postContent);

                                // Show the modal
                                $('#post-modal').modal('show');
                        })
                        .catch(error => {
                                console.error('There was a problem with the fetch operation:', error);
                                Swal.fire('無上層留言', 'Please try again later', 'error');
                        });
        });


        //ACTION: FETCH ALL 
        $('#nav-posts-tab').click(function (e) {
                e.preventDefault();
                $('#postList').empty();
                fetchPosts()
                        .then(posts => {
                                displayPostsTab(posts);
                        })
                        .catch(error => {
                                console.error("Error fetching posts:", error);
                                $('#postList').html('<tr><td colspan="10">資料載入失敗，請重新整理。</td></tr>');
                        });
        });

        //UPDATE STATUS

        // Listen for focus to capture the original value before change
        $(document).on('focus', '.status-dropdown', function () {
                // Store the original value
                $(this).data('current', $(this).val());
        });

        document.body.addEventListener('change', function (e) {
                if (e.target.classList.contains('status-dropdown')) {
                        const postId = e.target.dataset.threadId;
                        const newStatus = e.target.value;

                        // Show confirmation dialog
                        Swal.fire({
                                title: '是否更新留言狀態?',
                                text: "",
                                icon: 'warning',
                                showCancelButton: true,
                                cancelButtonText: '取消',
                                confirmButtonText: '確認'
                        }).then((result) => {
                                if (result.isConfirmed) {
                                        // Send the update to the server
                                        fetch(`/forum/post/update/id/${postId}?status=${newStatus}`, {
                                                method: 'PUT',
                                                headers: {
                                                        'Content-Type': 'application/json'
                                                },
                                                body: JSON.stringify({ threadStatus: newStatus })
                                        })
                                                .then(response => response.json())
                                                .then(data => {
                                                        Swal.fire(
                                                                '更新成功!',
                                                                '',
                                                                'success'
                                                        );
                                                })
                                                .catch(error => {
                                                        console.error('Error updating status:', error);
                                                        Swal.fire(
                                                                '更新失敗',
                                                                '請檢查網路連線並重新整理',
                                                                'error'
                                                        );
                                                        dropdown.val(originalStatus);
                                                });
                                } else {
                                        // User clicked 'Cancel', restore the original status
                                        $(e.target).val($(e.target).data('current'));
                                }
                        });
                }
        });

        //SELECT 'DELETE ALL CHECKBOX'
        $('#selectAllPosts').change(function () {
                $('#postList :checkbox').prop('checked', $(this).prop('checked'));
        });

        //BULK DELETE ACTION
        $('#deleteSelectedPosts').click(function () {
                var selectedCheckboxes = $('#postList :checkbox:checked');
                if (selectedCheckboxes.length === 0) {
                        Swal.fire('請先選取資料再操作', '', 'error');
                        return;
                }

                Swal.fire({
                        title: '是否刪除選取資料?',
                        text: '',
                        icon: 'warning',
                        showCancelButton: true,
                        cancelButtonText: '取消',
                        confirmButtonText: '確認'
                }).then((result) => {

                        if (result.isConfirmed) {

                                var postIds = [];
                                selectedCheckboxes.each(function () {
                                        var postId = $(this).closest('tr').find('td:nth-child(2)').text();
                                        postIds.push(postId);
                                });

                                console.log(postIds); //debug ok

                                fetch('/forum/post/delete-all', {
                                        method: 'DELETE',
                                        headers: {
                                                'Content-Type': 'application/json'
                                        },
                                        body: JSON.stringify(postIds)
                                })
                                        .then(response => {
                                                if (!response.ok) {
                                                        throw new Error('Network response was not ok ' + response.statusText);
                                                }
                                                return response.text();
                                        })
                                        .then(data => {
                                                console.log(data);
                                                Swal.fire('刪除成功', '', 'success');
                                                $('#postList').empty();
                                                fetchPosts()
                                                        .then(function (posts) {
                                                                displayPostsTab(posts);
                                                        })
                                                        .catch(function (error) {
                                                                console.error("Error fetching posts:", error);
                                                                $('#postList').html('<tr><td colspan="10">資料載入失敗，請重新整理。</td></tr>');
                                                        });
                                        })
                                        .catch(error => {
                                                console.error('There was a problem with the fetch operation:', error);
                                                Swal.fire('刪除失敗', '請檢查連線並重新整理', 'error');
                                        });
                        }


                });
        });

        //SEARCH BAR: CLICK
        $('#searchbtn').on('click', function () {
                var searchValue = $(this).val();
                var searchCondition = $('#searchConditionSelect').val();
                if (searchCondition === 'postId') {
                        searchPostsById(searchValue);
                }
        }
        );



});

function searchPostsById() {
        var postId = $('#searchInput').val();
        console.log('postId: ' + postId);

        $.ajax({
                url: `/forum/post/find/id/${postId}`,
                method: 'GET',
                dataType: 'json',
                success: function (post) {
                        $('#postList').empty();
                        $('#postList').append(createPostHtml(post));

                },
                error: function (error) {
                        $('#postList').empty();
                        $('#postList').append(`
                    <tr><td colspan="10">查無資訊，請重新輸入</td></tr >
                    `);
                        console.error('Error searching threads:', error);
                }
        });
};

