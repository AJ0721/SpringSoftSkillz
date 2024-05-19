<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SoftSkillz - 新增學生預約頁面</title>

    <link
      rel="shortcut icon"
      href="/assets/compiled/svg/favicon.svg"
      type="image/x-icon"
    />
    <link
      rel="shortcut icon"
      href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACEAAAAiCAYAAADRcLDBAAAEs2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS41LjAiPgogPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4KICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIKICAgIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIKICAgIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIgogICAgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIKICAgZXhpZjpQaXhlbFhEaW1lbnNpb249IjMzIgogICBleGlmOlBpeGVsWURpbWVuc2lvbj0iMzQiCiAgIGV4aWY6Q29sb3JTcGFjZT0iMSIKICAgdGlmZjpJbWFnZVdpZHRoPSIzMyIKICAgdGlmZjpJbWFnZUxlbmd0aD0iMzQiCiAgIHRpZmY6UmVzb2x1dGlvblVuaXQ9IjIiCiAgIHRpZmY6WFJlc29sdXRpb249Ijk2LjAiCiAgIHRpZmY6WVJlc29sdXRpb249Ijk2LjAiCiAgIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiCiAgIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIKICAgeG1wOk1vZGlmeURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiCiAgIHhtcDpNZXRhZGF0YURhdGU9IjIwMjItMDMtMzFUMTA6NTA6MjMrMDI6MDAiPgogICA8eG1wTU06SGlzdG9yeT4KICAgIDxyZGY6U2VxPgogICAgIDxyZGY6bGkKICAgICAgc3RFdnQ6YWN0aW9uPSJwcm9kdWNlZCIKICAgICAgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWZmaW5pdHkgRGVzaWduZXIgMS4xMC4xIgogICAgICBzdEV2dDp3aGVuPSIyMDIyLTAzLTMxVDEwOjUwOjIzKzAyOjAwIi8+CiAgICA8L3JkZjpTZXE+CiAgIDwveG1wTU06SGlzdG9yeT4KICA8L3JkZjpEZXNjcmlwdGlvbj4KIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+Cjw/eHBhY2tldCBlbmQ9InIiPz5V57uAAAABgmlDQ1BzUkdCIElFQzYxOTY2LTIuMQAAKJF1kc8rRFEUxz9maORHo1hYKC9hISNGTWwsRn4VFmOUX5uZZ36oeTOv954kW2WrKLHxa8FfwFZZK0WkZClrYoOe87ypmWTO7dzzud97z+nec8ETzaiaWd4NWtYyIiNhZWZ2TvE946WZSjqoj6mmPjE1HKWkfdxR5sSbgFOr9Ll/rXoxYapQVik8oOqGJTwqPL5i6Q5vCzeo6dii8KlwpyEXFL519LjLLw6nXP5y2IhGBsFTJ6ykijhexGra0ITl5bRqmWU1fx/nJTWJ7PSUxBbxJkwijBBGYYwhBgnRQ7/MIQIE6ZIVJfK7f/MnyUmuKrPOKgZLpEhj0SnqslRPSEyKnpCRYdXp/9++msneoFu9JgwVT7b91ga+LfjetO3PQ9v+PgLvI1xkC/m5A+h7F32zoLXug38dzi4LWnwHzjeg8UGPGbFfySvuSSbh9QRqZ6H+Gqrm3Z7l9zm+h+iafNUV7O5Bu5z3L/wAdthn7QIme0YAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAJTSURBVFiF7Zi9axRBGIefEw2IdxFBRQsLWUTBaywSK4ubdSGVIY1Y6HZql8ZKCGIqwX/AYLmCgVQKfiDn7jZeEQMWfsSAHAiKqPiB5mIgELWYOW5vzc3O7niHhT/YZvY37/swM/vOzJbIqVq9uQ04CYwCI8AhYAlYAB4Dc7HnrOSJWcoJcBS4ARzQ2F4BZ2LPmTeNuykHwEWgkQGAet9QfiMZjUSt3hwD7psGTWgs9pwH1hC1enMYeA7sKwDxBqjGnvNdZzKZjqmCAKh+U1kmEwi3IEBbIsugnY5avTkEtIAtFhBrQCX2nLVehqyRqFoCAAwBh3WGLAhbgCRIYYinwLolwLqKUwwi9pxV4KUlxKKKUwxC6ZElRCPLYAJxGfhSEOCz6m8HEXvOB2CyIMSk6m8HoXQTmMkJcA2YNTHm3congOvATo3tE3A29pxbpnFzQSiQPcB55IFmFNgFfEQeahaAGZMpsIJIAZWAHcDX2HN+2cT6r39GxmvC9aPNwH5gO1BOPFuBVWAZue0vA9+A12EgjPadnhCuH1WAE8ivYAQ4ohKaagV4gvxi5oG7YSA2vApsCOH60WngKrA3R9IsvQUuhIGY00K4flQG7gHH/mLytB4C42EgfrQb0mV7us8AAMeBS8mGNMR4nwHamtBB7B4QRNdaS0M8GxDEog7iyoAguvJ0QYSBuAOcAt71Kfl7wA8DcTvZ2KtOlJEr+ByyQtqqhTyHTIeB+ONeqi3brh+VgIN0fohUgWGggizZFTplu12yW8iy/YLOGWMpDMTPXnl+Az9vj2HERYqPAAAAAElFTkSuQmCC"
      type="image/png"
    />

    <link rel="stylesheet" href="/assets/compiled/css/app.css" />
    <link rel="stylesheet" href="/assets/compiled/css/app-dark.css" />
    <link rel="stylesheet" href="/assets/compiled/css/iconly.css" />

    <!-- sweet alert -->
    <link
      rel="stylesheet"
      href="/assets/extensions/sweetalert2/sweetalert2.min.css"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                <a href="/softskillz/newhomepage"
                  ><img
                    src="/assets/compiled/jpg/logo1.jpg"
                    alt="Logo"
                    srcset=""
                /></a>
              </div>
              <!-- 切換日間夜間模式 -->
              <div class="theme-toggle d-flex gap-2 align-items-center mt-2">
                <!-- 日間模式圖片 -->
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                  aria-hidden="true"
                  role="img"
                  class="iconify iconify--system-uicons"
                  width="20"
                  height="20"
                  preserveAspectRatio="xMidYMid meet"
                  viewBox="0 0 21 21"
                >
                  <g
                    fill="none"
                    fill-rule="evenodd"
                    stroke="currentColor"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                    <path
                      d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
                      opacity=".3"
                    ></path>
                    <g transform="translate(-210 -1)">
                      <path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
                      <circle cx="220.5" cy="11.5" r="4"></circle>
                      <path
                        d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2"
                      ></path>
                    </g>
                  </g>
                </svg>
                <!-- 切換按鈕 -->
                <div class="form-check form-switch fs-6">
                  <input
                    class="form-check-input me-0"
                    type="checkbox"
                    id="toggle-dark"
                    style="cursor: pointer"
                  />
                  <label class="form-check-label"></label>
                </div>
                <!-- 夜間模式圖片 -->
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  xmlns:xlink="http://www.w3.org/1999/xlink"
                  aria-hidden="true"
                  role="img"
                  class="iconify iconify--mdi"
                  width="20"
                  height="20"
                  preserveAspectRatio="xMidYMid meet"
                  viewBox="0 0 24 24"
                >
                  <path
                    fill="currentColor"
                    d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z"
                  ></path>
                </svg>
              </div>
              <div class="sidebar-toggler x">
                <a href="#" class="sidebar-hide d-xl-none d-block"
                  ><i class="bi bi-x bi-middle"></i
                ></a>
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
                    <a href="/admin/admin-account" class="submenu-link"
                      >管理員帳號</a
                    >
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
                    <a href="/teacher/teacher-account" class="submenu-link"
                      >教師帳號</a
                    >
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
                    <a href="/student/student-account" class="submenu-link"
                      >學生帳號</a
                    >
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
                    <a href="/course/insertPage" class="submenu-link"
                      >新增課程</a
                    >
                  </li>
                  <li class="submenu-item">
                    <a href="/course/selectAllPage" class="submenu-link"
                      >查詢課程</a
                    >
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
                    <a href="/teacherSchedule/insertPage" class="submenu-link"
                      >新增教師行事曆</a
                    >
                  </li>
                  <li class="submenu-item">
                    <a
                      href="/teacherSchedule/selectAllPage"
                      class="submenu-link"
                      >查詢教師行事曆</a
                    >
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
                    <a
                      href="/studentReservation/insertPage"
                      class="submenu-link"
                      >新增學生預約</a
                    >
                  </li>
                  <li class="submenu-item">
                    <a
                      href="/studentReservation/selectAllPage"
                      class="submenu-link"
                      >查詢學生預約</a
                    >
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
                    <a
                      href="/studentSchedule/selectAllPage"
                      class="submenu-link"
                      >查詢學生行事曆</a
                    >
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
                    <a href="/adminorder/adorder.do" class="submenu-link"
                      >課程訂單管理</a
                    >
                  </li>
                  <li class="submenu-item">
                    <a href="/coursediscount/discount.do" class="submenu-link"
                      >課程折扣管理</a
                    >
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
                    <a href="/mall/mallProductAll" class="submenu-link"
                      >商品管理</a
                    >
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
                  <li class="submenu-item">
                    <a href="/order/create" class="submenu-link"
                      >新增商品訂單</a
                    >
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
                    <a href="/companionIndex.html" class="submenu-link"
                      >學伴資料管理</a
                    >
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
                    <a href="/chat/coursechat.do" class="submenu-link"
                      >訊息管理</a
                    >
                  </li>
                </ul>
              </li>

              <br />
              <form
                action="/admin/admin-logout"
                method="post"
                style="text-align: center; margin: 0 auto"
              >
                <button
                  type="submit"
                  class="btn rounded-pill"
                  style="background-color: #3f6cba; color: white"
                >
                  <i class="bi bi-person-circle"></i>&nbsp;登出
                </button>
              </form>
            </ul>
          </div>
        </div>
      </div>

      <div id="main">
        <header class="mb-3">
          <a href="#" class="burger-btn d-block d-xl-none">
            <i class="bi bi-justify fs-3"></i>
          </a>
        </header>

        <div class="page-heading">
          <h3>SoftSkillz - 新增學生預約頁面</h3>
        </div>
        <div class="page-content">
          <section class="row">
            <div class="col-12">
              <!-- 新增學生預約的東東 -->
              <div class="card">
                <h3 class="card-header">新增學生預約資料</h3>
                <div class="card-body">
                  <form
                    id="scheduleForm"
                    method="post"
                    action="${pageContext.request.contextPath}/studentReservation/add"
                  >
                    <!-- 課程選擇 -->
                    <div class="dropdown mb-3">
                      <label for="courseID" class="form-label">課程編號:</label>
                      <select
                        class="form-select"
                        id="courseID"
                        name="courseID"
                        required
                      >
                        <option value="">請選擇課程</option>
                        <c:forEach items="${courses}" var="course">
                          <option
                            value="${course.courseID}"
                            data-teacher-id="${course.teacherID}"
                          >
                            ${course.courseID}, 教師編號：${course.teacherID},
                            ${course.courseName}
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                    <!-- 教師行事曆選擇 -->
                    <div class="dropdown mb-3">
                      <label for="teacherScheduleID" class="form-label"
                        >教師行事曆編號:</label
                      >
                      <select
                        class="form-select"
                        id="teacherScheduleID"
                        name="teacherScheduleID"
                        required
                      >
                        <option value="">請選擇教師行事曆</option>
                        <c:forEach
                          items="${teacherSchedules}"
                          var="teacherSchedule"
                        >
                          <option
                            class="teacher-schedule"
                            value="${teacherSchedule.teacherScheduleID}"
                            data-teacher-id="${teacherSchedule.teacherID}"
                          >
                            ${teacherSchedule.teacherScheduleID},
                            教師編號：${teacherSchedule.teacherID},
                            日期：${teacherSchedule.courseDate}
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                    <p>
                      學生編號 :
                      <select
                        class="form-select mb-3"
                        id="studentID"
                        name="studentID"
                        required
                      >
                        <option value="">請選擇學生</option>
                        <c:forEach items="${students}" var="students">
                          <option
                            class="students"
                            value="${students.studentId}"
                            data-student-id="${students.studentId}"
                          >
                            ${students.studentFirstName}
                            ${students.studentLastName} (ID:
                            ${students.studentIdFormatted})
                          </option>
                        </c:forEach>
                      </select>
                    </p>
                    <fieldset>
                      <legend>預約時段 :</legend>
                      <!-- 使用 JavaScript 生成開課時段按鈕 -->
                      <div class="row">
                        <div id="timeSlots1" class="column"></div>
                        <div id="timeSlots2" class="column"></div>
                      </div>
                    </fieldset>

                    <div class="text-center">
                      <!-- 提交表單的按鈕 -->
                      <button
                        type="submit"
                        class="btn btn-primary btn-lg"
                        id="submitButton"
                      >
                        新增
                      </button>
                      <!-- 隐藏字段，用于传递已选择的時間段數據、預約日期、總選擇時段 -->
                      <input
                        type="hidden"
                        id="studentTimeSlotsInput"
                        name="studentTimeSlots"
                      />
                      <input
                        type="hidden"
                        id="reservationDate"
                        name="reservationDate"
                        value=""
                      />
                      <input
                        type="hidden"
                        id="totalHours"
                        name="totalHours"
                        value=""
                      />
                    </div>
                  </form>
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

    <script src="/assets/static/js/components/dark.js"></script>
    <script src="/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

    <script src="/assets/compiled/js/app.js"></script>

    <!-- Need: Apexcharts -->
    <script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
    <script src="/assets/static/js/pages/dashboard.js"></script>

    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- sweet alert -->
    <script src="/assets/static/js/pages/sweetalert2.js"></script>
    <script src="/assets/extensions/sweetalert2/sweetalert2.min.js"></script>

    <script>
      $(document).ready(function () {
        $("#courseID").change(function () {
          var selectedTeacherId = $(this)
            .find("option:selected")
            .data("teacher-id");
          $("#teacherScheduleID option").each(function () {
            if (
              $(this).data("teacher-id") == selectedTeacherId ||
              $(this).val() == ""
            ) {
              $(this).show();
            } else {
              $(this).hide();
            }
          });
        });
      });

      var studentTimeSlots = [];

      function createTimeSlotButton(hour) {
        var button = document.createElement("button"); // 改用button元素
        button.type = "button";
        button.innerHTML = hour + ":00"; // 使用innerHTML設置按鈕文本
        button.className = "btn btn-secondary"; // 使用Bootstrap樣式
        button.style.marginRight = "8px"; // 直接設定右邊距為8px
        button.style.marginBottom = "8px"; // 直接設定下邊距為8px
        button.onclick = function () {
          if (this.classList.contains("btn-success")) {
            this.classList.remove("btn-success");
            this.classList.add("btn-secondary");
            var index = studentTimeSlots.indexOf(this.innerHTML);
            studentTimeSlots.splice(index, 1);
          } else {
            this.classList.add("btn-success");
            this.classList.remove("btn-secondary");
            studentTimeSlots.push(this.innerHTML);
          }
          document.getElementById("studentTimeSlotsInput").value =
            JSON.stringify(studentTimeSlots);
        };
        return button;
      }

      for (var i = 0; i < 24; i++) {
        var hour = ("0" + i).slice(-2);
        var button = createTimeSlotButton(hour);
        if (i < 12) {
          document.getElementById("timeSlots1").appendChild(button);
        } else {
          document.getElementById("timeSlots2").appendChild(button);
        }
      }

      //開課時段表單
      document
        .getElementById("scheduleForm")
        .addEventListener("submit", function (event) {
          event.preventDefault(); // 阻止表單預設提交行為

          var today = new Date();
          var reservationDate =
            today.getFullYear() +
            "-" +
            (today.getMonth() + 1).toString().padStart(2, "0") +
            "-" +
            today.getDate().toString().padStart(2, "0");
          $("#reservationDate").val(reservationDate);
          $("#totalHours").val(studentTimeSlots.length);
          $("#studentTimeSlotsInput").val(JSON.stringify(studentTimeSlots));

          if (studentTimeSlots.length === 0) {
            Swal.fire({
              title: "錯誤!",
              text: "請至少選擇一個時段！",
              icon: "error",
              confirmButtonText: "確定",
            });
          } else {
            submitForm(); // 現在呼叫 submitForm 函數來處理表單提交
          }
        });

      function submitForm() {
        var formData = $("#scheduleForm").serialize(); // 序列化表單數據

        // 發送 AJAX 請求到後端提交表單
        $.ajax({
          url: $("#scheduleForm").attr("action"), // 使用表單的action屬性
          type: "POST",
          data: formData,
          success: function (response) {
            if (response.success) {
              Swal.fire({
                title: "成功!",
                text: response.message,
                icon: "success",
              }).then((result) => {
                if (result.value) {
                  window.location.reload(); // 刷新頁面
                }
              });
            } else {
              Swal.fire({
                title: "錯誤!",
                text: response.message,
                icon: "error",
                confirmButtonText: "確定",
              });
            }
          },
          error: function () {
            Swal.fire({
              title: "錯誤!",
              text: "該時段已被預約,請選擇其他時段。",
              icon: "error",
              confirmButtonText: "確定",
            });
          },
        });
      }
    </script>
  </body>
</html>
