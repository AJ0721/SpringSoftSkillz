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
        <header>
            <h1>Soft Skillz</h1>
        </header>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div id="sidebar"></div>

                <!-- Right Column -->
                <main class="col-md-9 ml-sm-auto col-lg-10 px-4 mt-4">
                    <div class="card">
                        <div class="card-header">
                            編輯分類看板
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <label for="categoryName">看板名稱</label>
                                    <input type="text" class="form-control" id="categoryName" placeholder="請輸入看板名稱">
                                </div>
                                <div class="form-group">
                                    <label for="categoryDescription">看板說明</label>
                                    <textarea class="form-control" id="categoryDescription" rows="3"
                                        placeholder="請輸入說明文字"></textarea>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" id="cancel">取消</button>
                                    <button type="submit" class="btn btn-primary" id="update">更新</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>

            </div>
        </div>

        <script>
            $(document).ready(function () {

                // btn page transfer
                $('#cancel').click(function (e) {
                    window.location.href = '/forum/adminhome';
                    //todo: go to category tab
                });


                //Get category ID
                const pathname = window.location.pathname;
                const parts = pathname.split("/");
                const categoryId = parts[parts.length - 1];
                console.log(categoryId);

                fetch("/forum/category/find/id/" + categoryId)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Failed to fetch data");
                        }
                        return response.json()
                    })
                    .then(data => {
                        console.log(data);
                        document.getElementById('categoryName').value = data.forumCategoryName;
                        document.getElementById('categoryDescription').value = data.forumCategoryDescription;
                    })
                    .catch(error => console.error("Error fetching category details:", error));


                $('#update').click(function (e) {
                    e.preventDefault();

                    // Get the values from the form inputs
                    var categoryName = $('#categoryName').val();
                    var categoryDescription = $('#categoryDescription').val();

                    var categoryData = {
                        forumCategoryId: categoryId,
                        forumCategoryName: categoryName,
                        forumCategoryDescription: categoryDescription
                    };

                    $.ajax({
                        url: '/forum/category/update/' + categoryId,
                        //missing the last slash will be treated as query string
                        type: 'PUT',
                        contentType: 'application/json', // The content type of the request
                        data: JSON.stringify(categoryData), // Convert the JavaScript object to a JSON string
                        success: function (response) {
                            console.log('Category created successfully', response);
                            Swal.fire({
                                title: '更新成功',
                                text: '',
                                icon: 'success',
                                timer: 2000, // 2000 milliseconds delay
                                didClose: () => {
                                    window.location.href = '/forum/adminhome'; // Redirect after the alert closes
                                    //todo: redirect to category tab
                                }
                            });
                        },
                        error: function (xhr, status, error) {
                            console.error('Error creating category:', error);
                            Swal.fire(
                                '刪除失敗',
                                '可能原因：<br>1. 此分類中仍有文章<br>2. 網路無法連線，請重新整理<br>' + error,
                                'error'
                            );
                        }
                    });
                });

            });

        </script>
    </body>

    </html>