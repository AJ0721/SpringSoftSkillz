<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page
	import="com.softskillz.course.model.CourseBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>SoftSkillz 教師查詢課程
    </title>
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

    <!-- Datatable -->
    <link rel="stylesheet" href="/assets/extensions/datatables.net-bs5/css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="/assets/compiled/css/table-datatable-jquery.css"/>

    <!-- Sweet alert -->
    <link rel="stylesheet" href="/assets/extensions/sweetalert2/sweetalert2.min.css"/>
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
              <a href="/teacherScheduleFront/teacherSelectCourse" class="dropdown-item">查詢課程</a>
              <a href="/teacherScheduleFront/teacherInsertSchedule" class="dropdown-item">新增行事曆</a>
            </div>
          </div>
          <a href="about.html" class="nav-item nav-link">About</a>
		      <a href="#" class="nav-item nav-link">個人中心</a>
          <a href="#" class="nav-item nav-link">論壇</a>
          <div class="nav-item dropdown">
            <a
              href="#"
              class="nav-link dropdown-toggle"
              data-bs-toggle="dropdown"
              >Pages</a
            >
            <div class="dropdown-menu fade-down m-0">
              <a href="team.html" class="dropdown-item">Our Team</a>
              <a href="testimonial.html" class="dropdown-item">Testimonial</a>
              <a href="404.html" class="dropdown-item">404 Page</a>
            </div>
          </div>
          <a href="contact.html" class="nav-item nav-link">Contact</a>
        </div>
	  <form action="/teacher/teacher-logout" method="post" class="d-none d-lg-block">
	    <button type="submit" class="btn btn-primary py-4 px-lg-5">
	      <i class="bi bi-person-circle"></i>&nbsp;&nbsp;登出
	    </button>
	  </form>
    </nav>
    <!-- Navbar End -->

    <!-- 課程 -->
    <div class="container-xxl py-3">
        <div class="container">
            <h2 class="display-8" id="courseSchedule">課程</h2>
            <table class="table" id="courseTable">
                <thead>
                    <tr>
                        <th>課程編號</th>
                        <th>課程類別</th>
                        <th>課程名稱</th>
                        <th>課程介紹</th>
                        <th>課程單價</th>
                        <th>刪除</th>
                        <th>修改</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<CourseBean> courses = (List<CourseBean>) request.getAttribute("courses");
                    for (CourseBean course : courses) {
                    %>
                    <tr>
                        <td><%= course.getCourseID().toString() %></td>
                        <td><%= course.getCourseCategory() %></td>
                        <td><%= course.getCourseName() %></td>
                        <td><%= course.getCourseInfo() %></td>
                        <td><%= course.getCoursePrice() %></td>
                        <td>
                            <button type="button" class="btn btn-danger deleteCourse" data-course-id="<%= course.getCourseID() %>">
                                刪除
                            </button>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary editCourse" data-course-id="<%= course.getCourseID() %>">修改</button>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
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

     <!-- sweet alert -->
     <script src="/assets/static/js/pages/sweetalert2.js"></script>
     <script src="/assets/extensions/sweetalert2/sweetalert2.min.js"></script>

     <!-- DataTables -->
    <script src="/assets/extensions/jquery/jquery.min.js"></script>
    <script src="/assets/extensions/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/assets/extensions/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
    <script src="/assets/static/js/pages/datatables.js"></script>

     <script>
        $(document).on('click', '.deleteCourse', function () {
      var courseID = $(this).data('course-id'); // 從按鈕獲取課程ID
  
      Swal.fire({
          title: '確定要刪除這門課程嗎？',
          text: '刪除後將無法恢復！',
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: '是的, 刪除它！',
          cancelButtonText: '取消'
      }).then((result) => {
          if (result.isConfirmed) {
              $.ajax({
                  url: "${pageContext.request.contextPath}/course/deleted",
                  type: 'POST',
                  data: { courseID: courseID },
                  success: function (response) {
                      Swal.fire(
                          '刪除成功!',
                          '課程已經被刪除。',
                          'success'
                      ).then((result) => {
                          if (result.value) {
                              window.location.reload(); // 刷新頁面
                          }
                      });
                  },
                  error: function () {
                      Swal.fire(
                          '錯誤!',
                          '課程刪除失敗。',
                          'error'
                      );
                  }
              });
          }
      });
  });
  
      // 處理點擊修改按鈕事件
      document.addEventListener('click', async function(event) {
      if (event.target.classList.contains('editCourse')) {
          const tr = event.target.closest('tr');
          const cells = tr.children;
  
          for (let i = 1; i < cells.length - 2; i++) {
              const text = cells[i].innerText;
              const htmlElement = `<input type="text" class="form-control" style="width: 100%;" />`
              cells[i].innerHTML = htmlElement;
              cells[i].querySelector("input").value = text;
          }
  
          event.target.innerText = '保存';
          event.target.classList.remove('editCourse');
          event.target.classList.add('saveCourse');
      } else if (event.target.classList.contains('saveCourse')) {
          const result = await Swal.fire({
              title: '確定要更新這門課程嗎？',
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: '更新',
              cancelButtonText: '取消'
          });
          
              if (!result.isConfirmed) {
                return;
              }
                  const tr = event.target.closest('tr');
                  const courseId = event.target.dataset.courseId;
                  const updatedData = {
                      courseID: courseId,
                      courseCategory: tr.cells[1].querySelector('input').value,
                      courseName: tr.cells[2].querySelector('input').value,
                      courseInfo: tr.cells[3].querySelector('input').value,
                      coursePrice: parseInt(tr.cells[4].querySelector('input').value, 10)
                  };
  
                  console.log("修改資料：", updatedData);
  
                  const response = await fetch('/course/update', {
                      method: 'POST',
                      headers: {
                          'Content-Type': 'application/json'
                      },
                      body: JSON.stringify(updatedData)  // 確保將對象轉換為 JSON 字符串
                  })
                  console.log(response)
  
                  if (response && response.ok) {
                    Swal.fire('更新成功!', '', 'success').then(() => {
                      window.location.reload();
                    });
                  } else {
                    Swal.fire('更新失敗!', JSON.stringify(response.text()), 'error'); 
                  }
                }
            });
  
  $(document).ready(function() {
      // 初始化DataTable
      $('#courseTable').DataTable({
          "language": {
              "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh-HANT.json"  // 使用中文介面
          },
          "paging": true,    // 啟用表格分頁
          "lengthChange": true,  // 允許用戶改變分頁設置
          "searching": true,  // 啟用快速搜索
          "ordering": true,  // 啟用排序
          "info": true,      // 顯示頁腳信息
          "autoWidth": false,  // 禁用自動調整列寬
          "responsive": true  // 啟用響應式布局
      });
  });
      </script>

  </body>
</html>