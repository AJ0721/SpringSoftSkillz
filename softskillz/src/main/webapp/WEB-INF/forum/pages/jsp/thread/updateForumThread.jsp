<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>更新文章</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="/css/backstageStyles.css">

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>

            fetch("/html/backstageFrame.html")
                .then(response => {
                    if (response.ok) {
                        return response.text();
                    }
                }).then(data => {
                    document.querySelector('#sidebar').innerHTML = data;
                })


        </script>
    </head>

    <body>


        <script>
            $(document).ready(function () {

                //BUTTON PAGE TRANSFER
                $('#cancel').click(function (e) {

                    window.location.href = '/forum/adminhome#nav-thread';
                });


                const pathname = window.location.pathname;
                const parts = pathname.split("/");
                const threadId = parts[parts.length - 1];
                console.log(threadId);

                fetch('/forum/thread/find/id/' + threadId)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Failed to fetch data')
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log(data);
                        document.getElementById('category').innerHTML = data.forumCategoryName;
                        document.getElementById('threadTitle').value = data.threadTitle;
                        document.getElementById('threadContent').value = data.threadContent;
                    })
                    .catch(error => {
                        console.log("Error fetching thread details:", error);
                    }

                    )


                $('#update').click(function (e) {
                    e.preventDefault();

                    var threadData = {
                        forumCategoryId: $('#category').val(),
                        threadContent: $('#threadContent').val(),
                        threadTitle: $('#threadTitle').val()
                    };

                    $.ajax({
                        url: '/forum/thread/update/' + threadId,
                        type: 'PUT',
                        contentType: 'application/json',
                        data: JSON.stringify(threadData),
                        success: function (response) {
                            console.log('Thread updated successfully', response);
                            Swal.fire({
                                title: '更新成功',
                                text: '',
                                icon: 'success',
                                timer: 2000,
                                didClose: () => {
                                    window.location.href = '/forum/adminhome#nav-thread';
                                }
                            });
                        },
                        error: function (error) {
                            console.error('Error updating thread:', error);
                            Swal.fire('更新失敗', '請檢查連線並重新整理' + error, 'error');
                        }
                    });
                });






            });




        </script>

        <header>
            <h1>Soft Skillz</h1>
        </header>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div id="sidebar"></div>

                <!-- Right Column -->
                <div class="col-md-9 ml-sm-auto col-lg-10 px-4 mt-4">
                    <div class="card">
                        <div class="card-header">
                            編輯文章
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <label for="category">分類</label>
                                    <div class=" rounded p-2 border bg-white" style="user-select: text;" id="category"
                                        readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="threadTitle">標題</label>
                                    <input type="text" class="form-control" id="threadTitle">
                                </div>
                                <div class="form-group">
                                    <label for="threadContent">內文</label>
                                    <textarea class="form-control" id="threadContent" rows="3"></textarea>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" id="cancel">取消</button>
                                    <button type="submit" class="btn btn-primary" id="update">更新</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </body>

    </html>