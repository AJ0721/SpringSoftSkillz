<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>SoftSkillz - 後台管理</title>

      <link rel="shortcut icon" href="/assets/compiled/svg/favicon.svg" type="image/x-icon" />
      <link rel="shortcut icon"
        href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC"
        type="image/png" />

      <link rel="stylesheet" href="/assets/compiled/css/app.css" />
      <link rel="stylesheet" href="/assets/compiled/css/app-dark.css" />
      <link rel="stylesheet" href="/assets/compiled/css/iconly.css" />

      <style>
        #img {
          width: 130px;
          height: auto;
        }
        
        #showproduct th {
    	text-align: center;
  		}
        
        #showproduct tr td {
    	text-align: center;
  		}
  		
  		#showproduct th {
    vertical-align: middle;
  }
  		
  		#showproduct tr td {
    vertical-align: middle;
  }
      </style>
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
                  <a href="index.html"><img src="/assets/compiled/jpg/logo1.jpg" alt="Logo" srcset="" /></a>
                </div>
                <!-- 切換日間夜間模式 -->
                <div class="theme-toggle d-flex gap-2 align-items-center mt-2">
                  <!-- 日間模式圖片 -->
                  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
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
                    <input class="form-check-input me-0" type="checkbox" id="toggle-dark" style="cursor: pointer" />
                    <label class="form-check-label"></label>
                  </div>
                  <!-- 夜間模式圖片 -->
                  <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
                    role="img" class="iconify iconify--mdi" width="20" height="20" preserveAspectRatio="xMidYMid meet"
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
                      <a href="#" class="submenu-link">Horizontal Menu</a>
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
                      <a href="#" class="submenu-link">Horizontal Menu</a>
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
                      <a href="#" class="submenu-link">Horizontal Menu</a>
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
                      <a href="/course/coursePage/courseAllPage" class="submenu-link">所有課程功能</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">新增課程</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">查詢課程</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">修改課程</a>
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
                      <a href="/teacherSchedule/teacherSchedulePage/teacherScheduleAllPage"
                        class="submenu-link">所有教師行事曆功能</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">新增教師行事曆</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">查詢教師行事曆</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">修改教師行事曆</a>
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
                      <a href="/studentReservation/studentReservationPage/studentReservationAllPage"
                        class="submenu-link">所有學生預約功能</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">新增學生預約</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">查詢學生預約</a>
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
                      <a href="#" class="submenu-link">新增學生行事曆</a>
                    </li>
                    <li class="submenu-item">
                      <a href="#" class="submenu-link">查詢學生行事曆</a>
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
                      <a href="/mall/index" class="submenu-link">商品管理</a>
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
                      <a href="/order" class="submenu-link">商品訂單管理</a>
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
                      <a href="/companion/index.html" class="submenu-link">學伴資料管理</a>
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
              </ul>
            </div>
          </div>
        </div>

        <!-- 中間內容部分 -->
        <div id="main">
          <header class="mb-3">
            <a href="#" class="burger-btn d-block d-xl-none">
              <i class="bi bi-justify fs-3"></i>
            </a>
          </header>

          <div class="page-heading">
            <h3>SoftSkillz - 你的功能</h3>
          </div>
          <div class="page-content">
            <section class="row">
              <div class="col-12 col-lg-9">
                <!-- 卡片中放你的功能內容 -->
                <section class="section">
                  <div class="card">
                    <div class="card-header">
                      <h5 class="card-title">
                        學伴基本資料
                      </h5>

                      <a href="#" class="btn icon icon-left btn-primary"><svg xmlns="http://www.w3.org/2000/svg"
                          width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                          stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit">
                          <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                          <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                        </svg> Primary</a>
                      

                    </div>
                    <div class="card-body">


                      <!-- 我的div -->
                      <div id="productListTitle" align="center">
                        <h2>會員個人條件資料表</h2>
                      </div>
                      
                      <table class="table table-striped table-hover table-responsive-sm justify-content-center">
                      <tbody id="showproduct">
                      </tbody>
                      </table>
                      
                      <table id="showpage">
                        <tr>
                          <td>Total Pages: ${totalPages} totalRecords: ${totalElements}</td>
                          <td colspan="2" align="right">Previous
                            <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                              <button class="btn btn-info" id="myPage" type="button" onclick="change(${i})">${i}</button>
                            </c:forEach>Next
                          </td>
                        </tr>
                      </table>
                      <div align="center" class="m-5">
                        <form method="get" action="../GetAllCompanions">
                          <button class="selectAll" type="submit">顯示全部資料</button>
                        </form>
                        <div><a href="/companionIndex.html" style="text-decoration: none;"><button
                              class="index">回首頁</button></a></div>
                      </div>
                      <!-- 我的div -->




                    </div>
                  </div>

                  <div class="row">
                    <div class="col-12">
                      <div class="card">
                        <div class="card-header">
                          <h4>Profile Visit</h4>
                        </div>
                        <div class="card-body">
                          <div id="chart-profile-visit"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </section>
              </div>

              <!-- 右方第一個卡片列表 -->
              <div class="col-12 col-lg-3">
                <div class="card">
                  <div class="card-body py-4 px-4">
                    <div class="d-flex align-items-center">
                      <div class="avatar avatar-xl">
                        <img src="/assets/compiled/jpg/1.jpg" alt="Face 1" />
                      </div>
                      <div class="ms-3 name">
                        <h5 class="font-bold">管理員名稱</h5>
                        <h6 class="text-muted mb-0">管理員帳號</h6>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- 右方第二個Recent Messages -->
                <div class="card">
                  <div class="card-header">
                    <h4>Recent Messages</h4>
                  </div>
                  <div class="card-content pb-4">
                    <div class="recent-message d-flex px-4 py-3">
                      <div class="avatar avatar-lg">
                        <img src="/assets/compiled/jpg/4.jpg" />
                      </div>
                      <div class="name ms-4">
                        <h5 class="mb-1">Hank Schrader</h5>
                        <h6 class="text-muted mb-0">@johnducky</h6>
                      </div>
                    </div>
                    <div class="recent-message d-flex px-4 py-3">
                      <div class="avatar avatar-lg">
                        <img src="/assets/compiled/jpg/5.jpg" />
                      </div>
                      <div class="name ms-4">
                        <h5 class="mb-1">Dean Winchester</h5>
                        <h6 class="text-muted mb-0">@imdean</h6>
                      </div>
                    </div>
                    <div class="recent-message d-flex px-4 py-3">
                      <div class="avatar avatar-lg">
                        <img src="/assets/compiled/jpg/1.jpg" />
                      </div>
                      <div class="name ms-4">
                        <h5 class="mb-1">John Dodol</h5>
                        <h6 class="text-muted mb-0">@dodoljohn</h6>
                      </div>
                    </div>
                    <div class="px-4">
                      <button class="btn btn-block btn-xl btn-outline-primary font-bold mt-3">
                        Start Conversation
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </section>
          </div>

          <footer>
            <div class="footer clearfix mb-0 text-muted">
              <div class="float-start">
                <p>2024 &copy; Soft Skillz</p>
              </div>
            </div>
          </footer>
        </div>
      </div>

      <script src="/assets/extensions/jquery/jquery.min.js"></script>
      <script src="/assets/extensions/datatables.net/js/jquery.dataTables.min.js"></script>
      <script src="/assets/extensions/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
      <script src="/assets/static/js/pages/datatables.js"></script>
      <script>
        $(document).ready(function () {
          $('#table_id').DataTable();
        });

        $('#table_id').DataTable({
          /*設定屬性(預設功能)區塊*/
          "searching": false, // 預設為true 搜尋功能，若要開啟不用特別設定
          "paging": true, // 預設為true 分頁功能，若要開啟不用特別設定
          "ordering": true, // 預設為true 排序功能，若要開啟不用特別設定
          "sPaginationType": "full_numbers", // 分頁樣式 預設為"full_numbers"，若需其他樣式才需設定
          "lengthMenu": [[1, 5, 10, 30]], //顯示筆數設定 預設為[10, 25, 50, 100]
          "pageLength": '5',// 預設為'10'，若需更改初始每頁顯示筆數，才需設定
          "processing": true, // 預設為false 是否要顯示當前資料處理狀態資訊
          "serverSide": false, // 預設為false 是否透過Server端處理分頁…等
          "stateSave": false, // 預設為false 在頁面刷新時，是否要保存當前表格資料與狀態
          "destroy": false, // 預設為false 是否銷毀當前暫存資料
          "info": true, // 預設為true　是否要顯示"目前有 x  筆資料"
          "autoWidth": false, // 預設為true　設置是否要自動調整表格寬度(false代表不要自適應)　　　　
          "scrollCollapse": true, // 預設為false 是否開始滾軸功能控制X、Y軸
          //"scrollY": "200px", // 若有設置為Y軸(垂直)最大高度
          "dom": 'lrtip',// 設置搜尋div、頁碼div...等基本位置/外觀..等，詳細可看官網
          //設定資料來源區塊(data or ajax….等),
          //設定資料欄位區塊(columns),
          //設定語言區塊(language),
          //設定欄位元素定義區塊(columnDefs),
          // 設定列元素區塊(rowCallback)…等
        })

      </script>
      <!--             使用 moment.js 在前端進行日期格式化 -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

      <script>
        var indexPage = 1;

        $(function () {
          loadPage(indexPage);
        });

        function change(page) {
          indexPage = page;
          loadPage(indexPage);
        }

        function loadPage(indexPage) {
          console.log("loadPage");
          $.ajax({
            type: 'get',
            url: '/queryByPage/' + indexPage,
            contentType: 'application/json',
            success: function (data) {
              console.log("data : " + data);

              $('#showproduct').empty("");

              if (data.length === 0) {
                $('table').prepend('<tr><td>no result</td></tr>');
              } else {
                var table = $('#showproduct');
                table.append("<tr id='ptitle'>" + "<th>編號</th><th>學生會員編號</th><th>帳號暱稱</th><th>性別</th><th>生日</th><th>母語</th><th>會說語言</th><th>學習興趣</th><th>學習頻率</th><th>照片</th>");

                $.each(data, function (i, n) {
                  <!-- 使用 moment.js 在前端進行日期格式化 -->
                  var birthDate = new Date(n.studentBirth);
                  var formattedBirthDate = moment(birthDate).format("YYYY-MM-DD");
                  var tr = "<tr><td>" + n.companionId + "</td><td>" + n.studentId + "</td><td>" + n.studentNickname + "</td><td>" + n.studentGender + "</td><td>" + formattedBirthDate + "</td><td>" + n.companionFirstLanguage + "</td><td>" + n.companionSpeakingLanguage + "</td><td>" + n.companionLearningInterest + "</td><td>" + n.companionLearningFrequency + "</td><td><img id='img' src=" + n.studentPhoto + "></td></tr>";
                  table.append(tr);
                });
              }
            }
          });
        }
      </script>
    </body>

    </html>