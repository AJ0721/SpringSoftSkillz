<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="/css/backstageStyles.css">

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

                //cancel btn page transfer
                $('#cancel').click(function (e) {

                    window.location.href = '/forum/adminhome';
                    //todo: go to category tab
                });


                $('#create').click(function (e) {
                    e.preventDefault(); // Prevent the default form submit action

                    // Get the values from the form inputs
                    var categoryName = $('#categoryName').val();
                    var categoryDescription = $('#categoryDescription').val();

                    // Prepare the data to send in the request
                    var categoryData = {
                        forumCategoryName: categoryName,
                        forumCategoryDescription: categoryDescription
                    };

                    // Send the AJAX request
                    $.ajax({
                        url: '/forum/category/insert', // The URL to the endpoint
                        type: 'POST', // The type of request
                        contentType: 'application/json', // The content type of the request
                        data: JSON.stringify(categoryData), // Convert the JavaScript object to a JSON string
                        success: function (response) {
                            console.log('Category created successfully', response);
                            Swal.fire('新增成功', '', 'success');
                            window.location.href = '/forum/adminhome';
                            //todo: redirect to category tab
                        },
                        error: function (xhr, status, error) {
                            console.error('Error creating category:', error);
                            Swal.fire('新增失敗', '請檢查連線並重新整理' + error, 'error');
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
                            新增分類看板
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
                                    <button type="submit" class="btn btn-primary" id="create">新增</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>





    </body>

    </html>