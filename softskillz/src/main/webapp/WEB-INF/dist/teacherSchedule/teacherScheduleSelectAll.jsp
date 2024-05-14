<%@ page language="java" contentType="text/html;
charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page
	import="com.softskillz.teacherschedule.model.TeacherScheduleBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SoftSkillz - 查詢教師行事曆頁面</title>

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

<!-- Datatable -->
<link rel="stylesheet" href="/assets/extensions/datatables.net-bs5/css/dataTables.bootstrap5.min.css"/>

<link rel="stylesheet" href="/assets/compiled/css/table-datatable-jquery.css"/>

<!-- 固定網頁css -->
<link rel="stylesheet" href="/assets/compiled/css/app.css" />
<link rel="stylesheet" href="/assets/compiled/css/app-dark.css" />
<link rel="stylesheet" href="/assets/compiled/css/iconly.css" />
<!-- sweet alert -->
<link
rel="stylesheet"
href="/assets/extensions/sweetalert2/sweetalert2.min.css"
/>
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
							<a href="/softskillz/newhomepage"><img
								src="/assets/compiled/jpg/logo1.jpg" alt="Logo" srcset="" /></a>
						</div>
						<!-- 切換日間夜間模式 -->
						<div class="theme-toggle d-flex gap-2 align-items-center mt-2">
							<!-- 日間模式圖片 -->
							<svg xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
								role="img" class="iconify iconify--system-uicons" width="20"
								height="20" preserveAspectRatio="xMidYMid meet"
								viewBox="0 0 21 21">
                  <g fill="none" fill-rule="evenodd"
									stroke="currentColor" stroke-linecap="round"
									stroke-linejoin="round">
                    <path
									d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
									opacity=".3"></path>
                    <g transform="translate(-210 -1)">
                      <path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
                      <circle cx="220.5" cy="11.5" r="4"></circle>
                      <path
									d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2"></path>
                    </g>
                  </g>
                </svg>
							<!-- 切換按鈕 -->
							<div class="form-check form-switch fs-6">
								<input class="form-check-input me-0" type="checkbox"
									id="toggle-dark" style="cursor: pointer" /> <label
									class="form-check-label"></label>
							</div>
							<!-- 夜間模式圖片 -->
							<svg xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true"
								role="img" class="iconify iconify--mdi" width="20" height="20"
								preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24">
                  <path fill="currentColor"
									d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z"></path>
                </svg>
						</div>
						<div class="sidebar-toggler x">
							<a href="#" class="sidebar-hide d-xl-none d-block"><i
								class="bi bi-x bi-middle"></i></a>
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
					</ul>
				  </div>
			</div>
		</div>

		<div id="main">
			<header class="mb-3">
				<a href="#" class="burger-btn d-block d-xl-none"> <i
					class="bi bi-justify fs-3"></i>
				</a>
			</header>

			<div class="page-heading">
				<h3>SoftSkillz - 查詢教師行事曆頁面</h3>
			</div>
			<div class="page-content">
				<section class="row">
					<div class="col-12 col-lg-10">
						<!-- 查詢教師行事曆 -->
						<div class="card">
							<h3 class="card-header">查詢教師行事曆資料</h3>
							<div class="card-body">
								<div class="row justify-content-center">
                                    <table class="table" id="scheduleTable">
                                        <thead>
                                            <tr>
                                                <th>行事曆編號</th>
                                                <th>教師編號</th>
                                                <th>教師帳號</th>
                                                <th>課程日期</th>
                                                <th>可預約時段</th>
                                                <th>已被預約時段</th>
                                                <th>刪除</th>
                                                <th>修改</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% 
                                            List<TeacherScheduleBean> teacherSchedules = (List<TeacherScheduleBean>) request.getAttribute("teacherSchedules");
                                            for (TeacherScheduleBean schedule : teacherSchedules) { 
                                            %>
                                            <tr>
                                                <td><%=schedule.getTeacherScheduleID()%></td>
                                                <td><%=schedule.getTeacherID()%></td>
                                                <td><%=schedule.getTeacherBean().getTeacherUserName()%></td>
                                                <td><%=schedule.getCourseDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%></td>
                                                <td><%
                                                    String timeSlots = schedule.getTeacherTimeSlots();
                                                    StringBuilder availableSlots = new StringBuilder();
                                                    StringBuilder reservedSlots = new StringBuilder();
                                                    for (int i = 0; i < timeSlots.length(); i++) {
                                                        char slot = timeSlots.charAt(i);
                                                        String hour = String.format("%02d:00", i);
                                                        if (slot == '1') {
                                                            availableSlots.append(hour).append(", ");
                                                        } else if (slot == '2') {
                                                            reservedSlots.append(hour).append(", ");
                                                        }
                                                    }
                                                    if (availableSlots.length() > 0)
                                                        availableSlots.setLength(availableSlots.length() - 2);
                                                    if (reservedSlots.length() > 0)
                                                        reservedSlots.setLength(reservedSlots.length() - 2);
                                                    out.print(availableSlots.toString());
                                                    %></td>
                                                <td><%=reservedSlots.toString()%></td>
                                                <td>
                                                    <button type="button" class="btn btn-danger deleteSchedule" data-schedule-id="<%= schedule.getTeacherScheduleID() %>">
                                                        刪除
                                                    </button>
                                                </td>
                                                <td>
                                                    <button type="button" class="btn btn-primary editSchedule" data-schedule-id="<%= schedule.getTeacherScheduleID() %>" data-toggle="modal" data-target="#editModal">
                                                        修改
                                                    </button>
                                                </td>
                                            </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
								</div>
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
					</div>

					<!-- 右方第一個卡片列表 -->
					<div class="col-12 col-lg-2">
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
									<button
										class="btn btn-block btn-xl btn-outline-primary font-bold mt-3">
										Start Conversation</button>
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

 <!-- 模態視窗和表單 -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">修改教師行事曆</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editScheduleForm">
                    <div class="form-group">
                        <label for="teacherId">教師編號</label>
                        <input type="text" class="form-control" id="teacherId" readonly>
                    </div>
                    <div class="form-group">
                        <label for="courseDate">課程日期</label>
                        <input type="text" class="form-control" id="courseDate" readonly>
                    </div>
                    <div id="timeSlots" class="btn-group-toggle" data-toggle="buttons">
                        <!-- 時段按鈕將在此動態生成 -->
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
                <button type="submit" form="editScheduleForm" class="btn btn-primary">保存修改</button>
            </div>
        </div>
    </div>
</div>
    

    <!-- sweet alert -->
    <script src="/assets/static/js/pages/sweetalert2.js"></script>
    <script src="/assets/extensions/sweetalert2/sweetalert2.min.js"></script>

    <script src="/assets/static/js/components/dark.js"></script>
    <script src="/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

    <script src="/assets/compiled/js/app.js"></script>

    <!-- Need: Apexcharts -->
    <script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
    <script src="/assets/static/js/pages/dashboard.js"></script>

    <!-- ajax -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- DataTables -->
    <script src="/assets/extensions/jquery/jquery.min.js"></script>
    <script src="/assets/extensions/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/assets/extensions/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
    <script src="/assets/static/js/pages/datatables.js"></script>

	<script>
        $(document).on('click', '.deleteSchedule', function () {
    var scheduleID = $(this).data('schedule-id'); // 從按鈕獲取教師行事曆ID

        Swal.fire({
            title: '確定要刪除這個行事曆嗎？',
            text: '刪除後將無法恢復！',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: '刪除',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/teacherSchedule/deleted',
                    type: 'POST',
                    data: { teacherScheduleID: scheduleID },
                    success: function(response) {
                        Swal.fire('刪除成功!', '', 'success').then(() => {
                            window.location.reload(); // 刷新頁面
                        });
                    },
                    error: function() {
                        Swal.fire('刪除失敗!', '請重試。', 'error');
                    }
                });
            }
        });
    });

    // 修改按鈕的點擊事件，用於開啟模態框並填充數據
$(document).on('click', '.editSchedule', function() {
    var scheduleId = $(this).data('schedule-id');
    $.ajax({
        url: '${pageContext.request.contextPath}/teacherSchedule/update',
        type: 'GET',
        data: { teacherScheduleID: scheduleId },
        success: function(schedule) {
            $('#teacherId').val(schedule.teacherID);
            $('#courseDate').val(schedule.courseDate);
            $('#scheduleId').val(scheduleId);  // 儲存 scheduleId 至隱藏欄位
            // 填充時段選擇按鈕
            $('#timeSlots').empty();
            var timeSlots = schedule.teacherTimeSlots;
            for (var i = 0; i < timeSlots.length; i++) {
                var btnClass = (timeSlots.charAt(i) == '1') ? 'btn-success' : 'btn-secondary';
                var button = $('<button type="button">').addClass('btn ' + btnClass).text(i + ':00')
                    .css({
                        'margin-right': '10px',  // 為每個按鈕添加右邊距
                        'margin-top': '5px',     // 為每個按鈕添加上邊距
                        'margin-bottom': '5px'   // 為每個按鈕添加下邊距
                    });
                if (timeSlots.charAt(i) == '2') {
                    button.addClass('btn-time-disabled'); // 添加額外的類別
                    button.attr('disabled', true); // 設置為禁用狀態
                }
                $('#timeSlots').append(button);
            }
            $('#editModal').modal('show');
        }
    });
});

// 添加隱藏的 input 欄位至表單中以存儲 scheduleId
$('#editScheduleForm').append('<input type="hidden" id="scheduleId" name="teacherScheduleID">');

// 時段按鈕的點擊事件，用於切換按鈕狀態
$('#timeSlots').on('click', 'button', function() {
    if (!$(this).hasClass('btn-time-disabled')) { // 確保按鈕不是禁用的
        $(this).toggleClass('btn-success btn-secondary');
    }
});

// 表單提交的處理
$('#editScheduleForm').on('submit', function(event) {
    event.preventDefault();  // 阻止表單的默認提交行為

    // 收集時段數據
    var timeSlotsData = '';
    $('#timeSlots button').each(function(index) {
        if ($(this).hasClass('btn-time-disabled')) {
            timeSlotsData += '2';  // btn-time-disabled 按鈕顯示為 2
        } else if ($(this).hasClass('btn-success')) {
            timeSlotsData += '1';  // btn-success 按鈕顯示為 1
        } else if ($(this).hasClass('btn-secondary')) {
            timeSlotsData += '0';  // btn-secondary 按鈕顯示為 0
        }
    });

    var teacherScheduleData = {
        teacherScheduleID: $('#scheduleId').val(),  // 包括 teacherScheduleID
        teacherID: $('#teacherId').val(),
        courseDate: $('#courseDate').val(),
        teacherTimeSlots: timeSlotsData  // 將時段數據加入到提交數據中
    };

    $.ajax({
        url: '${pageContext.request.contextPath}/teacherSchedule/updated',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(teacherScheduleData),
        success: function(response) {
            Swal.fire({
                title: '成功',
                text: response,
                icon: 'success',
                confirmButtonText: '確定'
            }).then((result) => {
                $('#editModal').modal('hide'); // 隱藏模態框
                location.reload();  // 刷新頁面
            });
        },
        error: function() {
            Swal.fire({
                title: '錯誤',
                text: '修改教師行事曆失敗',
                icon: 'error',
                confirmButtonText: '確定'
            });
        }
    });
});

$(document).ready(function() {
    // 初始化DataTable
    $('#scheduleTable').DataTable({
        "language": {
            "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh-HANT.json"  // 使用中文介面
        },
        "paging": true,    // 啟用表格分頁
        "lengthChange": true,  // 允許用戶改變分頁設置
        "searching": true,  // 啟用快速搜索
        "ordering": true,  // 啟用排序
        "info": true,      // 顯示頁腳信息
        "autoWidth": false,  // 禁用自動調整列寬
        "responsive": true  // 啟用響應式布局
    });
});
    </script>
</body>
</html>
