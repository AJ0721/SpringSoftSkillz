<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="java.time.LocalDate"%> <%@ page
import="java.util.List"%> <%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.softskillz.teacherschedule.model.TeacherScheduleBean"%> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>選擇預約時段頁面</title>
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

    <!-- sweet alert -->
    <link
      rel="stylesheet"
      href="/assets/extensions/sweetalert2/sweetalert2.min.css"
    />
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
    <nav
      class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0"
    >
      <a
        href="/softskillz/fhomepage"
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
            </div>
          </div>
          <a href="#" class="nav-item nav-link" style="font-size: 26px">學伴</a>
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
          <a href="#" class="nav-item nav-link" style="font-size: 26px">商城</a>
          <a
            href="/courseorder/order.do"
            class="nav-item nav-link"
            style="font-size: 26px"
            >訂單</a
          >
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
          <c:choose>
            <c:when test="${loggedInUser == 'guest'}">
              <div class="d-flex align-items-center">
                <form
                  id="student-login-form"
                  action="/student/student-loginPage"
                  method="get"
                  class="d-none d-lg-block"
                >
                  <button
                    type="submit"
                    class="btn btn btn-primary py-4 px-lg-5"
                    style="
                      background-color: #3f6cba;
                      color: white;
                      font-size: 26px;
                      border: 1px solid transparent;
                    "
                    onmouseover="this.style.backgroundColor='lightblue'; this.style.borderColor='transparent';"
                    onmouseout="this.style.backgroundColor='#3f6cba'; this.style.borderColor='transparent';"
                  >
                    學生登入
                  </button>
                </form>
                <form
                  id="teacher-login-form"
                  action="/teacher/teacher-loginPage"
                  method="get"
                  class="d-none d-lg-block"
                >
                  <button
                    type="submit"
                    class="btn btn-primary py-4 px-lg-5"
                    style="font-size: 26px"
                  >
                    老師登入
                  </button>
                </form>
              </div>
            </c:when>
            <c:otherwise>
              <form
                action="/student/student-logout"
                method="post"
                class="d-none d-lg-block"
                th:if="${loggedInUser == 'student'}"
              >
                <button
                  type="submit"
                  class="btn btn-primary py-4 px-lg-5"
                  style="font-size: 26px"
                >
                  <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
                </button>
              </form>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </nav>
    <!-- Navbar End -->

    <!-- 課程詳情 -->
    <div class="container mt-5">
      <h2 class="mb-4">選擇預約時段</h2>
      <form id="reservationForm">
        <div class="row mb-4">
          <div id="timeSlots1" class="col-6"></div>
          <div id="timeSlots2" class="col-6"></div>
        </div>
        <input
          type="hidden"
          id="studentTimeSlotsInput"
          name="studentTimeSlots"
        />
        <input type="hidden" id="totalHours" name="totalHours" />
        <input type="hidden" name="courseID" value="${course.courseID}" />
        <input
          type="hidden"
          name="teacherScheduleID"
          value="${teacherSchedule.teacherScheduleID}"
        />
        <button type="submit" class="btn btn-primary">新增預約</button>
      </form>
    </div>

    <!-- Footer Start -->
    <div
      class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn"
      data-wow-delay="0.1s"
    >
      <div class="container py-5">
        <div class="row g-5">
          <div class="col-lg-8 col-md-6">
            <h4 class="text-white mb-3">聯絡我們</h4>
            <p class="mb-2">
              <i class="fa fa-map-marker-alt me-3"></i
              >320桃園市中壢區新生路二段421號
            </p>
            <p class="mb-2"><i class="fa fa-phone-alt me-3"></i> 03 453 2632</p>
            <p class="mb-2">
              <i class="fa fa-envelope me-3"></i>academic@shengte.college
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
          <div class="col-lg-4 col-md-6">
            <h4 class="text-white mb-10">意見信箱</h4>
            <p>請留下您對我們的寶貴意見</p>
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

    <!-- sweet alert -->
    <script src="/assets/static/js/pages/sweetalert2.js"></script>
    <script src="/assets/extensions/sweetalert2/sweetalert2.min.js"></script>

    <script>
      $(document).ready(function () {
        var studentTimeSlots = [];
        var teacherTimeSlots = "${teacherSchedule.teacherTimeSlots}";

        function createTimeSlotButton(hour) {
          var button = document.createElement("button");
          button.type = "button";
          button.innerHTML = hour + ":00";
          button.className = "btn btn-primary mb-2 mr-2";
          button.style.margin = "5px"; // 增加按鈕之間的間距
          button.onclick = function () {
            if (this.classList.contains("btn-success")) {
              this.classList.remove("btn-success");
              this.classList.add("btn-primary");
              var index = studentTimeSlots.indexOf(this.innerHTML);
              studentTimeSlots.splice(index, 1);
            } else {
              this.classList.add("btn-success");
              this.classList.remove("btn-primary");
              studentTimeSlots.push(this.innerHTML);
            }
            document.getElementById("studentTimeSlotsInput").value =
              JSON.stringify(studentTimeSlots);
            document.getElementById("totalHours").value =
              studentTimeSlots.length;
          };
          return button;
        }

        for (var i = 0; i < 24; i++) {
          if (teacherTimeSlots.charAt(i) === "1") {
            // 只顯示時段資料為「1」的按鈕
            var hour = ("0" + i).slice(-2);
            var button = createTimeSlotButton(hour);
            if (i < 12) {
              document.getElementById("timeSlots1").appendChild(button);
            } else {
              document.getElementById("timeSlots2").appendChild(button);
            }
          }
        }

        $("#reservationForm").submit(function (event) {
          event.preventDefault();

          if (studentTimeSlots.length === 0) {
            Swal.fire({
              title: "錯誤!",
              text: "請至少選擇一個時段！",
              icon: "error",
              confirmButtonText: "確定",
            });
            return;
          }

          var formData = $(this).serialize();

          $.ajax({
            url: "/studentReservationFront/add",
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
                    Swal.fire({
                      title: "已傳送Zoom會議室連結，請至聊天室查看",
                      // html:
                      //   '<a href="' +
                      //   response.zoomMeetingUrl +
                      //   '" target="_blank">' +
                      //   response.zoomMeetingUrl +
                      //   "</a>",
                      icon: "info",
                      confirmButtonText: "確定",
                    }).then(() => {
                      window.location.href =
                        "/courseFront/courseDetail/" + response.courseID;
                    });
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
                text: "預約失敗，請稍後再試。",
                icon: "error",
                confirmButtonText: "確定",
              });
            },
          });
        });
      });
    </script>
  </body>
</html>
