<%@page import="java.util.List" %>
  <%@page import="java.util.ArrayList" %>
    <%@page import="com.softskillz.companion.model.CompanionBean" %>
      <%@page import="com.softskillz.companion.model.CompanionMatchBean" %>
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

                  #myCompanion {
                    width: 100%;
                    border-collapse: collapse;
                    box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);
                  }

                  /* 表格標題樣式 */
                  #myCompanion th {
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
                  #myCompanion td {
                    padding: 8px;
                    /* 內邊距 */
                    border: 1px solid #ddd;
                    /* 邊框 */
                  }

                  /* 奇數行背景色 */
                  #myCompanion tr:nth-child(odd) {
                    background-color: #FFF2F2;
                  }

                  /* 鼠標懸停時的背景色 */
                  #myCompanion tr:hover {
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

                  select {
                    border-radius: 8px;
                    padding: 1px;
                    width: 110px;
                    background-color: #F7EDEB;
                    border: solid 2px #bbb;
                    /* 					box-shadow: 1px 1px 0px #888888; */
                    text-align: center
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
                <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
                  <a href="/softskillz/fhomepage" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                    <h2 class="m-0 text-primary">
                      <i class="fa fa-book me-3"></i>SoftSkillz
                    </h2>
                  </a>
                  <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto p-4 p-lg-0">
                      <a href="/softskillz/fhomepage" class="nav-item nav-link active">首頁</a>
                      <a href="about.html" class="nav-item nav-link">About</a>
                      <a href="#" class="nav-item nav-link">個人中心</a>
                      <div class="nav-item dropdown">
                        <a href="/courseFront/selectAllPage" class="nav-link dropdown-toggle"
                          data-bs-toggle="dropdown">課程</a>
                        <div class="dropdown-menu fade-down m-0">
                          <a href="/courseFront/selectAllPage" class="dropdown-item">所有課程</a>
                          <a href="team.html" class="dropdown-item">語言</a>
                          <a href="testimonial.html" class="dropdown-item">程式設計</a>
                          <a href="404.html" class="dropdown-item">藝術</a>
                          <a href="404.html" class="dropdown-item">影片剪輯</a>
                          <a href="404.html" class="dropdown-item">心理學</a>
                          <a href="404.html" class="dropdown-item">科學</a>
                          <a href="404.html" class="dropdown-item">商業</a>
                        </div>
                      </div>
                      <a href="#" class="nav-item nav-link">論壇</a>
                      <!--             首頁學伴選單 -->
                      <div class="nav-item dropdown">
                        <a href="/companionFrontIndex" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">學伴</a>
                        <div class="dropdown-menu fade-down m-0">
                          <a href="/GetMyData" class="dropdown-item">個人條件設定</a>
                          <a href="/companionFrontChatroom" class="dropdown-item">學伴聊天室</a>
                        </div>
                      </div>
                      <!--             首頁學伴選單 --> <a href="#" class="nav-item nav-link">商城</a>
                      <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu fade-down m-0">
                          <a href="team.html" class="dropdown-item">Our Team</a>
                          <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                          <a href="404.html" class="dropdown-item">404 Page</a>
                        </div>
                      </div>
                      <a href="contact.html" class="nav-item nav-link">Contact</a>
                    </div>
                    <form action="/student/student-logout" method="post" class="d-none d-lg-block">
                      <button type="submit" class="btn btn-primary py-4 px-lg-5">
                        <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
                      </button>
                    </form>
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
                          <li class="nav-item"><a class="nav-link" aria-current="page" href="#" id="tab1"
                              style="font-size: large;">與新的學伴配對</a></li>
                          <li class="nav-item"><a class="nav-link active" href="#" id="tab2"
                              style="font-size: large;">查詢我的學伴</a>
                          </li>
                        </ul>


                        <div id="content1" style="display: none;">
                          <table class="mt-3" align="center">
                            <td>
                              <form method="get" action="../GetCompanionByMatchRequirement" id="getCompanionUsername">
                                <div class="col-auto" style="margin: 15px 0;">
                                  <label for="" class="fs-5 mb-2 fw-bold">選擇你要的學伴配對條件</label><br>
                                  <label for="">請輸入你的帳號名稱 </label><input class="form-control" type="text"
                                    name="student_nickname" style="border-radius: 10px;text-align: center;"
                                    placeholder="請輸入英文名稱" id="" />
                                  <!-- 											<div class="popup; text-warning" id="popupEng">請輸入英文字！</div> -->
                                </div>
                                <div style="margin: 15px 0;">
                                  <label for="">學伴學習興趣 </label>
                                  <select class="form-select" id="interest" name="companion_learning_interest"
                                    style="border-radius: 10px;padding:5px;">
                                    <option value="">請選擇</option>
                                    <option value="程式設計">程式設計</option>
                                    <option value="電腦繪圖">電腦繪圖</option>
                                    <option value="語言學習">語言學習</option>
                                    <option value="數位行銷">數位行銷</option>
                                    <option value="音樂創作">音樂創作</option>
                                  </select>
                                </div>

                                <div style="margin: 15px 0;">
                                  <label for="">學伴學習頻率 </label>
                                  <select class="form-select" id="frequency" name="companion_learning_frequency"
                                    style="border-radius: 10px;padding:5px;">
                                    <option value="">請選擇</option>
                                    <option value="每週1-3次">每週1-3次</option>
                                    <option value="每週4-7次">每週4-7次</option>
                                  </select>

                                </div>

                                <div style="margin: 15px 0;">
                                  <label for="">學伴性別 </label>
                                  <select class="form-select" name="companion_gender"
                                    style="border-radius: 10px;padding:5px;">
                                    <option value="">請選擇</option>
                                    <option value="Male">男性</option>
                                    <option value="Female">女性</option>
                                  </select>
                                </div>

                                <div style="margin: 15px 0;">
                                  <label for="">學伴母語 </label>
                                  <select class="form-select" name="companion_first_language"
                                    style="border-radius: 10px;padding:5px;">
                                    <option value="">請選擇</option>
                                    <option value="中文">中文</option>
                                    <option value="英文">英文</option>
                                    <option value="日文">日文</option>
                                    <option value="韓文">韓文</option>
                                    <option value="德文">德文</option>
                                    <option value="法文">法文</option>
                                    <option value="西班牙文">西語</option>
                                  </select>
                                </div>

                                <div style="margin: 15px 0;">
                                  <label for="">其他語言 </label>
                                  <select class="form-select" name="companion_speaking_language"
                                    style="border-radius: 10px;padding:5px;">
                                    <option value="">請選擇</option>
                                    <option value="中文">中文</option>
                                    <option value="英文">英文</option>
                                    <option value="日文">日文</option>
                                    <option value="韓文">韓文</option>
                                    <option value="德文">德文</option>
                                    <option value="法文">法文</option>
                                    <option value="西班牙文">西語</option>
                                  </select>
                                </div>
                                <div align="center"><button type="submit" class="btn btn-primary"
                                    style="background-color:#ACD4D6;border:0px;border-radius:8px">查詢新學伴！</button>
                                </div>

                              </form>
                            </td>

                          </table>
                        </div>


                        <!-- 查已配對學伴的tab -->

                        <div id="content2" align="center">
                          <div class="m-4">
                            <h5>你已送出申請的學伴資料</h5>
                          </div>

                          <div class="card-container">
                            <jsp:useBean id="companion" scope="request"
                              class="com.softskillz.companion.model.CompanionBean" />
                            <jsp:useBean id="student" scope="request"
                              class="com.softskillz.account.model.bean.StudentBean" />
                            <% List<CompanionMatchBean> companionMatches = (ArrayList<CompanionMatchBean>
                                )request.getAttribute("companionMatch");
                                if(companionMatches != null){
                                for(CompanionMatchBean companionMatch: companionMatches){ %>
                                <div class="card">

                                  <div class="card-front">
                                    <img src="<%= companionMatch.getCompanionBId().getCompanionPhoto() %>" alt="學伴照片"
                                      class="card-img">
                                    <h2 class="card-title">學伴暱稱：<%=
                                        companionMatch.getCompanionBId().getStudentBeanID().getStudentNickname()%>
                                    </h2>
                                    <p class="card-subtitle">學習興趣：<%=
                                        companionMatch.getCompanionBId().getCompanionLearningInterest()%>
                                    </p>
                                  </div>
                                  <div class="card-back">
                                    <h2 class="card-title">暱稱：<%=
                                        companionMatch.getCompanionBId().getStudentBeanID().getStudentNickname()%>
                                    </h2>
                                    <p class="card-text">性別：<%=
                                        companionMatch.getCompanionBId().getStudentBeanID().getStudentGender()%>
                                    </p>
                                    <p class="card-text">母語：<%=
                                        companionMatch.getCompanionBId().getCompanionFirstLanguage()%>
                                    </p>
                                    <p class="card-text">會說語言：<%=
                                        companionMatch.getCompanionBId().getCompanionSpeakingLanguage()%>
                                    </p>
                                    <p class="card-text">學習頻率：<%=
                                        companionMatch.getCompanionBId().getCompanionLearningFrequency()%>
                                    </p>
                                    <p class="card-text">關於我：<%=
                                        companionMatch.getCompanionBId().getCompanionAboutMe()%>
                                    </p>

                                  </div>
                                </div>

                                <!-- 可以複製上面的卡片結構來添加更多卡片 -->
                                <%} }%>
                          </div>

                          <div><button class="index">回首頁</button></div>
                        </div>








                        <!-- Footer Start -->
                        <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn"
                          data-wow-delay="0.1s">
                          <div class="container py-5">
                            <div class="row g-5">
                              <div class="col-lg-3 col-md-6">
                                <h4 class="text-white mb-3">Quick Link</h4>
                                <a class="btn btn-link" href="">About Us</a>
                                <a class="btn btn-link" href="">Contact Us</a>
                                <a class="btn btn-link" href="">Privacy Policy</a>
                                <a class="btn btn-link" href="">Terms & Condition</a>
                                <a class="btn btn-link" href="">FAQs & Help</a>
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
                                  <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                                  <a class="btn btn-outline-light btn-social" href=""><i
                                      class="fab fa-facebook-f"></i></a>
                                  <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                                  <a class="btn btn-outline-light btn-social" href=""><i
                                      class="fab fa-linkedin-in"></i></a>
                                </div>
                              </div>
                              <div class="col-lg-3 col-md-6">
                                <h4 class="text-white mb-3">圖片集錦</h4>
                                <div class="row g-2 pt-2">
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-1.jpg" alt="" />
                                  </div>
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-2.jpg" alt="" />
                                  </div>
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-3.jpg" alt="" />
                                  </div>
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-2.jpg" alt="" />
                                  </div>
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-3.jpg" alt="" />
                                  </div>
                                  <div class="col-4">
                                    <img class="img-fluid bg-light p-1" src="/img/course-1.jpg" alt="" />
                                  </div>
                                </div>
                              </div>
                              <div class="col-lg-3 col-md-6">
                                <h4 class="text-white mb-3">意見信箱</h4>
                                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                                <div class="position-relative mx-auto" style="max-width: 400px">
                                  <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text"
                                    placeholder="Your email" />
                                  <button type="button"
                                    class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
                                    SignUp
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
                                <div class="col-md-6 text-center text-md-end">
                                  <div class="footer-menu">
                                    <a href="">Home</a>
                                    <a href="">Cookies</a>
                                    <a href="">Help</a>
                                    <a href="">FQAs</a>
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
              </body>

              </html>