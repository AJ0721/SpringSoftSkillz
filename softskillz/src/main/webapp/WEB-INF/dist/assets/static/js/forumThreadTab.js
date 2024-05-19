$(document).ready(function () {

    //ACTION: FETCH ALL 
    $('#nav-threads-tab').click(function (e) {
        e.preventDefault();
        $('#threadList').empty();
        fetchThreads()
            .then(threads => displayThreadsTab(threads))
            .catch(function (error) {
                console.error("Error fetching threads:", error);
                $('#threadList').html('<tr><td colspan="9">資料載入失敗，請重新整理。</td></tr>');
            });
    });

    //SELECT 'DELETE ALL CHECKBOX'
    $('#selectAllThreads').change(function () {
        $('#threadList :checkbox').prop('checked', $(this).prop('checked'));
    });

    //BULK DELETE SCTION
    $('#deleteSelectedThreads').click(function () {
        var selectedCheckboxes = $('#threadList :checkbox:checked');
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

                var threadIds = [];
                selectedCheckboxes.each(function () {
                    var threadId = $(this).closest('tr').find('td:nth-child(2)').text();
                    threadIds.push(threadId);
                });

                console.log(threadIds); //debug ok


                fetch('/forum/thread/delete-all', {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(threadIds)
                })
                    .then(
                        response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok ' + response.statusText);
                            }
                            return response.text();
                        })
                    .then(data => {
                        console.log(data);
                        Swal.fire('刪除成功', '', 'success');
                        $('#threadList').empty();
                        fetchThreads()
                            .then(function (threads) {
                                displayThreadsTab(threads);
                            })
                            .catch(function (error) {
                                console.error("Error fetching threads:", error);
                                $('#threadList').html('<tr><td colspan="9">資料載入失敗，請重新整理。</td></tr>');
                            });
                    }).catch(
                        error => {
                            console.error('There was a problem with the fetch operation:', error);
                            Swal.fire('刪除失敗', '請檢查連線並重新整理', 'error');
                        }
                    );



                $.ajax({
                    url: '/forum/thread/delete-all',
                    type: 'DELETE',
                    data: JSON.stringify(threadIds),
                    contentType: 'application/json',
                    success: function (response) {


                        console.log(response);
                        Swal.fire('刪除成功', '', 'success');
                        $('#threadList').empty();
                        fetchThreads()
                            .then(function (threads) {
                                displayThreadsTab(threads);
                            })
                            .catch(function (error) {
                                console.error("Error fetching threads:", error);
                                $('#threadList').html('<tr><td colspan="9">資料載入失敗，請重新整理。</td></tr>');
                            });
                    },
                    error: function (xhr, status, error) {
                        console.log(status + error + xhr.responseText);
                        Swal.fire('刪除失敗', '請檢查連線並重新整理', 'error');
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



    //UPDATE STATUS

    // Listen for focus to capture the original value before change
    $(document).on('focus', '.status-dropdown', function () {
        // Store the original value
        $(this).data('current', $(this).val());
    });


    document.body.addEventListener('change', function (e) {
        if (e.target.classList.contains('status-dropdown')) {
            const threadId = e.target.dataset.threadId;
            const newStatus = e.target.value;

            // Show confirmation dialog
            Swal.fire({
                title: '是否更新文章狀態?',
                text: "",
                icon: 'warning',
                showCancelButton: true,
                cancelButtonText: '取消',
                confirmButtonText: '確認'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Send the update to the server
                    fetch(`/forum/thread/update/id/${threadId}?status=${newStatus}`, {
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
});


// FUNCTION: SEARCH BAR (KEYWORD/ID)
function searchThreadsByKeyword() {
    var keyword = $('#searchInput').val().trim();

    if (!keyword) {
        $('#threadList').html('<tr><td colspan="9">請輸入搜索關鍵字。</td></tr>');
        return;
    }

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
                    $('#threadList').append(createThreadHtml(thread));
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
    console.log('threadId: ' + threadId);

    $.ajax({
        url: '/forum/thread/find/id/' + threadId,
        method: 'GET',
        dataType: 'json',
        success: function (thread) {
            $('#threadList').empty();
            $('#threadList').append(createThreadHtml(thread));

        },
        error: function (error) {
            $('#threadList').empty();
            $('#threadList').append(`
                <tr><td colspan="9">查無資訊，請重新輸入</td></tr >
                `);
            console.error('Error searching threads:', error);
        }
    });
};






