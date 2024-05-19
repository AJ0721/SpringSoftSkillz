<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<title>SoftSkillz - 教師註冊</title>
<!-- Customized Bootstrap Stylesheet -->
<link href="/css/bootstrap.min.css" rel="stylesheet" />

<!-- Template Stylesheet -->
<link href="/css/app.css" rel="stylesheet" />
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //January is 0!
		var yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd;
		}
		if (mm < 10) {
			mm = '0' + mm;
		}
		today = yyyy + '-' + mm + '-' + (dd - 1); // 將日期減去一天
		document.getElementById("teacherBirth").setAttribute("max", today);
	});
</script>
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
	padding-top: 80px;
	/* 向下移動按鈕 */
	margin-right: 20px;
	/* 从右侧向左移动一点 */
}

.button-container .btn {
	border-radius: 10px;
	/* 圓形邊角，可根據需求調整大小 */
	padding: 10px 20px;
	/* 調整按鈕內部空間，使按鈕看起來更均衡 */
}

.wide-textarea {
	width: 600px; /* 設定寬度為100% */
}

.dropdown-toggle {
   height: 50px;
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
		<a href="/softskillz/fhomepage"
			class="navbar-brand d-flex align-items-center px-4 px-lg-5">
			<h2 class="m-0 text-primary">
				<i class="fa fa-book me-3"></i>SoftSkillz
			</h2>
		</a>
		<button type="button" class="navbar-toggler me-4"
			data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse">
			<div class="navbar-nav ms-auto p-4 p-lg-0">
				<a href="/softskillz/fhomepage" class="nav-item nav-link active">首頁</a>
				<a href="about.html" class="nav-item nav-link">About</a>
				<div class="nav-item dropdown">
					<a href="/courseFront/selectAllPage"
						class="nav-link dropdown-toggle" data-bs-toggle="dropdown">課程</a>
					<div class="dropdown-menu fade-down m-0">
						<a href="/courseFront/selectAllPage" class="dropdown-item">所有課程</a>
						<a href="/courseFront/selectAllPage?category=語言"
							class="dropdown-item">語言</a> <a
							href="t/courseFront/selectAllPage?category=程式設計"
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
				<a href="#" class="nav-item nav-link">論壇</a> <a href="#"
					class="nav-item nav-link">學伴</a> <a href="#"
					class="nav-item nav-link">商城</a> <a href="contact.html"
					class="nav-item nav-link">Contact</a>
			</div>
			<form action="/student/student-loginPage" method="get"
				class="d-none d-lg-block">
				<button type="submit" class="btn btn-primary py-4 px-lg-5"
					style="background-color: #3f6cba; color: white; border: 1px solid transparent;"
					onmouseover="this.style.backgroundColor='lightblue'; this.style.borderColor='transparent';"
					onmouseout="this.style.backgroundColor='#3f6cba'; this.style.borderColor='transparent';">
					學生登入</button>
			</form>
			<form action="/teacher/teacher-loginPage" method="get"
				class="d-none d-lg-block">
				<button type="submit" class="btn btn-primary py-4 px-lg-5">
					老師登入</button>
			</form>
		</div>
	</nav>
	<!-- Navbar End -->

	<!-- 自行發揮的空間 -->
	<br>
	<div class="container mt-4">
		<div class="card">
			<div class="card-header">
				<h2 class="card-title">老師註冊</h2>
			</div>
			<div class="card-body">
				<form action="/teacher/teacher-create" method="post">
					<div class="row">
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherLastName" class="form-label">姓氏</label> <input
									type="text" id="teacherLastName" class="form-control"
									placeholder="Last Name" name="teacherLastName" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherFirstName" class="form-label">名字</label> <input
									type="text" id="teacherFirstName" class="form-control"
									placeholder="First Name" name="teacherFirstName" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherUserName" class="form-label">帳號</label> <input
									type="text" id="teacherUserName" class="form-control"
									placeholder="Username" name="teacherUserName" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherPassword" class="form-label">密碼</label> <input
									type="password" id="teacherPassword" class="form-control"
									placeholder="Password" name="teacherPassword" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherBirth" class="form-label">出生日期</label> <input
									type="date" id="teacherBirth" class="form-control"
									name="teacherBirth" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherGender" class="form-label">性別</label> <select
									id="teacherGender" class="form-control" name="teacherGender"
									required>
									<option value="male">男性</option>
									<option value="female">女性</option>
									<option value="unspecified">不顯示</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherEmail" class="form-label">電子信箱</label> <input
									type="email" id="teacherEmail" class="form-control"
									placeholder="Email" name="teacherEmail" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="teacherMobile" class="form-label">手機號碼</label> <input
									type="text" id="teacherMobile" class="form-control"
									placeholder="Mobile Number" name="teacherMobile" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="teacherCountry" class="form-label">國家</label> <select
									id="teacherCountry" class="form-control" name="teacherCountry"
									required>
									<option value="阿富汗">阿富汗</option>
									<option value="阿爾巴尼亞">阿爾巴尼亞</option>
									<option value="阿爾及利亞">阿爾及利亞</option>
									<option value="安道爾">安道爾</option>
									<option value="安哥拉">安哥拉</option>
									<option value="安提瓜和巴布達">安提瓜和巴布達</option>
									<option value="阿根廷">阿根廷</option>
									<option value="亞美尼亞">亞美尼亞</option>
									<option value="澳大利亞">澳大利亞</option>
									<option value="奧地利">奧地利</option>
									<option value="阿塞拜疆">阿塞拜疆</option>
									<option value="巴哈馬">巴哈馬</option>
									<option value="巴林">巴林</option>
									<option value="孟加拉國">孟加拉國</option>
									<option value="巴巴多斯">巴巴多斯</option>
									<option value="白俄羅斯">白俄羅斯</option>
									<option value="比利時">比利時</option>
									<option value="貝寧">貝寧</option>
									<option value="不丹">不丹</option>
									<option value="玻利維亞">玻利維亞</option>
									<option value="波斯尼亞和黑塞哥維那">波斯尼亞和黑塞哥維那</option>
									<option value="博茨瓦納">博茨瓦納</option>
									<option value="巴西">巴西</option>
									<option value="保加利亞">保加利亞</option>
									<option value="布基納法索">布基納法索</option>
									<option value="布隆迪">布隆迪</option>
									<option value="柬埔寨">柬埔寨</option>
									<option value="喀麥隆">喀麥隆</option>
									<option value="台灣" selected>台灣</option>
									<option value="加拿大">加拿大</option>
									<option value="佛得角">佛得角</option>
									<option value="中非共和國">中非共和國</option>
									<option value="查德">查德</option>
									<option value="智利">智利</option>
									<option value="中國">中國</option>
									<option value="哥倫比亞">哥倫比亞</option>
									<option value="科摩羅">科摩羅</option>
									<option value="剛果（布）">剛果（布）</option>
									<option value="剛果（金）">剛果（金）</option>
									<option value="哥斯達黎加">哥斯達黎加</option>
									<option value="克羅地亞">克羅地亞</option>
									<option value="古巴">古巴</option>
									<option value="塞浦路斯">塞浦路斯</option>
									<option value="捷克共和國">捷克共和國</option>
									<option value="丹麥">丹麥</option>
									<option value="吉布提">吉布提</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="subject" class="form-label">教學科目</label> <select
									id="subject" class="form-control" name="subject" required>
									<option value="">請選擇科目</option>
									<option value="語言">程式</option>
									<option value="語言">語言</option>
									<option value="數學">數學</option>
									<option value="物理">物理</option>
									<option value="化學">化學</option>
									<option value="生物">生物</option>
									<option value="歷史">歷史</option>
									<option value="地理">地理</option>
									<option value="藝術">藝術</option>
									<option value="音樂">音樂</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="teacherEducation" class="form-label">教育程度</label> <select
									id="teacherEducation" class="form-control"
									name="teacherEducation">
									<option value="幼稚園">幼稚園</option>
									<option value="小學">小學</option>
									<option value="國中">國中</option>
									<option value="高中">高中</option>
									<option value="大學" selected>大學</option>
									<option value="碩士">碩士</option>
									<option value="博士">博士</option>
									<option value="博士后">博士后</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="experience" class="form-label">教學經驗</label> <select
									id="experience" class="form-control" name="experience" required>
									<option value="無經驗" selected>無經驗</option>
									<option value="1-3年">1-3年</option>
									<option value="3-5年">3-5年</option>
									<option value="5-10年">5-10年</option>
									<option value="10年以上">10年以上</option>
								</select>
							</div>
						</div>

						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="status" class="form-label">在職狀態</label> <select
									id="status" class="form-control" name="status" required>
									<option value="full_time">全職</option>
									<option value="part_time">兼職</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="teachTime" class="form-label">一週可授課時數</label> <select
									id="teachTime" class="form-control" name="teachTime" required>
									<option value="">不確定</option>
									<option value="less_10">少於10小時</option>
									<option value="10_20">10到20小時</option>
									<option value="20_30">20到30小時</option>
									<option value="more_30">超過30小時</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="strength" class="form-label">教學優勢</label>
								<textarea id="strength" class="form-control"
									placeholder="Describe your teaching strengths" name="strength"
									required rows="3" maxlength="250"></textarea>
								<div id="strengthRemaining"></div>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="button-container">
								<input type="submit" value="提交" class="btn btn-primary">
								<input type="reset" value="清除" class="btn btn-secondary">
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
				<div class="col-lg-3 col-md-6">
					<h4 class="text-white mb-3">Quick Link</h4>
					<a class="btn btn-link" href="">About Us</a> <a
						class="btn btn-link" href="">Contact Us</a> <a
						class="btn btn-link" href="">Privacy Policy</a> <a
						class="btn btn-link" href="">Terms & Condition</a> <a
						class="btn btn-link" href="">FAQs & Help</a>
				</div>
				<div class="col-lg-3 col-md-6">
					<h4 class="text-white mb-3">聯絡我們</h4>
					<p class="mb-2">
						<i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA
					</p>
					<p class="mb-2">
						<i class="fa fa-phone-alt me-3"></i>+012 345 67890
					</p>
					<p class="mb-2">
						<i class="fa fa-envelope me-3"></i>info@example.com
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
				<div class="col-lg-3 col-md-6">
					<h4 class="text-white mb-3">圖片集錦</h4>
					<div class="row g-2 pt-2">
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-1.jpg"
								alt="" />
						</div>
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-2.jpg"
								alt="" />
						</div>
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-3.jpg"
								alt="" />
						</div>
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-2.jpg"
								alt="" />
						</div>
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-3.jpg"
								alt="" />
						</div>
						<div class="col-4">
							<img class="img-fluid bg-light p-1" src="/img/course-1.jpg"
								alt="" />
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<h4 class="text-white mb-3">意見信箱</h4>
					<p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
					<div class="position-relative mx-auto" style="max-width: 400px">
						<input class="form-control border-0 w-100 py-3 ps-4 pe-5"
							type="text" placeholder="Your email" />
						<button type="button"
							class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
							SignUp</button>
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
					<div class="col-md-6 text-center text-md-end">
						<div class="footer-menu">
							<a href="">Home</a> <a href="">Cookies</a> <a href="">Help</a> <a
								href="">FQAs</a>
						</div>
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
		document
				.getElementById('strength')
				.addEventListener(
						'input',
						function() {
							var remaining = 250 - this.value.length;
							document.getElementById('strengthRemaining').innerText = "剩餘 "
									+ remaining + " 字符";
						});
	</script>
	
</body>

</html>