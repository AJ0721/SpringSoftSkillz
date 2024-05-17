<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    <meta charset="utf-8" />
    <title>課程詳情頁面</title>
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
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Libraries Stylesheet -->
    <link href="/lib/animate/animate.min.css" rel="stylesheet" />
    <link
      href="/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/css/style.css" rel="stylesheet" />
  </head>

  <body>
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div
        class="spinner-border text-primary"
        style="width: 3rem; height: 3rem"
        role="status"
      >
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
              <!-- 新增個人中心連結 -->
              <c:if test="${loggedInUser == 'student'}">
                <a href="/student/personal-center" class="nav-item nav-link">個人中心</a>
            </c:if>
              <a href="about.html" class="nav-item nav-link">About</a>
              <div class="nav-item dropdown">
                  <a href="/courseFront/selectAllPage" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">課程</a>
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
              <a href="#" class="nav-item nav-link">論壇</a>
              <a href="#" class="nav-item nav-link">學伴</a>
              <a href="#" class="nav-item nav-link">商城</a>
              <a href="contact.html" class="nav-item nav-link">Contact</a>
          </div>
          <div class="navbar-nav p-4 p-lg-0">
              <c:choose>
                  <c:when test="${loggedInUser == 'guest'}">
                      <div class="d-flex align-items-center">
                          <form id="student-login-form" action="/student/student-loginPage" method="get" class="me-2">
                              <button type="submit" class="btn btn-primary" style="background-color: #3f6cba; color: white; border: 1px solid transparent;">
                                  學生登入
                              </button>
                          </form>
                          <form id="teacher-login-form" action="/teacher/teacher-loginPage" method="get" class="me-2">
                              <button type="submit" class="btn btn-primary">老師登入</button>
                          </form>
                      </div>
                  </c:when>
                  <c:otherwise>
                      <form id="student-logout-form" action="/student/student-logout" method="post" class="me-2">
                          <button type="submit" class="btn btn-primary">學生登出</button>
                      </form>
                  </c:otherwise>
              </c:choose>
          </div>
      </div>
  </nav>
  <!-- Navbar End -->

    <!-- 課程詳情 -->
    <div class="container-xxl py-3">
        <div class="container">
          <div class="row">
            <div class="col-lg-9">
                <h2 class="display-8">${course.courseName}</h2>
                <p class="h5">類別: <span>${course.courseCategory}</span></p>
            </div>
          </div>
        </div>
      </div>

    <div class="container-xxl py-3">
        <div class="container">
          <div class="row">
            <div class="col-lg-8">
                <p class="h5">課程介紹</p>
                <p><span>${course.courseInfo}</span></p>
            </div>
          </div>
        </div>
      </div>
    
      <div class="container-xxl py-3">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
            <h2 class="display-8">教師資訊</h2>
            <img src="${teacherPhotoPath}" alt="Teacher Photo" class="rounded-circle mb-3" style="width: 150px; height: 150px;" />
            <p class="h5">
                姓名: <span>${teacher.teacherFirstName} ${teacher.teacherLastName}</span>
            </p>
            <p class="h5">國家 : <span>${teacher.teacherCountry}</span></p>
            <p class="h5">教學經驗 : <span>${teacher.experience}</span>年</p>
            <p class="h5">教育程度 : <span>${teacher.teacherEducation}</span></p>
            <p class="h5">專長 : <span>${teacher.strength}</span></p>
                </div>
            </div>
        </div>
    </div>

      <div class="container-xxl py-3">
        <div class="container">
            <h2 class="display-8" id="courseSchedule">授課時間</h2>
            <table class="table" id="scheduleTable">
                <thead>
                <tr>
                    <th>課程日期</th>
                    <th>時段</th>
                </tr>
                </thead>
                <tbody>
                <% 
                List<TeacherScheduleBean> teacherSchedules = (List<TeacherScheduleBean>) request.getAttribute("teacherSchedules");
                List<String> formattedDates = (List<String>) request.getAttribute("formattedDates");
                for (int i = 0; i < teacherSchedules.size(); i++) { 
                    TeacherScheduleBean schedule = teacherSchedules.get(i);
                %>
                <tr>
                    <td><%= formattedDates.get(i) %></td>
                    <td>
                    <%
                    String timeSlots = schedule.getTeacherTimeSlots();
                    for (int j = 0; j < timeSlots.length(); j++) {
                        char slot = timeSlots.charAt(j);
                        String hour = String.format("%02d:00", j);
                        if (slot == '1') { %>
                        <button type="button" class="btn btn-primary m-1"><%= hour %></button>
                        <% } else if (slot == '2') { %>
                        <button type="button" class="btn btn-secondary m-1" disabled><%= hour %></button>
                        <% }
                    }
                    %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
          <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
              <% 
              int currentPage = (int) request.getAttribute("currentPage");
              int totalPages = (int) request.getAttribute("totalPages");
              for (int i = 1; i <= totalPages; i++) { 
              %>
              <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                <a class="page-link" href="?page=<%= i %>"><%= i %></a>
              </li>
              <% } %>
            </ul>
          </nav>
        </div>
      </div>
    
      <!-- 浮動按鈕 -->
      <div id="floatingButtons" class="d-none d-lg-block position-fixed">
        <c:choose>
            <c:when test="${loggedInUser == 'guest'}">
                <a href="#" class="btn btn-primary btn-lg d-block mb-2" id="button1">1堂: NT$ <span id="price1"></span></a>
                <a href="#" class="btn btn-primary btn-lg d-block mb-2" id="button5">5堂: NT$ <span id="price5"></span></a>
                <a href="#" class="btn btn-primary btn-lg d-block mb-2" id="button10">10堂: NT$ <span id="price10"></span></a>
                <a href="#" class="btn btn-primary btn-lg d-block" id="button20">20堂: NT$ <span id="price20"></span></a>
            </c:when>
            <c:when test="${loggedInUser == 'student'}">
                <a href="/coursecart/${course.courseID}/1" class="btn btn-primary btn-lg d-block mb-2 cartbtn" id="button1">1堂: NT$ <span id="price1"></span></a>
                <a href="/coursecart/${course.courseID}/5" class="btn btn-primary btn-lg d-block mb-2 cartbtn" id="button5">5堂: NT$ <span id="price5"></span></a>
                <a href="/coursecart/${course.courseID}/10" class="btn btn-primary btn-lg d-block mb-2 cartbtn" id="button10">10堂: NT$ <span id="price10"></span></a>
                <a href="/coursecart/${course.courseID}/20" class="btn btn-primary btn-lg d-block cartbtn" id="button20">20堂: NT$ <span id="price20"></span></a>
            </c:when>
            
        </c:choose>
    </div>



    <!-- Footer Start -->
    <div
      class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn"
      data-wow-delay="0.1s"
    >
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
              <a class="btn btn-outline-light btn-social" href=""
                ><i class="fab fa-twitter"></i
              ></a>
              <a class="btn btn-outline-light btn-social" href=""
                ><i class="fab fa-facebook-f"></i
              ></a>
              <a class="btn btn-outline-light btn-social" href=""
                ><i class="fab fa-youtube"></i
              ></a>
              <a class="btn btn-outline-light btn-social" href=""
                ><i class="fab fa-linkedin-in"></i
              ></a>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <h4 class="text-white mb-3">圖片集錦</h4>
            <div class="row g-2 pt-2">
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-1.jpg"
                  alt=""
                />
              </div>
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-2.jpg"
                  alt=""
                />
              </div>
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-3.jpg"
                  alt=""
                />
              </div>
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-2.jpg"
                  alt=""
                />
              </div>
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-3.jpg"
                  alt=""
                />
              </div>
              <div class="col-4">
                <img
                  class="img-fluid bg-light p-1"
                  src="/img/course-1.jpg"
                  alt=""
                />
              </div>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <h4 class="text-white mb-3">意見信箱</h4>
            <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
            <div class="position-relative mx-auto" style="max-width: 400px">
              <input
                class="form-control border-0 w-100 py-3 ps-4 pe-5"
                type="text"
                placeholder="Your email"
              />
              <button
                type="button"
                class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2"
              >
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
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
      ><i class="bi bi-arrow-up"></i
    ></a>

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
      // 浮動按鈕
        $(document).ready(function() {
            var coursePrice = parseFloat("${course.coursePrice}");
            
            // 設定按鈕價格
            $('#price1').text(coursePrice);
            $('#price5').text(coursePrice * 5 * 0.95);
            $('#price10').text(coursePrice * 10 * 0.9);
            $('#price20').text(coursePrice * 20 * 0.85);

            var floatingButtons = $('#floatingButtons');
            var courseSchedule = $('#courseSchedule');
            var scheduleOffset = courseSchedule.offset().top;
            var buttonsHeight = floatingButtons.outerHeight();

            $(window).scroll(function() {
                var scrollPos = $(window).scrollTop();
                var windowHeight = $(window).height();

                if (scrollPos + windowHeight > scheduleOffset + buttonsHeight) {
                    floatingButtons.removeClass('position-fixed').css({
                        position: 'absolute',
                        top: scheduleOffset - buttonsHeight + 'px',
                        right: '10%',
                        transform: 'translateY(0)'
                    });
                } else {
                    floatingButtons.addClass('position-fixed').css({
                        top: '40%',
                        right: '10%',
                        transform: 'translateY(-50%)'
                    });
                }
            }).scroll();
        });
      
        let toCart =  document.querySelectorAll(".cartbtn");
        toCart.forEach((ele)=>{
          ele.addEventListener("click",(e)=>{
            e.preventDefault();
            let href = ele.getAttribute("href");
            console.log(href);
            addToCart(href)
          })
        })
        function addToCart(href){
        	console.log(href)
        	fetch(href, {
        	      method: "POST",
        	      headers: {
        	        "Content-Type": "application/json"
        	      },
        	      // 如果需要傳送 body，可以添加這一行，否則可以省略
        	      // body: JSON.stringify({ /* your data here */ })
        	    })
        	    .then(response => {
        	      if (response.ok) {
        	        window.location.href = "/coursecart/cart.do";
        	      } else {
        	        console.error('Failed to add to cart:', response.statusText);
        	      }
        	    })
        	    .catch(error => {
        	      console.error('Error:', error);
        	    });
    
        }
    </script>

  </body>
</html>
