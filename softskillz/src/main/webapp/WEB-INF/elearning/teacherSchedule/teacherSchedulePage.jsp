<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="java.time.LocalDate" %>
    <%@ page import="java.util.List" %>
      <%@ page import="java.time.format.DateTimeFormatter" %>
        <%@ page import="com.softskillz.teacherschedule.model.TeacherScheduleBean" %>
          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
              <meta charset="utf-8" />
              <title>SoftSkillz 老師登入後首頁 直接顯示老師行事曆</title>
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

              <!-- Sweet alert -->
              <link rel="stylesheet" href="/assets/extensions/sweetalert2/sweetalert2.min.css" />
              <!--聊天室吧大概-->
              <link href="/elearning/coursechatroom/chatroom.css" rel="stylesheet" />

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

              <!-- 教師行事曆 -->
              <div class="container-xxl py-3">
                <div class="container">
                  <h2 class="display-8" id="courseSchedule">行事曆</h2>
                  <table class="table" id="scheduleTable">
                    <thead>
                      <tr>
                        <th>課程日期</th>
                        <th>時段</th>
                        <th>刪除</th>
                        <th>修改</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% List<TeacherScheduleBean> teacherSchedules = (List<TeacherScheduleBean>)
                          request.getAttribute("teacherSchedules");
                          List<String> formattedDates = (List<String>) request.getAttribute("formattedDates");

                              if (teacherSchedules != null && formattedDates != null) {
                              for (int i = 0; i < teacherSchedules.size(); i++) { TeacherScheduleBean
                                schedule=teacherSchedules.get(i); %>
                                <tr>
                                  <td>
                                    <%= formattedDates.get(i) %>
                                  </td>
                                  <td>
                                    <% String timeSlots=schedule.getTeacherTimeSlots(); for (int j=0; j <
                                      timeSlots.length(); j++) { char slot=timeSlots.charAt(j); String
                                      hour=String.format("%02d:00", j); if (slot=='1' ) { %>
                                      <button type="button" class="btn btn-primary m-1">
                                        <%= hour %>
                                      </button>
                                      <% } else if (slot=='2' ) { %>
                                        <button type="button" class="btn btn-secondary m-1" disabled>
                                          <%= hour %>
                                        </button>
                                        <% } } %>
                                  </td>
                                  <td>
                                    <button type="button" class="btn btn-danger deleteSchedule"
                                      data-schedule-id="<%= schedule.getTeacherScheduleID() %>">
                                      刪除
                                    </button>
                                  </td>
                                  <td>
                                    <button type="button" class="btn btn-primary editSchedule"
                                      data-schedule-id="<%= schedule.getTeacherScheduleID() %>" data-toggle="modal"
                                      data-target="#editModal">
                                      修改
                                    </button>
                                  </td>
                                </tr>
                                <% } } else { %>
                                  <tr>
                                    <td colspan="2">没有可用的行事曆。</td>
                                  </tr>
                                  <% } %>
                    </tbody>
                  </table>
                  <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                      <% Integer currentPage=(Integer) request.getAttribute("currentPage"); Integer totalPages=(Integer)
                        request.getAttribute("totalPages"); if (currentPage !=null && totalPages !=null) { for (int i=1;
                        i <=totalPages; i++) { %>
                        <li class="page-item <%= (i == currentPage) ? " active" : "" %>">
                          <a class="page-link" href="?page=<%= i %>">
                            <%= i %>
                          </a>
                        </li>
                        <% } } else { %>
                          <li class="page-item disabled"><span class="page-link">没有更多頁</span></li>
                          <% } %>
                    </ul>
                  </nav>
                </div>
              </div>

              <!-- 模態視窗和表單 -->
              <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title" id="editModalLabel">修改教師行事曆</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                      </button>
                    </div>
                    <div class="modal-body">
                      <form id="editScheduleForm">
                        <div class="form-group">
                          <label for="teacherId">教師編號</label>
                          <input type="text" class="form-control" id="teacherId" readonly>
                        </div>
                        <div class="form-group">
                          <label for="courseDate">課程日期</label>
                          <input type="text" class="form-control" id="courseDate" readonly>
                        </div>
                        <div id="timeSlots" class="btn-group-toggle" data-toggle="buttons">
                          <!-- 時段按鈕將在此動態生成 -->
                        </div>
                      </form>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">關閉</button>
                      <button type="submit" form="editScheduleForm" class="btn btn-primary">保存修改</button>
                    </div>
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
                        <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text"
                          placeholder="Your email" />
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

              <!-- sweet alert -->
              <script src="/assets/static/js/pages/sweetalert2.js"></script>
              <script src="/assets/extensions/sweetalert2/sweetalert2.min.js"></script>

              <!-- 聊天室吧大概 -->
              <script src="/elearning/coursechatroom/teachchat.js"></script>
              <script>
                $(document).on('click', '.deleteSchedule', function () {
                  var scheduleID = $(this).data('schedule-id'); // 從按鈕獲取教師行事曆ID

                  Swal.fire({
                    title: '確定要刪除這個行事曆嗎？',
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
                        url: '${pageContext.request.contextPath}/teacherSchedule/deleted',
                        type: 'POST',
                        data: { teacherScheduleID: scheduleID },
                        success: function (response) {
                          Swal.fire('刪除成功!', '', 'success').then(() => {
                            window.location.reload(); // 刷新頁面
                          });
                        },
                        error: function () {
                          Swal.fire('刪除失敗!', '請重試。', 'error');
                        }
                      });
                    }
                  });
                });

                // 修改按鈕的點擊事件，用於開啟模態框並填充數據
                $(document).on('click', '.editSchedule', function () {
                  var scheduleId = $(this).data('schedule-id');
                  $.ajax({
                    url: '${pageContext.request.contextPath}/teacherSchedule/update',
                    type: 'GET',
                    data: { teacherScheduleID: scheduleId },
                    success: function (schedule) {
                      $('#teacherId').val(schedule.teacherID);
                      $('#courseDate').val(schedule.courseDate);
                      $('#scheduleId').val(scheduleId);  // 儲存 scheduleId 至隱藏欄位
                      // 填充時段選擇按鈕
                      $('#timeSlots').empty();
                      var timeSlots = schedule.teacherTimeSlots;
                      for (var i = 0; i < timeSlots.length; i++) {
                        var btnClass = (timeSlots.charAt(i) == '1') ? 'btn-success' : 'btn-secondary';
                        var button = $('<button type="button">').addClass('btn ' + btnClass).text(i + ':00')
                          .css({
                            'margin-right': '10px',  // 為每個按鈕添加右邊距
                            'margin-top': '5px',     // 為每個按鈕添加上邊距
                            'margin-bottom': '5px'   // 為每個按鈕添加下邊距
                          });
                        if (timeSlots.charAt(i) == '2') {
                          button.addClass('btn-time-disabled'); // 添加額外的類別
                          button.attr('disabled', true); // 設置為禁用狀態
                        }
                        $('#timeSlots').append(button);
                      }
                      $('#editModal').modal('show');
                    }
                  });
                });

                // 添加隱藏的 input 欄位至表單中以存儲 scheduleId
                $('#editScheduleForm').append('<input type="hidden" id="scheduleId" name="teacherScheduleID">');

                // 時段按鈕的點擊事件，用於切換按鈕狀態
                $('#timeSlots').on('click', 'button', function () {
                  if (!$(this).hasClass('btn-time-disabled')) { // 確保按鈕不是禁用的
                    $(this).toggleClass('btn-success btn-secondary');
                  }
                });

                // 表單提交的處理
                $('#editScheduleForm').on('submit', function (event) {
                  event.preventDefault();  // 阻止表單的默認提交行為

                  // 收集時段數據
                  var timeSlotsData = '';
                  $('#timeSlots button').each(function (index) {
                    if ($(this).hasClass('btn-time-disabled')) {
                      timeSlotsData += '2';  // btn-time-disabled 按鈕顯示為 2
                    } else if ($(this).hasClass('btn-success')) {
                      timeSlotsData += '1';  // btn-success 按鈕顯示為 1
                    } else if ($(this).hasClass('btn-secondary')) {
                      timeSlotsData += '0';  // btn-secondary 按鈕顯示為 0
                    }
                  });

                  var teacherScheduleData = {
                    teacherScheduleID: $('#scheduleId').val(),  // 包括 teacherScheduleID
                    teacherID: $('#teacherId').val(),
                    courseDate: $('#courseDate').val(),
                    teacherTimeSlots: timeSlotsData  // 將時段數據加入到提交數據中
                  };

                  $.ajax({
                    url: '${pageContext.request.contextPath}/teacherSchedule/updated',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(teacherScheduleData),
                    success: function (response) {
                      Swal.fire({
                        title: '成功',
                        text: response,
                        icon: 'success',
                        confirmButtonText: '確定'
                      }).then((result) => {
                        $('#editModal').modal('hide'); // 隱藏模態框
                        location.reload();  // 刷新頁面
                      });
                    },
                    error: function () {
                      Swal.fire({
                        title: '錯誤',
                        text: '修改教師行事曆失敗',
                        icon: 'error',
                        confirmButtonText: '確定'
                      });
                    }
                  });
                });
              </script>
            </body>

            </html>