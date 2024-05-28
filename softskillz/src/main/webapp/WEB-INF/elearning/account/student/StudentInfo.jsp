<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<title>SoftSkillz 登入後首頁（學生）</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="keywords" />
<meta content="" name="description" />

<!-- Favicon -->
<link href="/img/favicon.ico" rel="icon" />

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap"
	rel="stylesheet" />

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet" />

<!-- Libraries Stylesheet -->
<link href="/lib/animate/animate.min.css" rel="stylesheet" />
<link href="/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="/css/bootstrap.min.css" rel="stylesheet" />

<!-- Template Stylesheet -->
<link href="/css/style.css" rel="stylesheet" />
<style>
.card {
	border-radius: 20px;
}

.card-header {
	margin-left: 10px;
	margin-top: 30px;
	background-color: white;
}

.form-group .form-control {
	background-color: transparent;
	color: #607080;
}

.button-container {
	position: relative;
	/* 使用相對定位，便於按鈕定位 */
	text-align: right;
	/* 按鈕靠右對齊 */
	padding-top: 20px;
	/* 向下移動按鈕 */
}

.button-container .btn {
	border-radius: 10px;
	/* 圓形邊角，可根據需求調整大小 */
	padding: 10px 20px;
	/* 調整按鈕內部空間，使按鈕看起來更均衡 */
}

.profile-image {
	width: 160px;
	/* 或其他尺寸 */
	height: 160px;
	/* 確保寬度和高度相等 */
	border-radius: 50%;
	/* 這會創造出圓形的效果 */
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	/* 可選，添加陰影 */
}

@media ( max-width : 768px) {
	.profile-image img {
		width: 100px;
		height: 100px;
	}
}
</style>


</head>

<body>
	<!-- Spinner Start -->
	<div id="spinner"
		class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
		<div class="spinner-border text-primary"
			style="width: 3rem; height: 3rem" role="status">
			<span class="sr-only">Loading...</span>
		</div>
	</div>
	<!-- Spinner End -->

	<!-- Navbar Start -->
	<nav
		class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
		<a href="/courseFront/selectAllPage"
			class="navbar-brand d-flex align-items-center px-4 px-lg-5">
			<h2 class="m-0 text-primary">
				<img src="/account/images/softskillz_logo.png" alt="SoftSkillz"
					class="me-3"
					style="max-width: 250px; height: auto; margin-top: 16px" />
			</h2>
		</a>
		<button type="button" class="navbar-toggler me-4"
			data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<div class="navbar-nav ms-auto p-4 p-lg-0">
				<a href="/courseFront/selectAllPage" class="nav-item nav-link active"
					style="font-size: 26px;">首頁</a>
				<div class="nav-item dropdown">
					<a href="/student/student-info"
						th:if="${loggedInUser == 'student'}"
						class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
						style="font-size: 26px;">個人中心</a>
					<div class="dropdown-menu fade-down m-0">
						<a href="/student/student-info"
							th:if="${loggedInUser == 'student'}" class="dropdown-item">個人中心</a>
						<a href="/studentScheduleFront/schedule"
							th:if="${loggedInUser == 'student'}" class="dropdown-item">學生行事曆</a>
						<a href="/studentReservationFront/reservation"
							th:if="${loggedInUser == 'student'}" class="dropdown-item">學生預約</a>
					</div>
				</div>
				<div class="nav-item dropdown" th:if="${loggedInUser == 'student'}">
					<a
					  href="/companionFrontIndex"
					  class="nav-link dropdown-toggle"
					  data-bs-toggle="dropdown"
					  style="font-size: 26px"
					  th:if="${loggedInUser == 'student'}"
					  >學伴</a
					>
					<div
					  class="dropdown-menu fade-down m-0"
					  th:if="${loggedInUser == 'student'}"
					>
					  <a
						href="/companionFrontIndex"
						class="dropdown-item"
						th:if="${loggedInUser == 'student'}"
						>學伴配對</a
					  >
					  <a
						href="/GetMyData"
						class="dropdown-item"
						th:if="${loggedInUser == 'student'}"
						>個人條件設定</a
					  >
					</div>
				  </div>
				<div class="nav-item dropdown">
					<a href="/courseFront/selectAllPage"
						class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
						style="font-size: 26px;">課程</a>
					<div class="dropdown-menu fade-down m-0">
						<a href="/courseFront/selectAllPage" class="dropdown-item">所有課程</a>
						<a href="/courseFront/selectAllPage?category=語言"
							class="dropdown-item">語言</a> <a
							href="/courseFront/selectAllPage?category=程式設計"
							class="dropdown-item">程式設計</a> <a
							href="/courseFront/selectAllPage?category=藝術"
							class="dropdown-item">藝術</a> <a
							href="/courseFront/selectAllPage?category=影片剪輯"
							class="dropdown-item">影片剪輯</a> <a
							href="/courseFront/selectAllPage?category=科學"
							class="dropdown-item">科學</a> <a
							href="/courseFront/selectAllPage?category=商業"
							class="dropdown-item">商業</a>
					</div>
				</div>
				<a href="/courseorder/order.do" class="nav-item nav-link"
					style="font-size: 26px;">訂單</a>
					<a href="/forum/home" class="nav-item nav-link" style="font-size: 26px;">論壇</a>
					<a href="/mall/frontend" class="nav-item nav-link" style="font-size: 26px;">商城</a>

				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle "
						data-bs-toggle="dropdown"><i class="bi bi-chat-square-dots"
						style="font-size: 27px;"></i></a>
					<div class=" dropdown-menu fade-down m-0" id="chatlist"></div>
				</div>
				<div class="navbar-nav ms-auto p-4 p-lg-0 ">
					<a href="/coursecart/cart.do" class="nav-item nav-link "
						style="font-size: 27px;"><i class="bi bi-cart4"></i></a>
				</div>
			</div>
		</div>
		<form action="/student/student-logout" method="post"
			class="d-none d-lg-block">
			<button type="submit" class="btn btn-primary py-4 px-lg-5"
				style="font-size: 26px;">
				<i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
			</button>
		</form>
	</nav>
	<!-- Navbar End -->
	<!-- 自行發揮的空間 -->
	<div class="container mt-4">
		<br>
		<div class="card">
			<div class="card-header">
				<h2 class="card-title">個人中心</h2>
			</div>
			<!-- 照片上傳部分 -->
			<div class="mb-4" style="margin-left: 20px; margin-top: 20px;">

				<img src="/student/images/${student.studentPhoto}" class="img-fluid profile-image"
					alt="學生照片" id="currentPhoto">
				
				<%-- <img
					src="${not empty student.studentPhoto ? student.studentPhoto : '/dist/account/student/images/student01.jpg'}"
					class="img-fluid profile-image" alt="學生照片" id="currentPhoto"> --%>

			</div>

			<div class="card-body">
				<form action="/student/StudentInfo" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="_method" value="put"> <input
						type="hidden" name="studentId" value="${student.studentId}">
					<input type="hidden" name="studentPassword"
						value="${student.studentPassword}">
					<div>

						<%-- <input type="hidden" name="studentPhoto" value="${student.studentPhoto}"> --%>
						<input type="file" style="margin-bottom: 50px;" id="studentPhoto"
							name="studentPhoto" class="form-control-file"
							onchange="selectImgFile(this.files)">
					</div>

					<div class="row">
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentLastName" class="form-label">姓</label> <input
									type="text" id="studentLastName" class="form-control"
									name="studentLastName" value="${student.studentLastName}"
									required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentFirstName" class="form-label">名</label> <input
									type="text" id="studentFirstName" class="form-control"
									name="studentFirstName" value="${student.studentFirstName}"
									required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label class="form-label">帳號</label> <span class="form-control">${student.studentUsername}</span>
								<!-- 添加隱藏欄位來提交 username -->
								<input type="hidden" name="studentUsername"
									value="${student.studentUsername}">
							</div>
						</div>

						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentNickname" class="form-label">暱稱</label> <input
									type="text" id="studentNickname" class="form-control"
									name="studentNickname" value="${student.studentNickname}"
									required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentGender" class="form-label">性別</label> <select
									id="studentGender" class="form-control" name="studentGender"
									required>
									<option value="Male"
										${student.studentGender=='Male' ? 'selected' : '' }>男性
									</option>
									<option value="Female"
										${student.studentGender=='Female' ? 'selected' : ''
												}>女性</option>
									<option value="Unspecified"
										${student.studentGender=='Unspecified'
												? 'selected' : '' }>不顯示</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentBirth" class="form-label">出生日期</label> <span
									id="studentBirth" class="form-control">${student.studentBirth}</span>
								<input type="hidden" name="studentBirth"
									value="${student.studentBirth}">
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentEmail" class="form-label">電子信箱</label> <input
									type="text" id="studentEmail" class="form-control"
									name="studentEmail" value="${student.studentEmail}" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentMobile" class="form-label">手機號碼</label> <input
									type="text" id="studentMobile" class="form-control"
									name="studentMobile" value="${student.studentMobile}" required>
							</div>
						</div>
						<div class="col-12">
							<div class="button-container text-center">
								<input type="submit" value="提交" class="btn btn-primary">
								<input type="reset" value="清除" class="btn btn-secondary">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Footer Start -->
	<div
		class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container py-5">
			<div class="row g-5">
				<div class="col-lg-8 col-md-6">
					<h4 class="text-white mb-3">聯絡我們</h4>
					<p class="mb-2">
						<i class="fa fa-map-marker-alt me-3"></i>320桃園市中壢區新生路二段421號
					</p>
					<p class="mb-2">
						<i class="fa fa-phone-alt me-3"></i> 03 453 2632
					</p>
					<p class="mb-2">
						<i class="fa fa-envelope me-3"></i>academic@shengte.college
					</p>
					<div class="d-flex pt-2">
						<a class="btn btn-outline-light btn-social" href=""><i
							class="fab fa-twitter"></i></a> <a
							class="btn btn-outline-light btn-social" href=""><i
							class="fab fa-facebook-f"></i></a> <a
							class="btn btn-outline-light btn-social" href=""><i
							class="fab fa-youtube"></i></a> <a
							class="btn btn-outline-light btn-social" href=""><i
							class="fab fa-linkedin-in"></i></a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<h4 class="text-white mb-10">意見信箱</h4>
					<p>請留下您對我們的寶貴意見</p>
					<div class="position-relative mx-auto" style="max-width: 400px">
						<input class="form-control border-0 w-100 py-3 ps-4 pe-5"
							type="text" placeholder="Your email" />
						<button type="button"
							class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
							送出</button>
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="copyright">
				<div class="row">
					<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
						&copy; <a class="border-bottom" href="#">Soft Skillz</a>, All
						Right Reserved.

						<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer End -->

	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
		class="bi bi-arrow-up"></i></a>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/lib/wow/wow.min.js"></script>
	<script src="/lib/easing/easing.min.js"></script>
	<script src="/lib/waypoints/waypoints.min.js"></script>
	<script src="/lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Template Javascript -->
	<script src="/js/main.js"></script>


	<script>
		document.addEventListener('DOMContentLoaded', function() {
			var birthSpan = document.getElementById('studentBirth');
			// 假設日期是以 ISO 字符串格式儲存，如 "1990-01-01T12:00:00"
			if (birthSpan) {
				var birthDate = new Date(birthSpan.textContent);
				// 格式化日期為 YYYY-MM-DD
				var formattedDate = birthDate.getFullYear()
						+ '-'
						+ (birthDate.getMonth() + 1).toString()
								.padStart(2, '0') + '-'
						+ birthDate.getDate().toString().padStart(2, '0');
				// 更新元素內容僅顯示日期
				birthSpan.textContent = formattedDate;
			}
		});
	</script>

	<script>
		//studentBirth轉格式
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							var birthSpan = document
									.getElementById('studentBirth');
							if (birthSpan) {
								var birthDate = new Date(birthSpan.textContent);
								var formattedDate = birthDate.getFullYear()
										+ '-'
										+ (birthDate.getMonth() + 1).toString()
												.padStart(2, '0')
										+ '-'
										+ birthDate.getDate().toString()
												.padStart(2, '0');
								birthSpan.textContent = formattedDate;
								// 更新隱藏欄位的值
								document.getElementsByName('studentBirth')[0].value = formattedDate;
							}
						});

		function selectImgFile(files) {
			if (!files.length) {
				return false;
			}

			let file = files[0];
			let reader = new FileReader();
			reader.onload = function() {
				document.querySelector('#currentPhoto').src = this.result;
			};

			reader.readAsDataURL(file);
		}
	</script>


</body>

</html>