// GLOBAL FUNCTION: SHOW TABS IN HOMEPAGE WHEN REDIRECT

//THREAD HTML
window.createThreadHtml = function (thread) {
    return `
        <tr>
                  <td><input type="checkbox"></td>
                  <td>${thread.threadId}</td>
                  <td><a href="/forum/thread/detailpage/${thread.threadId}" class="thread-link"> ${thread.threadTitle}</a></td>
                  <td>${thread.forumCategoryId}</td>
                  <td>${thread.studentId}</td>
                  <td>${thread.teacherId}</td>
                  <td>${thread.adminId}</td>
                  <td>${thread.threadCreatedTime}</td>
                  <td>${thread.threadContent}</td>
                  <td>${thread.threadUpvoteCount}</td>
                  <td>${thread.threadResponseCount}</td>
                  <td>${thread.forumThreadStatus}</td>
                  <td id="updateThread" class="edit btn btn-primary btn-sm">編輯</td>
        </tr>
        `
        ;
}


//FUCTION: FETCH ALL THREADS
window.fetchThreads = function () {
    return $.ajax({
        url: '/forum/thread/findall',
        method: 'GET',
        dataType: 'json',
    });
}


//FUNCTION: DISPLAY THREAD IN TAB
window.displayThreadsTab = function (threads) {
    var $threadList = $('#threadList');
    $threadList.empty();
    threads.forEach(function (thread) {
        $threadList.append(`${createThreadHtml(thread)}`);
    })

}


$(document).ready(function () {

    //ACTION: FETCH ALL 
    $('#nav-threads-tab').click(function (e) {
        e.preventDefault();
        $('#threadList').empty();
        fetchThreads();
    });

    //SELECT 'DELETE ALL CHECKBOX'
    $('#selectAllThreads').change(function () {
        $('#threadList :checkbox').prop('checked', $(this).prop('checked'));
    });

    //SWEET ALERT
    $('#deleteSelectedThreads').click(function () {
        var selectedCheckboxes = $('#threadList :checkbox:checked');
        if (selectedCheckboxes.length === 0) {
            Swal.fire('錯誤', '請選擇至少一筆刪除資料', 'error');
            return;
        }

        Swal.fire({
            title: '是否刪除選取資料?',
            text: '',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '確認',
            cancelButtonText: '取消'
        }).then((result) => {

            if (result.isConfirmed) {

                var threadIds = [];
                selectedCheckboxes.each(function () {
                    var threadId = $(this).closest('tr').find('td:nth-child(2)').text();
                    threadIds.push(threadId);
                });

                console.log(threadIds); //debug ok

                $.ajax({
                    url: '/forum/thread/deleteall',
                    type: 'DELETE',
                    data: JSON.stringify({ threadIds: threadIds }),
                    contentType: 'application/json',
                    success: function (response) {
                        Swal.fire('刪除成功', '', 'success');
                        fetchThreads(); // Refresh the category list
                    },
                    error: function (xhr, status, error) {
                        Swal.fire('刪除失敗', '請檢查連線並重新整理' + error + xhr.responseText, 'error');
                    }
                });
            }


        });
    });


    //PAGE REDIRECT
    $('#createNewThread').click(function (e) {
        e.preventDefault();
        window.location.href = '/forum/thread/insertpage'
    });

    $('#threadList').on('click', '.edit', function () {
        var threadId = $(this).closest('tr').find('td:nth-child(2)').text();
        window.location.href = '/forum/thread/updatepage/' + threadId;
    });


    //SEARCH BAR: CLICK
    $('#searchbtn').on('click', function () {
        var searchValue = $(this).val();
        var searchCondition = $('#searchConditionSelect').val();
        if (searchCondition === 'threadId') {
            searchThreadsById(searchValue);
        } else if (searchCondition === 'threadKeyword') {
            searchThreadsByKeyword(searchValue);
        }
    }
    );


    // FUNCTION: SEARCH BAR (KEYWORD/ID)
    function searchThreadsByKeyword() {
        var keyword = $('#searchInput').val();

        $.ajax({
            url: '/forum/thread/search',
            method: 'GET',
            data: { keyword: keyword },
            dataType: 'json',
            success: function (threads) {

                if (threads.length === 0) {
                    $('#threadList').empty();
                    $('#threadList').append(`
                    <tr><td colspan="13">查無資訊，請重新輸入</td></tr >
                    `)
                } else {
                    $('#threadList').empty();
                    threads.forEach(function (thread) {
                        $('#threadList').append(`
                    ${createThreadHtml(thread)}  
                 `);
                    });
                }
            },
            error: function (error) {
                console.error('Error searching threads:', error);
            }
        });


    }
    function searchThreadsById() {
        var threadId = $('#searchInput').val();

        $.ajax({
            url: '/forum/thread/find/' + threadId,
            method: 'GET',
            dataType: 'json',
            success: function (thread) {
                $('#threadList').empty();
                $('#threadList').append(`
                ${createThreadHtml(thread)}
                `);

            },
            error: function (error) {
                $('#threadList').empty();
                $('#threadList').append(`
                <tr><td colspan="13">查無資訊，請重新輸入</td></tr >
                `);
                console.error('Error searching threads:', error);
            }
        });
    };

    //ACTION:DISPLAY CATEGORY IN TAB WHEN LOAD
    $('#nav-threads-tab').click(function (e) {
        e.preventDefault();

        fetchThreads().done(function (threads) {
            displayThreadsTab(threads);
        }).fail(function (error) {
            console.error("Error fetching threads:", error);
            $('#threadList').html('<tr><td colspan="5">載入資料失敗，請重新整理</td></tr>');
        });


    });





})