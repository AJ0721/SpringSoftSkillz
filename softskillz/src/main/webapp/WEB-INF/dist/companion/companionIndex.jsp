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
			<script src="/assets/extensions/jquery/jquery.min.js"></script>
			<style>
				#popup {
					visibility: hidden;
				}

				#popupEng {
					visibility: hidden;
				}

				select {
					border-radius: 8px;
					padding: 1px;
					width: 92px;
					background-color: #FFF3EE;
					border: solid 1px #bbb;
					box-shadow: 1px 1px #888888;
				}
.input-container {
    position: relative;
    display: inline-block;
}

.input-container i {
    position: absolute;
    left: 178px; /* 調整圖標與輸入框左邊距離 */
    top: 30%;
    transform: translateY(-50%);
    font-size: 20px; /* 調整圖標大小 */
    color: #999;
}

.input-container2 {
    position: relative;
    display: inline-block;
}

.input-container2 i {
    position: absolute;
    left: 200px; /* 調整圖標與輸入框左邊距離 */
    top: 30%;
    transform: translateY(-50%);
    font-size: 20px; /* 調整圖標大小 */
    color: #999;
}

#number {
    width: 200px;
    height: 40px;
    padding-left: 30px; /* 留出空間給圖標 */
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

#english{
    width: 200px;
    height: 40px;
    padding-left: 30px; /* 留出空間給圖標 */
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
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
									<a href="dist/index.html"><img src="/assets/compiled/jpg/logo1.jpg" alt="Logo"
											srcset="" /></a>
								</div>
								<!-- 切換日間夜間模式 -->
								<div class="theme-toggle d-flex gap-2 align-items-center mt-2">
									<!-- 日間模式圖片 -->
									<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
										aria-hidden="true" role="img" class="iconify iconify--system-uicons" width="20"
										height="20" preserveAspectRatio="xMidYMid meet" viewBox="0 0 21 21">
										<g fill="none" fill-rule="evenodd" stroke="currentColor" stroke-linecap="round"
											stroke-linejoin="round">
											<path
												d="M10.5 14.5c2.219 0 4-1.763 4-3.982a4.003 4.003 0 0 0-4-4.018c-2.219 0-4 1.781-4 4c0 2.219 1.781 4 4 4zM4.136 4.136L5.55 5.55m9.9 9.9l1.414 1.414M1.5 10.5h2m14 0h2M4.135 16.863L5.55 15.45m9.899-9.9l1.414-1.415M10.5 19.5v-2m0-14v-2"
												opacity=".3"></path>
											<g transform="translate(-210 -1)">
												<path d="M220.5 2.5v2m6.5.5l-1.5 1.5"></path>
												<circle cx="220.5" cy="11.5" r="4"></circle>
												<path
													d="m214 5l1.5 1.5m5 14v-2m6.5-.5l-1.5-1.5M214 18l1.5-1.5m-4-5h2m14 0h2">
												</path>
											</g>
										</g>
									</svg>
									<!-- 切換按鈕 -->
									<div class="form-check form-switch fs-6">
										<input class="form-check-input me-0" type="checkbox" id="toggle-dark"
											style="cursor: pointer" />
										<label class="form-check-label"></label>
									</div>
									<!-- 夜間模式圖片 -->
									<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
										aria-hidden="true" role="img" class="iconify iconify--mdi" width="20"
										height="20" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24">
										<path fill="currentColor"
											d="m17.75 4.09l-2.53 1.94l.91 3.06l-2.63-1.81l-2.63 1.81l.91-3.06l-2.53-1.94L12.44 4l1.06-3l1.06 3l3.19.09m3.5 6.91l-1.64 1.25l.59 1.98l-1.7-1.17l-1.7 1.17l.59-1.98L15.75 11l2.06-.05L18.5 9l.69 1.95l2.06.05m-2.28 4.95c.83-.08 1.72 1.1 1.19 1.85c-.32.45-.66.87-1.08 1.27C15.17 23 8.84 23 4.94 19.07c-3.91-3.9-3.91-10.24 0-14.14c.4-.4.82-.76 1.27-1.08c.75-.53 1.93.36 1.85 1.19c-.27 2.86.69 5.83 2.89 8.02a9.96 9.96 0 0 0 8.02 2.89m-1.64 2.02a12.08 12.08 0 0 1-7.8-3.47c-2.17-2.19-3.33-5-3.49-7.82c-2.81 3.14-2.7 7.96.31 10.98c3.02 3.01 7.84 3.12 10.98.31Z">
										</path>
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
											<a href="/companionIndex" class="submenu-link">學伴資料管理</a>
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
						<h3>SoftSkillz - 學伴資料管理</h3>
					</div>
					<div class="page-content">
						<section class="row">
							<div class="col-12">
								<!-- 卡片中放你的功能內容 -->
								<div class="card">
									<!-- <h3 class="card-header">新增課程資料</h3> -->
									<div class="card-body">
										<div>
											<div>
												<h2 class="text-center">學伴資料管理</h2>
											</div>
										</div><br>

								<table align="center">
								<tr align="center">
									<td>
										<form method="get" action="../GetCompanionById">
													<div class="input-container">
													<label for="" class="fs-5">以id查詢基本資料 :</label>
                                                        <i class="bi bi-person"></i>
													<input type="text" name="companion_id" id="number"
														style="border:solid 1px;border-radius: 5px;"
														placeholder="請輸入數字" size="13"/>
													<!-- 					<input type="submit" value="查詢" /> -->
													<button type="submit" class="btn btn-primary" id="selectById">查詢</button>
                                                    </div>

												</form>
									</td>
									<td>&nbsp &nbsp</td>
									<td>
										<form method="get" action="../GetCompanionByName">
										<div class="input-container2">
													<label for="" class="fs-5">以暱稱查詢基本資料 :</label>
													<i class="bi bi-person"></i>
													<input type="text" name="companion_username"
														style="border:solid 1px;border-radius: 5px;"
														placeholder="請輸入英文名稱" id="english" size="13"/>
													
													<button type="submit" class="btn btn-primary" id="selectByName">查詢</button>
													 </div>
													
												</form>
									</td>
									<td>
									<a href="companionqueryallpage.controller"><button
														class="btn btn-primary">查詢全部</button></a>
									
									</td>
									</tr>
									<tr align="center">
									<td colspan="2"><div class="popup; text-warning fs-5" id="popup">請輸入數字！</div></td>
									<td colspan="2"><div class="popup; text-warning fs-5" id="popupEng">請輸入英文字！</div></td>
									</tr>
									<tr align="center">
									<td colspan="2" class="fs-5">${errorMessage}</td>
									<td colspan="2" class="fs-5">${errorMessageErrName}</td>
									</tr>
								</table>


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
			</div>

			<script src="/assets/static/js/components/dark.js"></script>
			<script src="/assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>

			<script src="/assets/compiled/js/app.js"></script>

			<!-- Need: Apexcharts -->
			<script src="/assets/extensions/apexcharts/apexcharts.min.js"></script>
			<script src="/assets/static/js/pages/dashboard.js"></script>
			<script>
				document.addEventListener('DOMContentLoaded', function () {
					const numbers = document.querySelectorAll('#number');
					const popups = document.querySelectorAll('#popup');
					const selectById = document.querySelector('#selectById');
					const selectByName = document.querySelector('#selectByName');

					numbers.forEach(function (number, index) {
						number.addEventListener('input', function (event) {
							const inputValue = event.target.value;
							const containsNonNumber = !/^\d*$/.test(inputValue);
							const containsNumber = /\d/.test(inputValue);
							if (containsNonNumber || (containsNumber && containsNonNumber && inputValue !== "")) {
								popups[index].style.visibility = 'visible';
								selectById.disabled = true;
							} else {
								popups[index].style.visibility = 'hidden';
								 selectById.disabled = false;
							}
						});
					});
				});

				document.addEventListener('DOMContentLoaded', function () {
					const numbers = document.querySelectorAll('#english');
					const popups = document.querySelectorAll('#popupEng');

					numbers.forEach(function (number, index) {
						number.addEventListener('input', function (event) {
							const inputValue = event.target.value;
							const containsNonEnglish = !/^[a-zA-Z]*$/.test(inputValue);
							const containsEnglish = /[a-zA-Z]/.test(inputValue);
							if (containsNonEnglish || (containsEnglish && containsNonEnglish && inputValue !== "")) {
								popups[index].style.visibility = 'visible';
								selectByName.disabled = true;
							} else {
								popups[index].style.visibility = 'hidden';
								selectByName.disabled = false;
							}
						});
					});
				});
			</script>

			<script>
				var indexPage = 1;

				$(function () {
					loadPage(indexPage);
				});

				function change(page) {
					indexPage = page;
					loadPage(indexPage);
				}

				function changePage(step) {
					indexPage += step;
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

							const totalPages = <%= session.getAttribute("totalPages") %>;
						const totalElements = <%= session.getAttribute("totalElements") %>;
						console.log("totalPages : " + totalPages);
						console.log("totalElements : " + totalElements);

					}
				            });
				  
				          }
			</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			// 遍歷所有的表單元素
			const forms = document.querySelectorAll('form');
			forms.forEach(form => {
				form.addEventListener('submit', function (event) {
					event.preventDefault(); // 防止表單預設的提交行為
	
					// 檢查每個輸入欄位是否為空
					const inputs = form.querySelectorAll('input[type="text"]');
					let isEmpty = false;
					inputs.forEach(input => {
						if (input.value.trim() === '') {
							isEmpty = true;
						}
					});
	
					// 如果有空值，顯示提示訊息
					if (isEmpty) {
						Swal.fire({
							title: "輸入欄位不可為空白",
							showCloseButton: true,
						});
					} else {
						// 否則提交表單
						form.submit();
					}
				});
			});
		});
	</script>
		</body>

		</html>