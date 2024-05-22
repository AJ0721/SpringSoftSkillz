<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8" />
		<title>SoftSkillz - 學生註冊</title>
		<!-- Customized Bootstrap Stylesheet -->
		<link href="/css/bootstrap.min.css" rel="stylesheet" />

		<!-- Template Stylesheet -->
		<link href="/css/app.css" rel="stylesheet" />
		<script>
			document.addEventListener("DOMContentLoaded", function () {
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
				document.getElementById("studentBirth").setAttribute("max", today);
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
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet" />
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

		<!-- Libraries Stylesheet -->
		<link href="/lib/animate/animate.min.css" rel="stylesheet" />
		<link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

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
		</style>
	</head>

	<body>
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary" style="width: 3rem; height: 3rem" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>
		<!-- Spinner End -->

		<!-- Navbar Start -->
		  <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="/softskillz/fhomepage" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
      <h2 class="m-0 text-primary">
        <img src="/account/images/softskillz_logo.png" alt="SoftSkillz" class="me-3"
          style="max-width: 250px; height: auto; margin-top: 16px" />
      </h2>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <div class="navbar-nav ms-auto p-4 p-lg-0">
        <a href="/softskillz/fhomepage" class="nav-item nav-link active" style="font-size: 26px;">首頁</a>
        <div class="nav-item dropdown">
          <a href="/courseFront/selectAllPage" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
            style="font-size: 26px;">課程</a>
          <div class="dropdown-menu fade-down m-0">
            <a href="/courseFront/selectAllPage" class="dropdown-item">所有課程</a>
            <a href="/courseFront/selectAllPage?category=語言" class="dropdown-item">語言</a>
            <a href="/courseFront/selectAllPage?category=程式設計" class="dropdown-item">程式設計</a>
            <a href="/courseFront/selectAllPage?category=藝術" class="dropdown-item">藝術</a>
            <a href="/courseFront/selectAllPage?category=影片剪輯" class="dropdown-item">影片剪輯</a>
            <a href="/courseFront/selectAllPage?category=科學" class="dropdown-item">科學</a>
            <a href="/courseFront/selectAllPage?category=商業" class="dropdown-item">商業</a>
          </div>
        </div>
        <a href="#" class="nav-item nav-link" style="font-size: 26px;">論壇</a>
        <a href="#" class="nav-item nav-link" style="font-size: 26px;">學伴</a>
        <a href="#" class="nav-item nav-link" style="font-size: 26px;">商城</a>
      </div>
      <form action="/student/student-loginPage" method="get" class="d-none d-lg-block">
        <button type="submit" class="btn btn-primary py-4 px-lg-5" style="
              background-color: #3f6cba;
              color: white;
              font-size: 26px;
              border: 1px solid transparent;
            " onmouseover="this.style.backgroundColor='lightblue'; this.style.borderColor='transparent';"
          onmouseout="this.style.backgroundColor='#3f6cba'; this.style.borderColor='transparent';">
          學生登入
        </button>
      </form>
      <form action="/teacher/teacher-loginPage" method="get" class="d-none d-lg-block">
        <button type="submit" class="btn btn-primary py-4 px-lg-5" style="font-size: 26px;">
          老師登入
        </button>
      </form>
    </div>
  </nav>
		<!-- Navbar End -->

		<!-- 自行發揮的空間 -->
		<br>
		<div class="container mt-4">
			<div class="card">
				<div class="card-header">
					<h2 class="card-title">學生註冊</h2>
				</div>
				<div class="card-body">
					<form action="/student/student-create" method="post">
						<div class="row">
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentLastName" class="form-label">姓氏</label> <input type="text"
										id="studentLastName" class="form-control" placeholder="Last Name"
										name="studentLastName" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentFirstName" class="form-label">名字</label> <input type="text"
										id="studentFirstName" class="form-control" placeholder="First Name"
										name="studentFirstName" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentUsername" class="form-label">帳號</label> <input type="text"
										id="studentUsername" class="form-control" placeholder="Username"
										name="studentUsername" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentPassword" class="form-label">密碼</label> <input type="password"
										id="studentPassword" class="form-control" placeholder="Password"
										name="studentPassword" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentBirth" class="form-label">出生日期</label> <input type="date"
										id="studentBirth" class="form-control" name="studentBirth" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentGender" class="form-label">性別</label> <select id="studentGender"
										class="form-control" name="studentGender" required>
										<option value="Male">男性</option>
										<option value="Female">女性</option>
										<option value="Unspecified">不顯示</option>
									</select>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentEmail" class="form-label">電子信箱</label> <input type="email"
										id="studentEmail" class="form-control" placeholder="Email" name="studentEmail"
										required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group mandatory">
									<label for="studentMobile" class="form-label">手機號碼</label> <input type="text"
										id="studentMobile" class="form-control" placeholder="Mobile Number"
										name="studentMobile" required>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group">
									<label for="country" class="form-label">國家</label> <select id="country"
										class="form-control" name="studentCountry">
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
									<label for="firstLanguage" class="form-label">母語</label> <select id="firstLanguage"
										class="form-control" name="firstLanguage">
										<option value="中文" selected>中文</option>
										<option value="達利語">達利語</option>
										<option value="阿爾巴尼亞語">阿爾巴尼亞語</option>
										<option value="阿拉伯語">阿拉伯語</option>
										<option value="加泰隆尼亞語">加泰隆尼亞語</option>
										<option value="葡萄牙語">葡萄牙語</option>
										<option value="英語">英語</option>
										<option value="西班牙語">西班牙語</option>
										<option value="亞美尼亞語">亞美尼亞語</option>
										<option value="德語">德語</option>
										<option value="阿塞拜疆語">阿塞拜疆語</option>
										<option value="孟加拉語">孟加拉語</option>
										<option value="白俄羅斯語">白俄羅斯語</option>
										<option value="荷蘭語">荷蘭語</option>
										<option value="法語">法語</option>
										<option value="宗卡語">宗卡語</option>
										<option value="波士尼亞語">波士尼亞語</option>
										<option value="塞茨瓦納語">塞茨瓦納語</option>
										<option value="保加利亞語">保加利亞語</option>
										<option value="高棉語">高棉語</option>
									</select>
								</div>
							</div>
							<div class="col-md-6 col-12">
								<div class="form-group">
									<label for="studentEducation" class="form-label">教育程度</label> <select
										id="studentEducation" class="form-control" name="studentEducation">
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
									<label for="learningFrequency" class="form-label">學習頻率</label> <select
										id="learningFrequency" class="form-control" name="learningFrequency">
										<option value="一週小於14小時">一週小於14小時</option>
										<option value="一週約14到28小時">一週約14到28小時</option>
										<option value="一週約28到42小時">一週約28到42小時</option>
										<option value="一週大於42小時">一週大於42小時</option>
									</select>
								</div>
							</div>
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
		<div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
      <div class="row g-5">
        <div class="col-lg-8 col-md-6">
          <h4 class="text-white mb-3">聯絡我們</h4>
          <p class="mb-2">
            <i class="fa fa-map-marker-alt me-3"></i>320桃園市中壢區新生路二段421號
          </p>
          <p class="mb-2"><i class="fa fa-phone-alt me-3"></i> 03 453 2632</p>
          <p class="mb-2">
            <i class="fa fa-envelope me-3"></i>academic@shengte.college
          </p>
          <div class="d-flex pt-2">
            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
          </div>
        </div>
        <div class="col-lg-4 col-md-6">
          <h4 class="text-white mb-10">意見信箱</h4>
          <p>請留下您對我們的寶貴意見</p>
          <div class="position-relative mx-auto" style="max-width: 400px">
            <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email" />
            <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
              送出
            </button>
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
		<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

		<!-- JavaScript Libraries -->
		<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
		<script src="/lib/wow/wow.min.js"></script>
		<script src="/lib/easing/easing.min.js"></script>
		<script src="/lib/waypoints/waypoints.min.js"></script>
		<script src="/lib/owlcarousel/owl.carousel.min.js"></script>

		<!-- Template Javascript -->
		<script src="/js/main.js"></script>
	</body>

	</html>