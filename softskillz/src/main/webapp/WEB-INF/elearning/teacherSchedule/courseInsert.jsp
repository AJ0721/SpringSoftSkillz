<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>SoftSkillz 新增課程資料</title>
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
          <i class="fa fa-book me-3"></i>SoftSkillz
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
          <a href="/teacherScheduleFront/schedule" class="nav-item nav-link active"
            >首頁</a
          >
          <div class="nav-item dropdown">
            <a
              href="#"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              >課程</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="/teacherScheduleFront/teacherInsertCourse" class="dropdown-item">新增課程</a>
              <a href="/teacherScheduleFront/teacherInsertCourse" class="dropdown-item">查詢課程</a>
              <a href="/teacherScheduleFront/teacherInsertSchedule" class="dropdown-item">新增行事曆</a>
            </div>
          </div>
		      <a href="#" class="nav-item nav-link">個人中心</a>
          <a href="#" class="nav-item nav-link">論壇</a>
        </div>
	  <form action="/teacher/teacher-logout" method="post" class="d-none d-lg-block">
	    <button type="submit" class="btn btn-primary py-4 px-lg-5">
	      <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
	    </button>
	  </form>
    </nav>
    <!-- Navbar End -->

    <!-- 新增課程 -->
    <div class="container-xxl py-3">
        <div class="container">
            <h3>新增課程資料</h3>
                <form
                    id="courseForm"
                    method="post"
                    action="${pageContext.request.contextPath}/teacherScheduleFront/addCourse"
                    class="needs-validation"
                    novalidate
                  >
                    <div class="row justify-content-center">
                        <!-- 隱藏的教師ID輸入欄位 -->
                        <input type="hidden" id="teacherId" name="teacherId" value="${teacher.teacherId}">
                      <!-- 課程類別的下拉選單 -->
                      <div class="col-md-8 mb-3">
                        <div class="dropdown">
                          <button
                            class="btn btn-primary dropdown-toggle"
                            type="button"
                            id="dropdownMenuCourseCategory"
                            data-bs-toggle="dropdown"
                            aria-haspopup="true"
                            aria-expanded="false"
                            aria-required="true"
                            disabled
                          >
                            請選擇課程類別
                          </button>
                          <div
                            class="dropdown-menu"
                            aria-labelledby="dropdownMenuCourseCategory"
                          >
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('藝術')"
                            >
                              藝術
                            </button>
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('科學')"
                            >
                              科學
                            </button>
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('商業')"
                            >
                              商業
                            </button>
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('程式設計')"
                            >
                              程式設計
                            </button>
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('語言')"
                            >
                              語言
                            </button>
                            <button
                              class="dropdown-item"
                              type="button"
                              onclick="selectCategory('影片剪輯')"
                            >
                              影片剪輯
                            </button>
                          </div>
                          <input
                            type="hidden"
                            id="courseCategory"
                            name="courseCategory"
                            required
                          />
                        </div>
                      </div>

                      <!-- 課程名稱的浮動輸入框 -->
                      <div class="col-md-8 mb-3">
                        <div class="form-floating">
                          <input
                            type="text"
                            class="form-control"
                            id="floatingCourseName"
                            name="courseName"
                            placeholder="輸入課程名稱"
                            required
                          />
                          <label for="floatingCourseName">課程名稱</label>
                        </div>
                      </div>

                      <!-- 課程介紹的浮動輸入區 -->
                      <div class="col-md-8 mb-3">
                        <div class="form-floating">
                          <textarea
                            class="form-control"
                            id="floatingCourseInfo"
                            name="courseInfo"
                            placeholder="輸入課程介紹"
                            style="height: 100px"
                            required
                          ></textarea>
                          <label for="floatingCourseInfo">課程介紹</label>
                        </div>
                      </div>

                      <!-- 課程單價的輸入框 -->
                      <div class="col-md-8 mb-3">
                        <div class="form-floating">
                          <input
                            type="text"
                            class="form-control"
                            id="floatingCoursePrice"
                            name="coursePrice"
                            placeholder="輸入課程單價"
                            required
                          />
                          <label for="floatingCoursePrice">課程單價</label>
                        </div>
                      </div>

                      <!-- 提交按鈕 -->
                      <div class="col-md-8">
                        <button
                          id="toast-success"
                          type="button"
                          class="btn btn-primary btn-lg btn-block"
                        >
                          新增課程
                        </button>
                      </div>
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

     <script>
  
        //選擇課程類別的下拉式選單
        function selectCategory(category) {
          document.getElementById("dropdownMenuCourseCategory").textContent =
            category; // 更新按鈕文字以反映當前選擇
          document.getElementById("courseCategory").value = category; // 更新隱藏 input 的值
        }
  
        $("#toast-success").on("click", function (e) {
          var formData = $("#courseForm").serialize(); // 序列化表單數據
  
          $.ajax({
            url: "${pageContext.request.contextPath}/teacherScheduleFront/addCourse",
            type: "POST",
            data: formData,
            success: function (response) {
              Swal.fire({
                title: "成功!",
                text: "課程添加成功",
                icon: "success",
              }).then((result) => {
                if (result.value) {
                  window.location.reload(); // 這將刷新頁面
                }
              });
            },
            error: function () {
              Swal.fire({
                title: "錯誤!",
                text: "課程添加失敗",
                icon: "error",
              });
            },
          });
        });
      </script>

  </body>
</html>