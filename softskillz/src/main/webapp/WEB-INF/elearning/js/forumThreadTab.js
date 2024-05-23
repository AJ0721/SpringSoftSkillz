$(document).ready(function () {

    //ACTION: FETCH ALL 
    
        e.preventDefault();
        $('#threadList').empty();
        fetchThreads()
            .then(threads => displayThreadsTab(threads))
            .catch(function (error) {
                console.error("Error fetching threads:", error);
                $('#threadList').html('<tr><td colspan="6">資料載入失敗，請重新整理。</td></tr>');
            });
   




    //PAGE REDIRECT
    $('#createNewThread').click(function (e) {
        e.preventDefault();
        window.location.href = '/forum/f/thread/insert'
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


    $(document).on('change', '.status-dropdown', function () {
        var threadId = $(this).data('thread-id');
        var newStatus = $(this).val();

        // Make a PUT request to update the status
        fetch(`/forum/thread/update/id/${threadId}?status=${newStatus}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log('Status updated successfully:', data);
            Swal.fire("狀態更新成功", "", "success");
        })
        .catch(error => {
            console.error('Error updating status:', error);
            Swal.fire('狀態更新失敗', '請檢查連線並重新整理', 'error');
        });
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






