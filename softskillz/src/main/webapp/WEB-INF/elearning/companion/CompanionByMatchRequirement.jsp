<%@page import="java.util.List" %>
  <%@page import="java.util.ArrayList" %>
    <%@page import="com.softskillz.companion.model.CompanionBean" %>
      <%@page import="java.text.SimpleDateFormat" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
              <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
                rel="stylesheet" />
              <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                rel="stylesheet" />

              <!-- Libraries Stylesheet -->
              <link href="/lib/animate/animate.min.css" rel="stylesheet" />
              <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

              <!-- Customized Bootstrap Stylesheet -->
              <link href="/css/bootstrap.min.css" rel="stylesheet" />

              <!-- Template Stylesheet -->
              <link href="/css/style.css" rel="stylesheet" />

              <style>
                #img {
                  width: 150px;
                  height: auto;
                }

                tr {
                  text-align: center;
                }

                td {

                  text-align: center;

                }

                button {
                  padding: 8px 20px;
                  /* 按鈕內邊距 */
                  margin: 0px;
                  /* 按鈕間距 */
                  border: none;
                  /* 去除按鈕邊框 */
                  border-radius: 4px;
                  /* 設置按鈕圓角 */
                  background-color: #007bff;
                  /* 按鈕背景顏色 */
                  color: #fff;
                  /* 按鈕文字顏色 */
                  cursor: pointer;
                  /* 滑鼠懸停樣式 */
                }

                button:hover {
                  background-color: #0056b3;
                  /* 滑鼠懸停時的背景顏色 */
                }

                .index {
                  background-color: #dc3545;
                  /* 回首頁按鈕的背景顏色 */
                  display: flex;
                  align-items: center;
                  justify-content: flex-end;
                  margin: 10px;
                }

                .index:hover {
                  background-color: #c82333;
                  /* 滑鼠懸停時的背景顏色 */
                }

                table {
                  width: 100%;
                  border-collapse: collapse;
                  box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);
                }

                /* 表格標題樣式 */
                th {
                  background-color: #FFDEDE;
                  /* 背景顏色 */
                  color: #333;
                  /* 文字顏色 */
                  font-weight: bold;
                  /* 加粗 */
                  padding: 8px;
                  /* 內邊距 */
                  border: 1px solid #ddd;
                  /* 邊框 */
                }

                /* 表格內容樣式 */
                td {
                  padding: 8px;
                  /* 內邊距 */
                  border: 1px solid #ddd;
                  /* 邊框 */
                }

                /* 奇數行背景色 */
                tr:nth-child(odd) {
                  background-color: #FFF2F2;
                }

                /* 鼠標懸停時的背景色 */
                tr:hover {
                  background-color: #D2E9FF;
                }

                html {
                  background: #fdf5e6;
                  font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
                }

                /* body { */
                /*   margin: 30px auto 0 auto; */
                /*   width: 450px; */
                /*   font-size: 75%; */
                /* } */

                h3 {
                  margin-top: 30px;
                  font-size: 18px;
                  color: #555;
                }

                p {
                  padding-left: 10px;
                }


                /*
 * Basic button style
 */
                #likeOrDislike {
                  box-shadow: 1px 1px 0 rgba(255, 255, 255, 0.5) inset;
                  border-radius: 3px;
                  border: 1px solid;
                  display: inline-block;
                  height: 32px;
                  line-height: 32px;
                  padding: 0 8px;
                  position: relative;

                  font-size: 16px;
                  text-decoration: none;
                  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
                }

                /*
 * Counter button style
 */
                #likeOrDisliken-counter {
                  margin-right: 39px;
                }

                #likeOrDislike-counter:after,
                #likeOrDislike-counter:hover:after {
                  text-shadow: none;
                }

                #likeOrDislike-counter:after {
                  border-radius: 3px;
                  border: 1px solid #d3d3d3;
                  background-color: #eee;
                  padding: 0 8px;
                  color: #777;
                  content: attr(data-count);
                  left: 100%;
                  margin-left: 8px;
                  margin-right: -13px;
                  position: absolute;
                  top: -1px;
                }

                #likeOrDislike-counter:before {
                  transform: rotate(45deg);
                  filter: progid:DXImageTransform.Microsoft.Matrix(M11=0.7071067811865476, M12=-0.7071067811865475, M21=0.7071067811865475, M22=0.7071067811865476, sizingMethod='auto expand');

                  background-color: #eee;
                  border: 1px solid #d3d3d3;
                  border-right: 0;
                  border-top: 0;
                  content: '';
                  position: absolute;
                  right: -13px;
                  top: 5px;
                  height: 6px;
                  width: 6px;
                  z-index: 1;
                  zoom: 1;
                }

                /*
 * Custom styles
 */
                #likeOrDislike {
                  background-color: #fee6e6;
                  border-color: #bbb;
                  color: #666;
                }

                #likeOrDislike:hover,
                #likeOrDislike.active {
                  text-shadow: 0 1px 0 #b12f27;
                  background-color: #f64136;
                  border-color: #b12f27;
                }

                #likeOrDislike:active {
                  box-shadow: 0 0 5px 3px rgba(0, 0, 0, 0.2) inset;
                }

                #likeOrDislike span {
                  color: #f64136;
                }

                #likeOrDislike:hover,
                .btn:hover span,
                #likeOrDislike.active,
                .btn.active span {
                  color: #eeeeee;
                }

                #likeOrDislike:active span {
                  color: #b12f27;
                  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.3);
                }

                .nav-link {
                  font-weight: normal;
                  /* 預設為正常字體粗細 */
                }

                .nav-link.active {
                  font-weight: bold;
                  /* 選中時為粗體 */
                }

                #popup {
                  display: none;
                }

                #popupEng {
                  display: none;
                }

                .card-container {
                  display: flex;
                  flex-wrap: wrap;
                  justify-content: center;
                  gap: 20px;
                }

                .card {
                  width: 300px;
                  height: 400px;
                  perspective: 1000px;
                  border: 0px;
                }
.card:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}
                .card-front,
                .card-back {
                  width: 100%;
                  height: 100%;
                  position: absolute;
                  backface-visibility: hidden;
                  transition: transform 0.6s;
                  border-radius: 10px;
                  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .card-front {
                  background: #fff;
                  text-align: center;
                  padding: 20px;
                }

                .card-back {
                  background: #fff;
                  transform: rotateY(180deg);
                  text-align: center;
                  padding: 20px;
                }

                .card-img {
                  width: 100%;
                  height: auto;
                  border-radius: 10px;
                }

                .card-title {
                  margin: 10px 0;
                  font-size: 24px;
                }

                .card-subtitle {
                  margin: 5px 0;
                  font-size: 18px;
                  color: #666;
                }

                .card-text {
                  margin: 10px 0;
                  font-size: 16px;
                  color: #333;
                }

                .card:hover .card-front {
                  transform: rotateY(180deg);
                }

                .card:hover .card-back {
                  transform: rotateY(360deg);
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
<nav
      class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0"
    >
      <a
        href="/courseFront/selectAllPage"
        class="navbar-brand d-flex align-items-center px-4 px-lg-5"
      >
        <h2 class="m-0 text-primary">
          <img
            src="/account/images/softskillz_logo.png"
            alt="SoftSkillz"
            class="me-3"
            style="max-width: 250px; height: auto; margin-top: 16px"
          />
        </h2>
      </a>
      <button
        type="button"
        class="navbar-toggler me-4"
        data-bs-toggle="collapse"
        data-bs-target="#navbarCollapse"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
          <a
            href="/courseFront/selectAllPage"
            class="nav-item nav-link active"
            style="font-size: 26px"
            >首頁</a
          >
          <div class="nav-item dropdown">
            <a
              href="/student/personal-center"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              style="font-size: 26px"
              >個人中心</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="/student/student-info" class="dropdown-item">個人中心</a>
              <a href="/studentScheduleFront/schedule" class="dropdown-item"
                >學生行事曆</a
              >
              <a
                href="/studentReservationFront/reservation"
                class="dropdown-item"
                >學生預約</a
              >
              <a href="/courseorder/order.do" class="dropdown-item">課程訂單</a>
            </div>
          </div>
          <!--             首頁學伴選單 -->
          <div class="nav-item dropdown">
            <a
              href="/companionFrontIndex"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              style="font-size: 26px"
              >學伴</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="/companionFrontIndex" class="dropdown-item">學伴配對</a>
              <a href="/GetMyData" class="dropdown-item">個人條件設定</a>
            </div>
          </div>
          <!--             首頁學伴選單 -->
          <div class="nav-item dropdown">
            <a
              href="/courseFront/selectAllPage"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              style="font-size: 26px"
              >課程</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="/courseFront/selectAllPage" class="dropdown-item"
                >所有課程</a
              >
              <a
                href="/courseFront/selectAllPage?category=語言"
                class="dropdown-item"
                >語言</a
              >
              <a
                href="/courseFront/selectAllPage?category=程式設計"
                class="dropdown-item"
                >程式設計</a
              >
              <a
                href="/courseFront/selectAllPage?category=藝術"
                class="dropdown-item"
                >藝術</a
              >
              <a
                href="/courseFront/selectAllPage?category=影片剪輯"
                class="dropdown-item"
                >影片剪輯</a
              >
              <a
                href="/courseFront/selectAllPage?category=科學"
                class="dropdown-item"
                >科學</a
              >
              <a
                href="/courseFront/selectAllPage?category=商業"
                class="dropdown-item"
                >商業</a
              >
            </div>
          </div>
          <a
            href="/forum/home"
            class="nav-item nav-link"
            style="font-size: 26px"
            >論壇</a
          >
          <div class="nav-item dropdown">
            <a
              href="/mall/frontend"
              class="nav-item nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              style="font-size: 26px"
              >商城</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="/mall/frontend" class="dropdown-item">商城</a>
              <a href="/order/searchorder" class="dropdown-item">查詢訂單</a>
            </div>
          </div>
          <div class="nav-item dropdown">
            <a
              href="#"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              ><i class="bi bi-chat-square-dots" style="font-size: 27px"></i
            ></a>
            <div class="dropdown-menu fade-down m-0" id="chatlist"></div>
          </div>
          <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a
              href="/coursecart/cart.do"
              class="nav-item nav-link"
              style="font-size: 27px"
              ><i class="bi bi-cart4"></i
            ></a>
          </div>
        </div>
        <div class="navbar-nav p-4 p-lg-0">
          <form
            action="/student/student-logout"
            method="post"
            class="d-none d-lg-block"
          >
            <button
              type="submit"
              class="btn btn-primary py-4 px-lg-5"
              style="font-size: 26px"
            >
              <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
            </button>
          </form>
        </div>
      </div>
    </nav>
      <!-- Navbar End -->

              <!-- 自行發揮的空間 -->

              <div id="main">

                <div class="page-heading">
                </div>
                <div class="page-content">
                  <section class="row">
                    <div class="col-12">
                      <!-- 卡片中放你的功能內容 -->
                      <!-- <h3 class="card-header">新增課程資料</h3> -->
                      <div>
                        <div>
                          <h2 class="text-center mt-5">學伴配對</h2>
                        </div>
                      </div><br>

                      <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="#" id="tab1"
                            style="font-size: large;">與新的學伴配對</a></li>
                        <li class="nav-item"><a class="nav-link" href="#" id="tab2" style="font-size: large;">查詢我的學伴</a>
                        </li>
                      </ul>


                      <div class="m-4" align="center" id="content1">
                        <div>
                          <h5>符合學習興趣的學伴資料</h5>
                        </div>
                        <div class="card-container">
                          <% List<CompanionBean> companions = (ArrayList<CompanionBean>
                              )request.getAttribute("companions");
                              SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
                              SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
                              for(CompanionBean companion: companions){
                              %>
                              <div class="card">

                                <div class="card-front">
                                  <img src="<%= companion.getCompanionPhoto() %>" alt="學伴照片" class="card-img">
                                  <h2 class="card-title">學伴暱稱：<%= companion.getStudentBeanID().getStudentNickname()%>
                                  </h2>
                                  <p class="card-subtitle">學習興趣：<%= companion.getCompanionLearningInterest()%>
                                  </p>
                                </div>
                                <div class="card-back">
                                  <h2 class="card-title">暱稱：<%= companion.getStudentBeanID().getStudentNickname()%>
                                  </h2>
                                  <p class="card-text">性別：<%= companion.getStudentBeanID().getStudentGender()%>
                                  </p>
                                  <p class="card-text">母語：<%= companion.getCompanionFirstLanguage()%>
                                  </p>
                                  <p class="card-text">會說語言：<%= companion.getCompanionSpeakingLanguage()%>
                                  </p>
                                  <p class="card-text">學習頻率：<%= companion.getCompanionLearningFrequency()%>
                                  </p>
                                  <p class="card-text">關於我：<%= companion.getCompanionAboutMe()%>
                                  </p>
                                  <p class="card-text">
                                  <form id="likeForm" method="post"
                                    action="${pageContext.request.contextPath}/InsertCompanion">
                                    <input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
                                    <%-- <input type="hidden" value="<%= companion.getCompanionLearningInterest() %>"
                                      name="companion_learning_interest"> --%>
                                      <button title="like" id="likeOrDislike" data-count="0" type="submit"
                                        name="like_or_dislike" value="like"><span>&#x2764;</span> 申請配對</button>
                                      <!-- <button name="like_or_dislike" value="like">❤</button> -->
                                  </form>
                                  </p>
                                  <p class="card-text">
                                  <form id="dislikeForm" method="post"
                                    action="${pageContext.request.contextPath}/InsertCompanion">
                                    <input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
                                    <%-- <input type="hidden" value="<%= companion.getCompanionLearningInterest() %>"
                                      name="companion_learning_interest"> --%>
                                      <!-- <button name="like_or_dislike" value="dislike">✖</button> -->
                                      <button title="dislike" id="likeOrDislike" data-count="0" type="submit"
                                        name="like_or_dislike" value="dislike"><span>&#128473;</span>
                                        隱藏學伴</button>
                                  </form>
                                  </p>
                                </div>
                              </div>

                              <!-- 可以複製上面的卡片結構來添加更多卡片 -->
                              <%} %>
                        </div>
                        <div><button class="index btn btn-primary mt-3"
                            style="background-color:#ACD4D6;border:0px;border-radius:8px">回首頁</button></div>
                        <!-- </form> -->
                      </div>


                      <!-- 查已配對學伴的tab -->

                      <div id="content2" style="display: none;" align="center" class="m-3">
                        <div style="border-radius: 10px;display:inline-block">
                          <form method="get" action="../GetCompanionMatchById">
                            <label for="" class="fs-5 mb-2 fw-bold">查詢目前已配對的學伴</label><br>
<!--                             <label for="" class="fs-6">請輸入你的暱稱</label><br><input class="form-control" type="text" -->
<!--                               name="nickname" id="english" -->
<!--                               style="border-radius: 10px;display:inline-block;text-align: center;width: 200px;" -->
<!--                               placeholder="請輸入英文使用者名稱" /> -->
<!--                             <div class="popup; text-warning" id="popupEng">請輸入英文字！</div> -->
                            <div align="center"><button class="btn btn-primary mt-3"
                                style="background-color:#ACD4D6;border:0px;border-radius:8px">查詢已配對學伴</button></div>
                          </form>
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
              <script>
                // 監聽 tab 的點擊事件
                document.getElementById('tab1').addEventListener('click', function () {
                  // 切換內容顯示
                  document.getElementById('content1').style.display = 'block';
                  document.getElementById('content2').style.display = 'none';
                  // 切換 tab 的激活狀態
                  this.classList.add('active');
                  document.getElementById('tab2').classList.remove('active');
                });

                document.getElementById('tab2').addEventListener('click', function () {
                  // 切換內容顯示
                  document.getElementById('content1').style.display = 'none';
                  document.getElementById('content2').style.display = 'block';
                  // 切換 tab 的激活狀態
                  this.classList.add('active');
                  document.getElementById('tab1').classList.remove('active');
                });
              </script>
              <script>
                const index = document.querySelector('.index')
                index.addEventListener('click', function () {
                  location.href = "/companionFrontIndex"
                })
              </script>
              <script src="/elearning/companion/companionJS/likeOrDislike.js"></script>
            </body>

            </html>