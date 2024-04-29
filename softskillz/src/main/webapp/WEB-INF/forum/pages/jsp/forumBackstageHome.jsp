<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Soft Skillz 管理者後台首頁</title>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="/css/backstageStyles.css">

        <script src="/js/backend.js"></script>
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
                //FETCH ALL DATA
                $('#nav-category-tab').click(function (e) {
                    e.preventDefault();
                    $('#categoryList').empty()
                    fetchCategories();
                });
                $('#nav-threads-tab').click(function (e) {
                    e.preventDefault();
                    $('#threadList').empty()
                    fetchThreads();
                });

                //SEARCH BAR: INPUT
                $('#searchInput').on('input', function () {
                    var searchValue = $(this).val();
                    var searchCondition = $('#searchConditionSelect').val();
                    if (searchCondition === 'categoryKeyword') {
                        searchCategoriesByKeyword(searchValue);
                    } else if (searchCondition === 'threadKeyword') {
                        searchThreadsByKeyword(searchValue);
                    }
                });

                //SEARCH BAR: CLICK
                $('#searchbtn').on('click', function () {
                    var searchValue = $(this).val();
                    var searchCondition = $('#searchConditionSelect').val();
                    if (searchCondition === 'categoryId') {
                        searchCategoriesById(searchValue);
                    } else if (searchCondition === 'threadId') {
                        searchThreadsById(searchValue);
                    }
                });

                //SELECT DELETE ALL CHECKBOX
                $('#selectAllCategories').change(function () {
                    $('#categoryList :checkbox').prop('checked', $(this).prop('checked'));
                });
                $('#selectAllThreads').change(function () {
                    $('#threadList :checkbox').prop('checked', $(this).prop('checked'));
                });

                //BULK DELETE !!!NOT WORKING!!!

                //setupDeleteHandler('#deleteSelectedCategories', '#categoryList', '/forum/category/deleteall', 'forumCategoryIds', fetchCategories);
                // setupDeleteHandler('#deleteSelectedThreads', '#threadList', '/forum/thread/deleteall', 'ThreadIds', fetchThreads);


                //SWEET ALERT
                $('#deleteSelectedCategories').click(function () {
                    var selectedCheckboxes = $('#categoryList :checkbox:checked');
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

                            var categoryIds = [];
                            selectedCheckboxes.each(function () {
                                var categoryId = $(this).closest('tr').find('td:nth-child(2)').text();
                                categoryIds.push(categoryId);
                            });

                            $.ajax({
                                url: '/forum/category/deleteall',
                                type: 'DELETE',
                                data: JSON.stringify({ forumCategoryIds: categoryIds }),
                                contentType: 'application/json',
                                success: function (response) {
                                    Swal.fire('刪除成功', '', 'success');
                                    fetchCategories(); // Refresh the category list
                                },
                                error: function (xhr, status, error) {
                                    Swal.fire('刪除失敗', '請重新整理' + error, 'error');
                                }
                            });
                        }
                    });
                });
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
                $('#createNewCategory').click(function (e) {
                    e.preventDefault();

                    window.location.href = '/forum/admin/category/insert'
                });

                //UPDATE !!!NOT COMPLETED!!!
                $(document).on('click', '#updateCategory', function (e) {
                    e.preventDefault();

                    // Retrieve the category ID 
                    var categoryId = $(this).closest('tr').find('td:nth-child(2)').text();


                    // $(window).on('click', function () { //load?

                    $.ajax({
                        url: '/forum/category/find/id/' + categoryId,
                        method: 'GET',
                        dataType: 'json',
                        success: function (category) {
                            console.log(category);

                            // $('#categoryName').val(category.forumCategoryName);
                            // $('#categoryDescription').val(category.forumCategoryDescription);

                            window.location.href = '/forum/admin/category/update?categoryId=' + categoryId;


                        },
                        error: function (error) {
                            console.error("Error fetching category details: ", error);
                        }
                    });
                });


                //FUCTION: FETCH DATA
                function fetchCategories() {
                    console.log("Fetching categories!");
                    // avoid repetitive loading when multiple clicks happen
                    $('#categoryList').empty();
                    $.ajax({
                        url: '/forum/category/findall',
                        method: 'GET',
                        dataType: 'json',
                        success: function (categories) {
                            console.log("Categories fetched successfully:", categories);
                            categories.forEach(function (category) {
                                $('#categoryList').append(`
                        <tr>
                            <td><input type="checkbox"></td>
                            <td >`+ category.forumCategoryId + `</td>
                            <td > <a href="#detail">`+ category.forumCategoryName + `</a></td>
                            <td>`+ category.forumCategoryDescription + `</td>
                           
                            <td id="updateCategory"> <a href="#" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i>
                            編輯</a>
                    
                                        </td>
                        </tr>
                    `);
                            });
                        },
                        error: function (error) {
                            console.error("Error fetching categories: ", error);
                        }
                    });
                }
                function fetchThreads() {
                    console.log("Fetching threads!");
                    $('#threadList').empty();
                    $.ajax({
                        url: '/forum/thread/findall',
                        method: 'GET',
                        dataType: 'json',
                        success: function (threads) {
                            console.log("Threads fetched successfully:", threads);
                            threads.forEach(function (thread) {
                                $('#threadList').append(`
                                <tr>
                                            <td><input type="checkbox"></td>
                                            <td>`+ thread.threadId + `</td>
                                            <td>`+ thread.forumCategoryId + `</td>
                                            <td>`+ thread.studentId + `</td>
                                            <td>`+ thread.teacherId + `</td>
                                            <td>`+ thread.adminId + `</td>
                                            <td><a href="#">`+ thread.threadTitle + `</a></td>
                                            <td>`+ thread.threadCreatedTime + `</td>
                                            <td>`+ thread.threadContent + `</td>
                                            <td>`+ thread.threadUpvoteCount + `</td>
                                            <td>`+ thread.threadResponseCount + `</td>
                                            <td>`+ thread.forumThreadStatus + `</td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">編輯</a>
                                                
                                            </td>
                                        </tr>
                    `);
                            });
                        },
                        error: function (error) {
                            console.error("Error fetching threads: ", error);
                        }
                    });
                }


                // FUNCTION: SEARCH BAR
                function searchCategoriesByKeyword() {
                    var keyword = $('#searchInput').val();

                    $.ajax({
                        url: '/forum/category/search',
                        method: 'GET',
                        data: { keyword: keyword },
                        dataType: 'json',
                        success: function (categories) {
                            $('#categoryList').empty();


                            categories.forEach(function (category) {
                                $('#categoryList').append(`
                    <tr>
                        <td><input type="checkbox"></td>
                            <td >`+ category.forumCategoryId + `</td>
                            <td > <a href="#detail">`+ category.forumCategoryName + `</a></td>
                            <td>`+ category.forumCategoryDescription + `</td>
                            <td id="updateCategory"> <a href="#" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i>
                            編輯</a>
                    </tr>
                `);
                            });
                        },
                        error: function (xhr, status, error) {
                            $('#threadList').append(`
                                <tr>
                                <td colspan="13">查無資訊，請重新輸入</td>         
                                </tr>
                                            `);
                            console.error('Error searching categories:', error);
                        }
                    });
                }
                function searchCategoriesById() {
                    var categoryId = $('#searchInput').val();
                    $.ajax({
                        url: '/forum/category/find/id/' + categoryId,
                        method: 'GET',
                        dataType: 'json',
                        success: function (category) {
                            $('#categoryList').empty();
                            $('#categoryList').append(`
                <tr>
                    <td><input type="checkbox"></td>
                            <td >`+ category.forumCategoryId + `</td>
                            <td > <a href="#detail">`+ category.forumCategoryName + `</a></td>
                            <td>`+ category.forumCategoryDescription + `</td>
                            <td id="updateCategory"> <a href="#" class="btn btn-primary btn-sm"><i class="fas fa-edit"></i>
                            編輯</a>
                </tr>
            `);
                        },
                        error: function (xhr, status, error) {
                            $('#categoryList').empty();
                            $('#categoryList').append(`
                                <tr>
                                <td colspan="5">查無資訊，請重新輸入</td>         
                                </tr>
                                 `);
                            console.error('Error searching category by ID:', error);
                        }
                    });
                }

                function searchThreadsByKeyword() {
                    var keyword = $('#searchInput').val();

                    $.ajax({
                        url: '/forum/thread/search',
                        method: 'GET',
                        data: { keyword: keyword },
                        dataType: 'json',
                        success: function (threads) {
                            $('#threadList').empty();
                            threads.forEach(function (thread) {
                                $('#threadList').append(`
                                <tr>
                                            <td><input type="checkbox"></td>
                                            <td>`+ thread.threadId + `</td>
                                            <td>`+ thread.forumCategoryId + `</td>
                                            <td>`+ thread.studentId + `</td>
                                            <td>`+ thread.teacherId + `</td>
                                            <td>`+ thread.adminId + `</td>
                                            <td><a href="#">`+ thread.threadTitle + `</a></td>
                                            <td>`+ thread.threadCreatedTime + `</td>
                                            <td>`+ thread.threadContent + `</td>
                                            <td>`+ thread.threadUpvoteCount + `</td>
                                            <td>`+ thread.threadResponseCount + `</td>
                                            <td>`+ thread.forumThreadStatus + `</td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">編輯</a>
                                                
                                            </td>
                                            </tr>
                                            `);
                            });
                        },
                        error: function (xhr, status, error) {
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
                                <tr>
                                            <td><input type="checkbox"></td>
                                            <td>`+ thread.threadId + `</td>
                                            <td>`+ thread.forumCategoryId + `</td>
                                            <td>`+ thread.studentId + `</td>
                                            <td>`+ thread.teacherId + `</td>
                                            <td>`+ thread.adminId + `</td>
                                            <td><a href="#">`+ thread.threadTitle + `</a></td>
                                            <td>`+ thread.threadCreatedTime + `</td>
                                            <td>`+ thread.threadContent + `</td>
                                            <td>`+ thread.threadUpvoteCount + `</td>
                                            <td>`+ thread.threadResponseCount + `</td>
                                            <td>`+ thread.forumThreadStatus + `</td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm">編輯</a>
                                                
                                            </td>
                                            </tr>
                                            `);

                        },
                        error: function (xhr, status, error) {
                            $('#threadList').empty();
                            $('#threadList').append(`
                                <tr>
                                <td colspan="13">查無資訊，請重新輸入</td>         
                                </tr>
                                            `);
                            console.error('Error searching threads:', error);
                        }
                    });
                };

                //TO DO LIST: MERGE WITH KEYWORD?
                function searchThreadsByUsername() { }
            });





            //FUNCTION: BULK DELETE !!!NOT WORKING!!!
            // function setupDeleteHandler(buttonSelector, tableSelector, apiUrl, propertyName, successCallback) {
            //     $(buttonSelector).click(function () {
            //         var selectedCheckboxes = $(tableSelector + ' tbody tr :checkbox:checked');
            //         if (selectedCheckboxes.length === 0) {
            //             Swal.fire('錯誤', '請選擇至少一筆刪除資料', 'error');
            //             return;
            //         }

            //         Swal.fire({
            //             title: '是否刪除選取資料?',
            //             text: '',
            //             icon: 'warning',
            //             showCancelButton: true,
            //             confirmButtonText: '確認',
            //             cancelButtonText: '取消'
            //         }).then((result) => {

            //             if (result.isConfirmed) {

            //                 var idList = [];
            //                 selectedCheckboxes.each(function () {
            //                     var id = $(this).closest('tr').find('td:nth-child(2)').text();
            //                     idList.push(id);
            //                 });

            //                 var data = {};
            //                 data[propertyName] = idList;

            //                 $.ajax({
            //                     url: apiUrl,
            //                     type: 'DELETE',
            //                     data: JSON.stringify(data),
            //                     contentType: 'application/json',
            //                     success: function (response) {
            //                         Swal.fire('刪除成功', '', 'success');
            //                         successCallback; // Refresh the category list
            //                     },
            //                     error: function (xhr, status, error) {
            //                         Swal.fire('刪除失敗', '請檢查連線並重新整理' + error, 'error');
            //                     }
            //                 });
            //             }
            //         });
            //     });
            // }

        </script>


        <header>
            <h1>Soft Skillz</h1>
        </header>


        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div id="sidebar"></div>

                <!-- Right Column: Admin Backstage Content -->
                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <h1 class="mt-4">論壇管理</h1>
                    <div class="search-bar">
                        <div class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text">搜尋條件</span>
                            </div>
                            <select class="form-control" id="searchConditionSelect">
                                <option value="">請選擇搜尋條件</option>
                                <option value="categoryKeyword">[看板] 關鍵字</option>
                                <option value="categoryId">[看板] ID編號</option>
                                <option value="threadKeyword">[文章] 關鍵字</option>
                                <option value="threadUsername">[文章] 使用者名稱</option>
                                <option value="threadId">[文章] ID編號</option>
                                <option value="postKeyword">[留言] 關鍵字</option>
                                <option value="postUsername">[留言] 使用者名稱</option>
                                <option value="postId">[留言] ID編號</option>
                            </select>

                            <input type="text" class="form-control" placeholder="搜尋" id="searchInput">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button" id="searchbtn"><i
                                        class="fas fa-search"></i>
                                    搜尋</button>
                            </div>
                        </div>
                    </div>
                    <nav>
                        <div class="nav nav-tabs " id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-overall-tab" data-toggle="tab"
                                href="#nav-overall" role="tab" aria-controls="nav-overall" aria-selected="true">整體資訊</a>
                            <a class="nav-item nav-link" id="nav-category-tab" data-toggle="tab" href="#nav-category"
                                role="tab" aria-controls="nav-category" aria-selected="false">分類看板</a>
                            <a class="nav-item nav-link" id="nav-threads-tab" data-toggle="tab" href="#nav-threads"
                                role="tab" aria-controls="nav-threads" aria-selected="false">文章管理</a>
                            <a class="nav-item nav-link" id="nav-posts-tab" data-toggle="tab" href="#nav-posts"
                                role="tab" aria-controls="nav-posts" aria-selected="false">留言管理</a>
                            <a class="nav-item nav-link" id="nav-others-tab" data-toggle="tab" href="#nav-others"
                                role="tab" aria-controls="nav-others" aria-selected="false">其他</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <!-- Overall Statistics -->
                        <div class="tab-pane fade show active" id="nav-overall" role="tabpanel"
                            aria-labelledby="nav-overall-tab">
                            <div class="card mt-4">
                                <div class="card-header">
                                    <h5 class="card-title">整體資訊</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="card bg-primary text-white mb-3">
                                                <div class="card-body">
                                                    <h5 class="card-title">分類看板總數</h5>
                                                    <p class="card-text display-4">12</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card bg-success text-white mb-3">
                                                <div class="card-body">
                                                    <h5 class="card-title">文章總數</h5>
                                                    <p class="card-text display-4">245</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card bg-warning text-white mb-3">
                                                <div class="card-body">
                                                    <h5 class="card-title">留言總數</h5>
                                                    <p class="card-text display-4">1,287</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="card bg-danger text-white mb-3">
                                                <div class="card-body">
                                                    <h5 class="card-title">檢舉文章總數</h5>
                                                    <p class="card-text display-4">32</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Categories Tab -->
                        <div class="tab-pane fade" id="nav-category" role="tabpanel" aria-labelledby="nav-category-tab">
                            <button class="btn btn-success mb-3" id="createNewCategory">新增分類看板</button>
                            <button class="btn btn-danger mb-3" id="deleteSelectedCategories">刪除</button>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr class="text-nowrap">
                                            <th><input type="checkbox" id="selectAllCategories" name="categoryMainBox">
                                            </th>
                                            <th>編號</th>
                                            <th>看板名稱</th>
                                            <th>看板說明</th>
                                            <th>編輯</th>
                                        </tr>
                                    </thead>
                                    <tbody id="categoryList">
                                        <!-- Category rows will be dynamically populated here -->

                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Threads Tab -->
                        <div class="tab-pane fade" id="nav-threads" role="tabpanel" aria-labelledby="nav-threads-tab">
                            <button class="btn btn-success mb-3" id="createNewThread">新增文章</button>
                            <button class="btn btn-danger mb-3" id="deleteSelectedThreads">刪除</button>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr class="text-nowrap">
                                            <th><input type="checkbox" id="selectAllThreads" name="threadMainBox"></th>
                                            <th>編號</th>
                                            <th>分類看板</th>
                                            <th>學生編號</th>
                                            <th>老師編號</th>
                                            <th>管理員編號</th>
                                            <th>標題</th>
                                            <th>創建時間</th>
                                            <th>內文</th>
                                            <th>讚數</th>
                                            <th>留言總數</th>
                                            <th>狀態</th>
                                            <th>編輯</th>
                                        </tr>
                                    </thead>
                                    <tbody id="threadList">
                                        <!-- Thread rows will be dynamically populated here -->
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Posts Tab -->
                        <div class="tab-pane fade" id="nav-posts" role="tabpanel" aria-labelledby="nav-posts-tab">
                            <button class="btn btn-success mb-3" id="createNewPost">新增留言</button>
                            <button class="btn btn-danger mb-3" id="deleteSelectedPosts">全部刪除</button>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr class="text-nowrap">
                                            <th><input type="checkbox" id="selectAllPosts"></th>
                                            <th>編號</th>
                                            <th>文章編號</th>
                                            <th>學生編號</th>
                                            <th>老師編號</th>
                                            <th>上層文章編號</th>
                                            <th>內文</th>
                                            <th>讚數</th>
                                            <th>留言總數</th>
                                            <th>創建時間</th>
                                            <th>狀態</th>
                                            <th>編輯</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Post rows will be dynamically populated here -->
                                    <tbody>
                                        <tr>
                                            <td><input type="checkbox" class="selectPost"></td>
                                            <td>1</td>
                                            <td>1</td>
                                            <td>1</td>
                                            <td></td>
                                            <td></td>
                                            <td><a href="#" data-toggle="modal" data-target="#viewPostModal">Post
                                                    Content 1
                                                    (s1)</a></td>
                                            <td>10</td>
                                            <td>0</td>
                                            <td>2023-04-23 10:30:00</td>
                                            <td>VISIBLE</td>
                                            <td>
                                                <a href="#" class="btn btn-primary btn-sm" data-toggle="modal"
                                                    data-target="#editPostModal"><i class="fas fa-edit"></i>編輯</a>
                                                <a href="#" class="btn btn-danger btn-sm" data-toggle="modal"
                                                    data-target="#deletePostModal"><i class="fas fa-trash"></i> 刪除</a>
                                            </td>
                                        </tr>
                                        <!-- Add more rows for other posts here -->
                                    </tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Others Tab -->
                        <div class="tab-pane fade" id="nav-others" role="tabpanel" aria-labelledby="nav-others-tab">
                            <!-- Others content goes here -->
                        </div>
                    </div>
            </div>
        </div>


    </body>

    </html>