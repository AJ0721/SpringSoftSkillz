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
    <title>SoftSkillz 新增教師行事曆</title>
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

    <!-- Sweet alert -->
    <link
rel="stylesheet"
href="/assets/extensions/sweetalert2/sweetalert2.min.css"
/>

<link
      rel="stylesheet"
      href="/assets/extensions/flatpickr/flatpickr.min.css"
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
      <a href="/teacherScheduleFront/schedule" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <h2 class="m-0 text-primary">
          <img src="/account/images/softskillz_logo.png" alt="SoftSkillz" class="me-3"
style="max-width: 250px; height: auto; margin-top: 16px" />
        </h2>
      </a>
      <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse"
        data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
          <a href="/teacherScheduleFront/schedule" class="nav-item nav-link active"
            style="font-size: 26px;">首頁</a>
          <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown" style="font-size: 26px;">課程</a>
            <div class="dropdown-menu fade-down m-0">
              <a href="/teacherScheduleFront/teacherInsertCourse" class="dropdown-item">新增課程</a>
              <a href="/teacherScheduleFront/teacherSelectCourse" class="dropdown-item">查詢課程</a>
              <a href="/teacherScheduleFront/teacherInsertSchedule" class="dropdown-item">新增行事曆</a>
            </div>
          </div>
          <a href="/teacher/teacher-info" class="nav-item nav-link" style="font-size: 26px;">個人中心</a>
          <a href="/forum/home" class="nav-item nav-link" style="font-size: 26px;">論壇</a>
          <!--老師訊息-->
          <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle " data-bs-toggle="dropdown" style="font-size: 27px;"><i
                class="bi bi-chat-square-dots"></i></a>
            <div class=" dropdown-menu fade-down m-0" id="chatlist">
            </div>
          </div>
        </div>
        <form action="/teacher/teacher-logout" method="post" class="d-none d-lg-block">
          <button type="submit" class="btn btn-primary py-4 px-lg-5" style="font-size: 26px;">
            <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
          </button>
        </form>
    </nav>
    <!-- Navbar End -->

    <!-- 新增教師行事曆 -->
    <div class="container-xxl py-3">
        <div class="container">
            <h3>新增行事曆資料</h3>
            <form
            id="scheduleForm"
            method="post"
            action="${pageContext.request.contextPath}/teacherScheduleFront/addSchedule"
          >
          <!-- 隱藏的教師ID輸入欄位 -->
          <input type="hidden" id="teacherId" name="teacherId" value="${teacher.teacherId}">
            <p>
              <input
                type="date"
                id="courseDate"
                class="form-control flatpickr-always-open"
                name="courseDate"
                placeholder="選擇課程日期"
                required
              />
            </p>
            <div class="text-center">
            <fieldset>
              <legend>開課時段 :</legend>
              <!-- 使用 JavaScript 生成開課時段按鈕 -->
              <div class="row">
                <div id="timeSlots1" class="column"></div>
                <div id="timeSlots2" class="column"></div>
              </div>
            </fieldset>
            
              <!-- 提交表單的按鈕 -->
              <button
                type="submit"
                class="btn btn-primary btn-lg"
                id="submitButton"
              >
                新增
              </button>
              <!-- 隐藏字段，傳選擇的時間段資料 -->
              <input
                type="hidden"
                id="teacherTimeSlotsInput"
                name="teacherTimeSlots"
              />
            </div>
          </form>
        </div>
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

     <!-- Date Picker -->
    <script src="/assets/extensions/flatpickr/flatpickr.min.js"></script>
    <script src="/assets/static/js/pages/date-picker.js"></script>

     <script>
        //   生成開課時段按鈕
        var teacherTimeSlots = [];
  
        function createTimeSlotButton(hour) {
          var button = document.createElement("button"); // 改用button元素
          button.type = "button";
          button.innerHTML = hour + ":00"; // 使用innerHTML設置按鈕文本
          button.className = "btn btn-primary"; // 使用Bootstrap樣式
          button.style.marginRight = "8px"; // 直接設定右邊距為8px
          button.style.marginBottom = "8px"; // 直接設定下邊距為8px
          button.onclick = function () {
            if (this.classList.contains("btn-success")) {
              this.classList.remove("btn-success");
              this.classList.add("btn-primary");
              var index = teacherTimeSlots.indexOf(this.innerHTML);
              teacherTimeSlots.splice(index, 1);
            } else {
              this.classList.add("btn-success");
              this.classList.remove("btn-primary");
              teacherTimeSlots.push(this.innerHTML);
            }
            document.getElementById("teacherTimeSlotsInput").value =
              JSON.stringify(teacherTimeSlots);
          };
          return button;
        }
  
        for (var i = 0; i < 24; i++) {
          var hour = ("0" + i).slice(-2);
          var button = createTimeSlotButton(hour);
          if (i < 12) {
            document.getElementById("timeSlots1").appendChild(button);
          } else {
            document.getElementById("timeSlots2").appendChild(button);
          }
        }
  
        //開課時段表單
        document
          .getElementById("scheduleForm")
          .addEventListener("submit", function (event) {
            event.preventDefault(); // 阻止表單預設提交行為
  
            var teacherId = document.getElementById("teacherId").value;
            var courseDate = document.getElementById("courseDate").value;
  
            if (teacherTimeSlots.length === 0) {
              Swal.fire({
                title: "錯誤!",
                text: "請至少選擇一個時段！",
                icon: "error",
                confirmButtonText: "確定",
              });
              return;
            }
  
            // 先發送 AJAX 請求到後端檢查是否存在相同的教師編號和課程日期
            $.ajax({
              url: "${pageContext.request.contextPath}/teacherScheduleFront/check",
              type: "GET",
              data: {
                teacherID: teacherId,
                courseDate: courseDate,
              },
              success: function (exists) {
                if (exists === "true") {
                  Swal.fire({
                    title: "發現重複",
                    text: "該教師的行事曆在此日期已存在，是否轉到修改頁面？",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonText: "跳轉至修改頁面",
                    cancelButtonText: "取消",
                    reverseButtons: true,
                  }).then((result) => {
                    if (result.isConfirmed) {
                      window.location.href =
                        "${pageContext.request.contextPath}/teacherScheduleFront/schedule?teacherID=" +
                        teacherId;
                    }
                  });
                } else {
                  // 如果不存在重複，則繼續處理表單提交
                  submitForm();
                }
              },
              error: function () {
                Swal.fire({
                  title: "錯誤!",
                  text: "檢查資料失敗，請稍後再試。",
                  icon: "error",
                  confirmButtonText: "確定",
                });
              },
            });
  
            function submitForm() {
              var formData = $("#scheduleForm").serialize(); // 序列化表單數據
  
              // 發送 AJAX 請求到後端提交表單
              $.ajax({
                url: "${pageContext.request.contextPath}/teacherScheduleFront/addSchedule", // 處理新增的URL
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
                        window.location.reload(); // 刷新頁面
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
                    text: "添加失敗，請稍後再試。",
                    icon: "error",
                    confirmButtonText: "確定",
                  });
                },
              });
            }
          });
      </script>

  </body>
</html>