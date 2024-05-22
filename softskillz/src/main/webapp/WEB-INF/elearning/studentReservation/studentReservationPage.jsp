<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page
	import="com.softskillz.studentreservation.model.StudentReservationBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>學生預約頁面</title>
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
    <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
      <a href="/courseFront/selectAllPage" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
          <h2 class="m-0 text-primary">
            <img src="/account/images/softskillz_logo.png" alt="SoftSkillz" class="me-3"
            style="max-width: 250px; height: auto; margin-top: 16px;">
          </h2>
      </a>
      <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
          <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
          <div class="navbar-nav ms-auto p-4 p-lg-0">
              <a href="/courseFront/selectAllPage" class="nav-item nav-link active">首頁</a>
              <div class="nav-item dropdown">
                <a href="/student/personal-center" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">個人中心</a>
                <div class="dropdown-menu fade-down m-0">
                    <a href="/studentScheduleFront/schedule" class="dropdown-item">學生行事曆</a>
                    <a href="/studentReservationFront/reservation" class="dropdown-item">學生預約</a>
                </div>
            </div>
              <a href="#" class="nav-item nav-link">學伴</a>
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
              <a href="#" class="nav-item nav-link">商城</a>
              <a href="contact.html" class="nav-item nav-link">Contact</a>
          </div>
          <div class="navbar-nav p-4 p-lg-0">
            <form id="student-logout-form" action="/student/student-logout" method="post">
               <button type="submit" class="btn btn-primary py-4 px-lg-5">學生登出</button>
              </form>
            </div>
      </div>
  </nav>
  <!-- Navbar End -->

    <!-- 學生預約行事曆 -->
    <div class="container-xxl py-3">
        <div class="container">
            <h2 class="display-8" id="courseSchedule">預約行事曆</h2>
            <table class="table" id="reservationTable">
                <thead>
                    <tr>
                        <th>課程名稱</th>
                        <th>課程日期</th>
                        <th>預約日期</th>
                        <th>總預約時數</th>
                        <th>預約時段</th>
                        <th>刪除</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<StudentReservationBean> studentReservations = (List<StudentReservationBean>) request.getAttribute("studentReservations");
                    List<String> formattedCourseDates = (List<String>) request.getAttribute("formattedCourseDates");
                    List<String> formattedReservationDates = (List<String>) request.getAttribute("formattedReservationDates");
    
                    if (studentReservations != null && formattedCourseDates != null && formattedReservationDates != null) {
                        for (int i = 0; i < studentReservations.size(); i++) { 
                            StudentReservationBean reservation = studentReservations.get(i);
                    %>
                    <tr>
                        <td><%= reservation.getCourseBean().getCourseName() %></td>
                        <td><%= formattedCourseDates.get(i) %></td>
                        <td><%= formattedReservationDates.get(i) %></td>
                        <td><%= reservation.getTotalHours() %></td>
                        <td>
                            <%
                            String timeSlots = reservation.getStudentTimeSlots();
                            StringBuilder availableSlots = new StringBuilder();
                            StringBuilder reservedSlots = new StringBuilder();
                            for (int j = 0; j < timeSlots.length(); j++) {
                                char slot = timeSlots.charAt(j);
                                String hour = String.format("%02d:00", j);
                                if (slot == '1') {
                                    availableSlots.append(hour).append(", ");
                                } else if (slot == '2') {
                                    reservedSlots.append(hour).append(", ");
                                }
                            }
                            if (availableSlots.length() > 0)
                                availableSlots.setLength(availableSlots.length() - 2); // Remove trailing comma
                            if (reservedSlots.length() > 0)
                                reservedSlots.setLength(reservedSlots.length() - 2); // Remove trailing comma
                            out.print(availableSlots.toString());
                            %>
                        </td>
                        <td>
                            <button type="button" class="btn btn-danger deleteReservation" data-reservation-id="<%= reservation.getStudentReservationID() %>">
                                刪除
                            </button>
                        </td>
                    </tr>
                    <% 
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="7">沒有可用的預約。</td>
                    </tr>
                    <% 
                    } 
                    %>
                </tbody>
            </table>
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <% 
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    if (currentPage != null && totalPages != null) {
                        for (int i = 1; i <= totalPages; i++) { 
                    %>
                    <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                        <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                    </li>
                    <% 
                        }
                    } else {
                    %>
                    <li class="page-item disabled"><span class="page-link">没有更多頁</span></li>
                    <% 
                    } 
                    %>
                </ul>
            </nav>
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
        $(document).on('click', '.deleteReservation', function () {
    var reservationID = $(this).data('reservation-id'); // 從按鈕獲取教師行事曆ID

        Swal.fire({
            title: '確定要刪除這個預約嗎？',
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
                    url: '${pageContext.request.contextPath}/studentReservation/deleted',
                    type: 'POST',
                    data: { studentReservationID: reservationID },
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

    </script>
  </body>
</html>
