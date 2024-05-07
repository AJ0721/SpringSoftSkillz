<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>新增文章</title>

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

        <script src="/forum/js/categoryTab.js"></script>
        <script>
            $(document).ready(function () {

                //BUTTON PAGE TRANSFER
                $('#cancel').click(function (e) {

                    window.location.href = '/forum/adminhome#nav-thread';
                });

                $('#create').click(function (e) {
                    e.preventDefault();

                    var threadData = {
                        forumCategoryId: $('#category').val(),
                        threadContent: $('#categoryDescription').val(),
                        threadTitle: $('#threadTitle').val()
                    };

                    $.ajax({
                        url: '/forum/thread/insert',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(threadData),
                        success: function (response) {
                            console.log('Category created successfully', response);
                            Swal.fire({
                                title: '新增成功',
                                text: '',
                                icon: 'success',
                                timer: 2000,
                                didClose: () => {
                                    window.location.href = '/forum/adminhome#nav-thread';
                                }
                            });
                        },
                        error: function (error) {
                            console.error('Error creating category:', error);
                            Swal.fire('新增失敗', '請檢查連線並重新整理' + error, 'error');
                        }
                    });
                });


                //ACTION: POPULATE DROPDOWN
                fetchCategories()
                    .then(function (categories) {
                        populateDropdown(categories);
                    }).catch(function (error) {
                        console.error("Error fetching categories: ", error);
                        $('#category').append('<option>Error loading categories</option>');
                    });


                //FUNCTION: POPULATE DROPDOWN
                function populateDropdown(categories) {
                    var $dropdown = $('#category');
                    $dropdown.empty(); // Clear existing options
                    $dropdown.append('<option value="">請選擇文章分類</option>');
                    categories.forEach(function (category) {
                        $dropdown.append($('<option></option>').attr('value', category.forumCategoryId).text(`\${category.forumCategoryId}  \${category.forumCategoryName}`));
                    });
                }
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
                            新增文章
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="input-group-prepend">
                                    <label for="category">文章分類</span>
                                </div>
                                <select class="form-control" id="category">
                                    <option value="">請選擇文章分類</option>

                                </select>
                                <div class="form-group">
                                    <label for="threadTitle">標題</label>
                                    <input type="text" class="form-control" id="threadTitle" placeholder="請輸入文章標題">
                                </div>
                                <div class="form-group">
                                    <label for="threadContent">內文</label>
                                    <textarea class="form-control" id="threadContent" rows="3"
                                        placeholder="請輸入文章內容"></textarea>
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