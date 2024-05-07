<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>文章資訊</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="/css/backstageStyles.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- FETCH SIDEBAR HTML -->
        <script>
            fetch("/html/backstageFrame.html")
                .then(response => {
                    if (response.ok) {
                        return response.text();
                    }
                })
                .then(data => {
                    document.querySelector('#sidebar').innerHTML = data;
                })
        </script>
    </head>

    <body>
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
                            新增文章
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
                                    <div class=" rounded p-2 border bg-white" style="user-select: text;"
                                        id="threadTitle" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="threadContent">內文</label>
                                    <div class=" rounded p-2 border bg-white" style="user-select: text;"
                                        id="threadContent" readonly>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" id="cancel">返回</button>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script>
            $(document).ready(function () {
                const pathname = window.location.pathname;
                const parts = pathname.split("/");
                const threadId = parts[parts.length - 1];

                fetch("/forum/thread/find/id/" + threadId)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Failed to fetch data");
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log(data);
                        document.getElementById('category').innerHTML = data.forumCategoryName;
                        document.getElementById('threadTitle').innerHTML = data.threadTitle;
                        document.getElementById('threadContent').innerHTML = data.threadContent;
                    })
                    .catch(error => console.error('Error fetching thread details:', error));


                //PAGE REDIRECT
                $('#cancel').click(function (e) {
                    window.location.href = '/forum/adminhome#nav-thread';
                });

            });

        </script>
    </body>

    </html>