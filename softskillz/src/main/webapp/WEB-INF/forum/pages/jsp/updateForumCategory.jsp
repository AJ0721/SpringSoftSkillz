<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Soft Skillz 管理者後台首頁</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/backstageStyles.css">

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



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
                            Swal.fire('更新成功', '', 'success');
                            window.location.href = '/forum/adminhome';
                            //todo: redirect to category tab
                        },
                        error: function (xhr, status, error) {
                            console.error('Error creating category:', error);
                            Swal.fire('更新失敗', '請檢查連線並重新整理' + error, 'error');
                        }
                    });
                });

            });




        </script>


        <header>
            <h1>Soft Skillz</h1>
        </header>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var userDropdown = document.getElementById("userDropdown");
                var userDropdownContent = document.getElementById(
                    "userDropdownContent"
                );

                userDropdown.addEventListener("click", function (event) {
                    event.stopPropagation(); // 防止點擊事件向上冒泡
                    toggleDropdown(userDropdownContent);
                });

                var courseDropdown = document.getElementById("courseDropdown");
                var courseDropdownContent = document.getElementById(
                    "courseDropdownContent"
                );

                courseDropdown.addEventListener("click", function (event) {
                    event.stopPropagation(); // 防止點擊事件向上冒泡
                    toggleDropdown(courseDropdownContent);
                });

                function toggleDropdown(dropdownContent) {
                    var allDropdowns = document.querySelectorAll(".dropdown-content");
                    allDropdowns.forEach(function (dropdown) {
                        if (dropdown !== dropdownContent) {
                            dropdown.style.display = "none";
                        }
                    });

                    if (dropdownContent.style.display === "none") {
                        dropdownContent.style.display = "block";
                    } else {
                        dropdownContent.style.display = "none";
                    }
                }

                // 點擊頁面其他地方隱藏下拉菜單
                document.addEventListener("click", function (event) {
                    var dropdowns = document.querySelectorAll(".dropdown-content");
                    dropdowns.forEach(function (dropdown) {
                        if (dropdown.style.display === "block") {
                            dropdown.style.display = "none";
                        }
                    });
                });
            });
        </script>

        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-2 d-none d-md-block  sidebar">
                    <div class="sidebar-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item"><a class="nav-link active" href="#">首頁</a></li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    用戶管理
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="#">管理員</a>
                                    <a class="dropdown-item" href="#">學生</a>
                                    <a class="dropdown-item" href="#">教師</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCourses" role="button"
                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    課程管理
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownCourses">
                                    <a class="dropdown-item" href="#">課程</a>
                                    <a class="dropdown-item" href="#">學生行事曆</a>
                                    <a class="dropdown-item" href="#">學生課程預約</a>
                                    <a class="dropdown-item" href="#">教師行事曆</a>
                                </div>
                            </li>
                            <li class="nav-item"><a class="nav-link" href="#">課程訂單管理</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">商品管理</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">商品訂單管理</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">學伴資料管理</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">論壇管理</a></li>
                        </ul>
                    </div>
                </nav>

                <!-- Main content -->
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
                                    <button type="submit" class="btn btn-primary" id="create">更新</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>

    </html>