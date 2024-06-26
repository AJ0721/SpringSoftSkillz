<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SoftSkillz - 新增商品訂單</title>
    <link rel="shortcut icon" href="/assets/compiled/svg/favicon.svg" type="image/x-icon"/>
    <link rel="shortcut icon"
          href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ9ImFjdGlvbiIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIiBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC"
          type="image/png"/>

    <link rel="stylesheet" href="/assets/compiled/css/app.css"/>
    <link rel="stylesheet" href="/assets/compiled/css/app-dark.css"/>
    <link rel="stylesheet" href="/assets/compiled/css/iconly.css"/>

    <link rel="stylesheet"
          href="/assets/extensions/datatables.net-bs5/css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="/assets/compiled/css/table-datatable-jquery.css"/>
</head>

<body>
<script src="/assets/static/js/initTheme.js"></script>
<div id="app">
    <div id="sidebar">
        <div class="sidebar-wrapper active">
            <div class="sidebar-header position-relative">
                <div class="d-flex justify-content-between align-items-center">
                    <!-- 左上角Logo -->
                    <div class="logo">
                        <a href="/softskillz/newhomepage"><img src="/assets/compiled/jpg/logo1.jpg" alt="Logo"
                                                               srcset=""/></a>
                    </div>
                    <!-- 切換日間夜間模式 -->
                    <div class="theme-toggle d-flex gap-2 align-items-center mt-2">
                        <!-- 日間模式圖片 -->
                        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                             role="img" class="iconify iconify--system-uicons" width="20" height="20"
                             preserveAspectRatio="xMidYMid meet" viewBox="0 0 21 21">
                            <g fill="none" fill-rule="evenodd" stroke="currentColor" stroke-linecap="round"
                               stroke-linejoin="round">
                                <path
                                        d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
                                        opacity=".3"></path>
                                <g transform="translate(-210 -1)">
                                    <path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
                                    <circle cx="220.5" cy="11.5" r="4"></circle>
                                    <path d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2"></path>
                                </g>
                            </g>
                        </svg>
                        <!-- 切換按鈕 -->
                        <div class="form-check form-switch fs-6">
                            <input class="form-check-input me-0" type="checkbox" id="toggle-dark"
                                   style="cursor: pointer"/>
                            <label class="form-check-label"></label>
                        </div>
                        <!-- 夜間模式圖片 -->
                        <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
                             role="img" class="iconify iconify--mdi" width="20" height="20"
                             preserveAspectRatio="xMidYMid meet"
                             viewBox="0 0 24 24">
                            <path fill="currentColor"
                                  d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z">
                            </path>
                        </svg>
                    </div>
                    <div class="sidebar-toggler x">
                        <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                    </div>
                </div>
            </div>
            <!-- 側邊欄 -->
            <div class="sidebar-menu">
                <ul class="menu">
                    <li class="sidebar-item active">
                        <a href="/softskillz/newhomepage" class="sidebar-link">
                            <i class="bi bi-grid-fill"></i>
                            <span>首頁</span>
                        </a>
                    </li>
                    <li class="sidebar-title">用戶管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>管理員</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/admin/admin-account" class="submenu-link">管理員帳號</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>教師</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/teacher/teacher-account" class="submenu-link">教師帳號</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>學生</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/student/student-account" class="submenu-link">學生帳號</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-title">課程管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>課程</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/course/insertPage" class="submenu-link">新增課程</a>
                            </li>
                            <li class="submenu-item">
                                <a href="/course/selectAllPage" class="submenu-link">查詢課程</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>教師行事曆</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/teacherSchedule/insertPage" class="submenu-link">新增教師行事曆</a>
                            </li>
                            <li class="submenu-item">
                                <a href="/teacherSchedule/selectAllPage" class="submenu-link">查詢教師行事曆</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>學生預約</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/studentReservation/insertPage" class="submenu-link">新增學生預約</a>
                            </li>
                            <li class="submenu-item">
                                <a href="/studentReservation/selectAllPage" class="submenu-link">查詢學生預約</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>學生行事曆</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/studentSchedule/selectAllPage" class="submenu-link">查詢學生行事曆</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-title">課程訂單管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>課程訂單管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/adminorder/adorder.do" class="submenu-link">課程訂單管理</a>
                            </li>
                            <li class="submenu-item">
                                <a href="/coursediscount/discount.do" class="submenu-link">課程折扣管理</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-title">商品管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>商品管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/mall/mallProductAll" class="submenu-link">商品管理</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-title">商品訂單管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>商品訂單管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/order/all" class="submenu-link">商品訂單管理</a>
                            </li>
                            <li class="submenu-item">
                                <a href="/order/createPage" class="submenu-link">新增商品訂單</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-title">學伴資料管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>學伴資料管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/companionIndex.html" class="submenu-link">學伴資料管理</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-title">論壇管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>論壇管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/forum/adminhome" class="submenu-link">論壇管理</a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-title">訊息管理</li>
                    <li class="sidebar-item has-sub">
                        <a href="#" class="sidebar-link">
                            <i class="bi bi-grid-1x2-fill"></i>
                            <span>訊息管理</span>
                        </a>
                        <ul class="submenu">
                            <li class="submenu-item">
                                <a href="/chat/coursechat.do" class="submenu-link">訊息管理</a>
                            </li>
                        </ul>
                    </li>

                    <br/>
                    <form action="/admin/admin-logout" method="post" style="text-align: center; margin: 0 auto">
                        <button type="submit" class="btn rounded-pill" style="background-color: #3f6cba; color: white">
                            <i class="bi bi-person-circle"></i>&nbsp;登出
                        </button>
                    </form>
                </ul>
            </div>
        </div>
    </div>
    <!-- 中間內容部分 -->
    <div id="main" class="container-fluid">
        <div class="page-heading">
            <h3>SoftSkillz - 新增商品訂單</h3>
        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-12 col-lg-10">
                    <section class="section">
                        <div class="card">
                            <div class="card-header">
                                <!-- 新增商品訂單表單部分 -->
                                <h4 class="card-title">新增商品訂單</h4>
                            </div>
                            <div class="card-body">

                                <div class="form-group">
                                    <label for="orderDate">訂單日期:</label>
                                    <input type="datetime-local" class="form-control" id="orderDate" name="order_date">
                                </div>
                                <div class="form-group">
                                    <label for="totalAmount">總金額:</label>
                                    <input type="number" class="form-control" id="totalAmount" name="total_amount"
                                           placeholder="總金額">
                                </div>
                                <div class="form-group">
                                    <label for="orderStatus">訂單狀態:</label>
                                    <select class="form-control" id="orderStatus" name="order_status">
                                        <option value="">請選擇訂單狀態</option>
                                        <option value="已付款">已付款</option>
                                        <option value="未付款">未付款</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="paymentMethod">付款方式:</label>
                                    <select class="form-control" id="paymentMethod" name="payment_method">
                                        <option value="">請選擇付款方式</option>
                                        <option value="綠界">綠界</option>
                                        <option value="LINE PAY">LINE PAY</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="shipmentDate">出貨日期:</label>
                                    <input type="datetime-local" class="form-control" id="shipmentDate"
                                           name="shipment_date">
                                </div>
                                <div class="form-group">
                                    <label for="shipmentStatus">出貨狀態:</label>
                                    <select class="form-control" id="shipmentStatus" name="shipment_status">
                                        <option value="">請選擇出貨狀態</option>
                                        <option value="已出貨">已出貨</option>
                                        <option value="未出貨">未出貨</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="customerName">收貨人姓名:</label>
                                    <input type="text" class="form-control" id="customerName" name="customer_name"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label for="phone">電話:</label>
                                    <input type="text" class="form-control" id="phone" name="phone" required>
                                </div>
                                <div class="form-group">
                                    <label for="postalCode">郵遞區號:</label>
                                    <input type="text" class="form-control" id="postalCode" name="postal_code" required>
                                </div>
                                <div class="form-group">
                                    <label for="shippingAddress">收貨地址:</label>
                                    <input type="text" class="form-control" id="shippingAddress" name="shipping_address"
                                           required>
                                </div>
                                <div class="form-group">
                                    <label for="notes">備註:</label>
                                    <input type="text" class="form-control" id="notes" name="notes">
                                </div>
                                <div class="text-center">
                                    <button type="button" class="btn btn-primary" id="submitOrder">提交</button>
                                    <button type="button" class="btn btn-secondary" id="autoFillOrder">一鍵輸入</button>
                                    <a href="/order/all" class="btn btn-secondary">返回訂單列表</a>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer clearfix mb-0 text-muted">
            <div class="float-start">
                <p>2024 &copy; Soft Skillz</p>
            </div>
        </div>
    </footer>
</div>

<script src="/assets/static/js/components/dark.js"></script>
<script src="/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

<script src="/assets/compiled/js/app.js"></script>

<!-- Need: Apexcharts -->
<script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
<script src="/assets/static/js/pages/dashboard.js"></script>
<script src="/assets/static/js/pages/ui-apexchart.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    $(document).ready(function () {
        $('#submitOrder').click(function (e) {
            e.preventDefault();

            var orderData = {
                orderDate: $('#orderDate').val(),
                totalAmount: $('#totalAmount').val(),
                orderStatus: $('#orderStatus').val(),
                paymentMethod: $('#paymentMethod').val(),
                shipmentDate: $('#shipmentDate').val(),
                shipmentStatus: $('#shipmentStatus').val(),
                customerName: $('#customerName').val(),
                phone: $('#phone').val(),
                postalCode: $('#postalCode').val(),
                shippingAddress: $('#shippingAddress').val(),
                notes: $('#notes').val()
            };

            $.ajax({
                url: '/api/order/create',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(orderData),
                success: function (response) {
                    Swal.fire({
                        title: '訂單創建成功',
                        icon: 'success',
                        confirmButtonText: '確認'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = '/order/all';
                        }
                    });
                },
                error: function (error) {
                    Swal.fire({
                        title: '創建訂單失敗',
                        text: '請檢查輸入資料後重試',
                        icon: 'error',
                        confirmButtonText: '確認'
                    });
                }
            });
        });

        $('#autoFillOrder').click(function () {
            $('#orderDate').val(new Date().toISOString().slice(0, 16));
            $('#totalAmount').val(646);
            $('#orderStatus').val('已付款');
            $('#paymentMethod').val('綠界');
            $('#shipmentDate').val(new Date().toISOString().slice(0, 16));
            $('#shipmentStatus').val('已出貨');
            $('#customerName').val('林佳穎');
            $('#phone').val('0912345678');
            $('#postalCode').val('320');
            $('#shippingAddress').val('320桃園市中壢區中華路一段450號');
            $('#notes').val('請在5/31前送達');
        });

    });
</script>
</body>
</html>
