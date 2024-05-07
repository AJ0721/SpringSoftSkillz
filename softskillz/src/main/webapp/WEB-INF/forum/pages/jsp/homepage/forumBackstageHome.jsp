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

        <!-- FETCH HTML SIDE BAR -->
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

                <!-- Right Column: Admin Backstage Content -->
                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <h1 class="mt-4">論壇管理</h1>

                    <!-- search bar -->
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
                        <div class="nav nav-tabs " id="nav-overll-tab" role="tablist">
                            <a class="nav-item nav-link active" id="nav-overall-tab" data-toggle="tab"
                                href="#nav-overall" role="tab" aria-controls="nav-overall" aria-selected="true">整體資訊</a>
                            <a class="nav-item nav-link" id="nav-category-tab" data-toggle="tab" href="#nav-category"
                                role="tab" aria-controls="nav-category" aria-selected="false">分類看板</a>
                            <a class="nav-item nav-link" id="nav-threads-tab" data-toggle="tab" href="#nav-thread"
                                role="tab" aria-controls="nav-threads" aria-selected="false">文章管理</a>
                            <a class="nav-item nav-link" id="nav-posts-tab" data-toggle="tab" href="#nav-post"
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
                            <button class="btn btn-success mb-3" id="createNewCategory">新增分類</button>
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
                        <div class="tab-pane fade" id="nav-thread" role="tabpanel" aria-labelledby="nav-threads-tab">
                            <button class="btn btn-success mb-3" id="createNewThread">新增文章</button>
                            <button class="btn btn-danger mb-3" id="deleteSelectedThreads">刪除</button>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr class="text-nowrap">
                                            <th><input type="checkbox" id="selectAllThreads" name="threadMainBox"></th>
                                            <th>編號</th>
                                            <th>標題</th>
                                            <th>分類看板</th>
                                            <th>學生編號</th>
                                            <th>老師編號</th>
                                            <th>管理員編號</th>
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
                        <div class="tab-pane fade" id="nav-post" role="tabpanel" aria-labelledby="nav-posts-tab">
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
                </main>
            </div>
        </div>



        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="/forum/js/categoryTab.js"></script>
        <script src="/forum/js/threadTab.js"></script>
        <script src="/forum/js/postTab.js"></script>


        <script>

            $(document).ready(function () {



                // Redirect to assigned tab based on hash in URL
                var hash = window.location.hash;
                if (hash) {
                    $('.nav-tabs a[href="' + hash + '"]').tab('show');
                }

                $('a[data-toggle="tab"]').off('shown.bs.tab').on('shown.bs.tab', function (e) {
                    var target = $(e.target).attr('href');
                    window.location.hash = target;
                    console.log("Tab shown:", target);
                    // Activated tab
                    switch (target) {
                        case '#nav-category':
                            $('#categoryList').empty();
                            fetchCategories().done(function (categories) { //jquery syntax: done/fail 
                                displayCategoriesTab(categories);
                            }).fail(function (error) {
                                console.error("Error fetching categories:", error);
                                $('#categoryList').html('<tr><td colspan="5">資料載入失敗，請重新整理。</td></tr>');
                            });
                            break;
                        case '#nav-thread':
                            $('#threadList').empty();
                            fetchThreads().done(function (threads) {
                                displayThreadsTab(threads);
                            }).fail(function (error) {
                                console.error("Error fetching threads:", error);
                                $('#threadList').html('<tr><td colspan="13">資料載入失敗，請重新整理。</td></tr>');
                            });
                            break;
                        case '#nav-post':
                            $('#postList').empty();
                            fetchThreads().done(function (posts) {
                                displayThreadsTab(posts);
                            }).fail(function (error) {
                                console.error("Error fetching posts:", error);
                                $('#postList').html('<tr><td colspan="13">資料載入失敗，請重新整理。</td></tr>');
                            });
                            break;
                    }
                });


            });




        </script>

    </body>

    </html>