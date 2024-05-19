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
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

      <!-- Libraries Stylesheet -->
      <link href="/lib/animate/animate.min.css" rel="stylesheet" />
      <link href="/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

      <!-- Customized Bootstrap Stylesheet -->
      <link href="/css/bootstrap.min.css" rel="stylesheet" />

      <!-- Template Stylesheet -->
      <link href="/css/style.css" rel="stylesheet" />
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
        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
          <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="/softskillz/fhomepage" class="nav-item nav-link active">首頁</a>
            <a href="about.html" class="nav-item nav-link">About</a>
            <a href="#" class="nav-item nav-link">個人中心</a>
            <div class="nav-item dropdown">
              <a href="/courseFront/selectAllPage" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">課程</a>
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
            <a href="#" class="nav-item nav-link">學伴</a>
            <a href="#" class="nav-item nav-link">商城</a>
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
          <div class="col-12">
            <!-- 卡片中放你的功能內容 -->
            <div class="card">
              <!-- <h3 class="card-header">新增課程資料</h3> -->
              <div class="card-body">
                <div>
                  <div>
                    <h2 class="text-center mt-5">學伴聊天室</h2>
                  </div>
                </div><br>

                <div class="page-heading">
                  <div class="page-title">
                    <div class="row">
                      <div class="col-12">
                        <h3>Chatbox</h3>
                        <!-- <p class="text-subtitle text-muted">Our take on a chat conversation.</p> -->
                      </div>

                    </div>
                  </div>
                  <section class="section">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="card">
                          <div class="card-header">
                            <div class="media d-flex align-items-center">
                              <div class="avatar me-3">
                                <!-- <img src="./assets/compiled/jpg/1.jpg" alt="" srcset=""> -->
                                <span class="avatar-status bg-success"></span>
                              </div>
                              <div class="name flex-grow-1">
                                <h6 class="mb-0">Alfy</h6>
                                <span class="text-xs">Online</span>
                              </div>
                              <button class="btn btn-sm">
                                <i data-feather="x"></i>
                              </button>
                            </div>
                          </div>
                          <div class="card-body pt-4 bg-grey">
                            <div class="chat-content">
                              <div class="chat">
                                <div class="chat-body">
                                  <div class="chat-message">Hi Alfy, how can i help you?</div>
                                </div>
                              </div>
                              <div class="chat chat-left">
                                <div class="chat-body">
                                  <div class="chat-message">I'm looking for the best admin dashboard template</div>
                                  <div class="chat-message">With bootstrap certainly</div>
                                </div>
                              </div>
                              <div class="chat">
                                <div class="chat-body">
                                  <div class="chat-message">I recommend you to use Mazer Dashboard</div>
                                </div>
                              </div>
                              <div class="chat chat-left">
                                <div class="chat-body">
                                  <div class="chat-message">That's great! I like it so much :)</div>
                                </div>
                              </div>
                            </div>
                          </div>
                          <div class="card-footer">
                            <div class="message-form d-flex flex-direction-column align-items-center">
                              <a href="http://" class="black"><i data-feather="smile"></i></a>
                              <div class="d-flex flex-grow-1 ms-4">
                                <input type="text" class="form-control" placeholder="Type your message..">
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </section>
                </div>


              </div>

            </div>


          </div>
        </div>


        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
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
                  <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                  <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                  <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
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
                  <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email" />
                  <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
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

        <!-- 測試後台的js,css -->
        <script src="assets/extensions/perfect-scrollbar/perfect-scrollbar.min.js"></script>



    </body>
    <link rel="stylesheet" href="/assets/compiled/css/ui-widgets-chatbox.css">

    </html>