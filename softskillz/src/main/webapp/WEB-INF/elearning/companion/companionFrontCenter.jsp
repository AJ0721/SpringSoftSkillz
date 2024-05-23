<%@page import="com.softskillz.companion.model.CompanionBean" %>
<%@page import="java.text.SimpleDateFormat"%>
  <!-- 定義日期格式 -->
  <% java.text.DateFormat outputFormat=new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="utf-8" />
      <title>SoftSkillz 登入後學伴個人資料（學生）</title>
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
<script>
function updateFileName() {
    var fileInput = document.getElementById('fileNameDisplay');
    var file = fileInput.files[0];
    if (file) {
        var img = document.getElementById('img');
        img.src = URL.createObjectURL(file);
        img.onload = function() {
            URL.revokeObjectURL(img.src); // 釋放內存
        }
    }
}
function upload() {
    var fileInput = document.querySelector('input[type="file"]');
    var file = fileInput.files[0];
    var formData = new FormData();
    
    if (file) {
        alert('照片上傳成功！');
        formData.append('companion_photo', file);
        
        fetch('upload2.controller', {
            method: 'POST',
            body: formData
        }).then(function (response) {
            console.log('status:', response.status);
            return response.json(); // 如果你希望處理 JSON 響應
        }).then(function(data) {
            console.log('Response data:', data);
            // 將文件名顯示在另一個輸入框中
            document.getElementById('fileNameDisplay').value = file.name;
            
        }).catch(function(error) {
            console.error('Upload error:', error);
        });
    } else {
        alert('未上傳照片！');
        // 如果未上傳照片，將文件名設置為 companionPhoto 的值
        var companionPhoto = '${companion.companionPhoto}';
        document.getElementById('fileNameDisplay').value = companionPhoto;
    }

    
}
</script>
      <style>
        #img {
          width: 150px;
          height: auto;
        }
#TABLE{
overflow-x: auto; /* 水平溢出時顯示滾動條 */
}

        
        tr:nth-child(even) {
  		background-color: #FFFAFA;
		}
		
		/* 鼠標懸停時的背景色 */
		tr:hover {
		background-color: #D2E9FF;
		}
		
		#thOfTable{
		background-color: white;
		}
        
        input {
height:30px;
border:solid 1px;
border-radius: 5px;
    width: 100px;
    text-align: center;
    font-size: 17px;
    box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1);
}
        select {
height:30px;
border:solid 1px;
border-radius: 5px;
    width: 110px;
    text-align: center;
    font-size: 17px;
    box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1);
}
textarea {
    border: solid 1px;
    border-radius: 5px;
    width: 140px;
    text-align: center;
    font-size: 17px;
    box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1);
    resize: none;
    height: 100px;
    line-height: 1.4; /* 減少行高，可以設置為任何小於1的值 */
    padding-top: 28px; /* 增加內邊距以便垂直居中 */
}

textarea::-webkit-scrollbar {
  width: 8px; /* 捲動條寬度 */
  opacity: 0; /* 預設不顯示 */
  visibility: hidden;
}

/* 滑鼠懸停在textarea上時顯示捲動條 */
textarea:hover::-webkit-scrollbar {
  opacity: 1; /* 顯示捲動條 */
}

/* 捲動條軌道 */
textarea::-webkit-scrollbar-track {
  background-color: #f1f1f1; /* 捲動條軌道背景色 */
}

/* 捲動條滑塊 */
textarea::-webkit-scrollbar-thumb {
  background-color: #888; /* 捲動條滑塊顏色 */
  border-radius: 5px; /* 捲動條滑塊圓角 */
}

/* 捲動條滑塊懸停效果 */
textarea::-webkit-scrollbar-thumb:hover {
  background-color: #555; /* 捲動條滑塊懸停時的顏色 */
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


      <div class="page-content">
        <section class="row">
          <div class="col-12">
            <!-- 卡片中放你的功能內容 -->
            <div class="card">
              <!-- <h3 class="card-header">新增課程資料</h3> -->
              <div class="card-body">
                <div>
                  <div>
                    <h2 class="text-center mt-5">個人條件設定</h2>
                  </div>
                </div><br>

                <div align="center">
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<jsp:useBean id="student" scope="request" class="com.softskillz.account.model.bean.StudentBean" />
<form action="/UpdateMyData" method="post">
<div id="TABLE" align="center" class="mt-3">
<table id="TABLE" >
<tr id="thOfTable" style="background-color:white" align="center">
<!-- <th>學伴編號<th>學生會員編號 -->
<th>暱稱<th>母語<th>其他會說語言<th>學習興趣<th>學習頻率<th>關於我<th>照片<th>選擇照片<th>上傳
</tr>
<tr align="center">
<input type="hidden" value="<%= companion.getCompanionId()%>" name="companion_id" readonly style="background-color: #FFF2F2">
<input type="hidden" value="<%= companion.getStudentBeanID().getStudentId() %>" name="student_id" readonly style="background-color: #FFF2F2">
<td><input type="text" value="<%= companion.getStudentBeanID().getStudentNickname() %>" name="companion_username" readonly style="background-color: #FFF2F2">
<%-- <tr><td>學伴性別<td><input type="text" value="<%= companion.getCompanionGender() %>" name="companion_gender"> --%>
<%-- <tr><td>學伴生日<td><input type="text" value="<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth())) %>" name="companion_birth"> --%>
<td><input type="text" value="<%= companion.getCompanionFirstLanguage() %>" name="companion_first_language">
<td><input type="text" value="<%= companion.getCompanionSpeakingLanguage() %>" name="companion_speaking_language">
<td><input type="text" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest">

<td>
<select name="companion_learning_frequency">
<% 
        String learningFrequency = companion.getCompanionLearningFrequency();
        if ("每週1-3次".equals(learningFrequency)) {
    %>
                            <option value="每週1-3次"><%= companion.getCompanionLearningFrequency() %></option>
                            <option value="每週4-7次">每週4-7次</option>
                            <% } else if("每週4-7次".equals(learningFrequency)){ %>
                            <option value="每週4-7次"><%= companion.getCompanionLearningFrequency() %></option>
                            <option value="每週1-3次">每週1-3次</option>
                             <% }else {%>
                             <option value=""><%= companion.getCompanionLearningFrequency() %></option>
                             <option value="每週1-3次">每週1-3次</option>
                            <option value="每週4-7次">每週4-7次</option>
                             <% } %>
                          </select>
<td><textarea name="companion_about_me"><%= companion.getCompanionAboutMe() %></textarea>
<td><img id="img" src="${companion.companionPhoto}" alt="個人照片">

<td>
<input type="file" name="companion_photo" id="fileNameDisplay" style="display: none;" onchange="updateFileName()"/>
<button type="button" onclick="document.getElementById('fileNameDisplay').click()" class="btn btn-primary" style="width:100px; border-radius:8px">選擇檔案</button>
<td>
<button type="button" onclick="upload()" class="btn btn-primary" style="width:60px; border-radius:8px">上傳</button>

<input type="hidden" name="_method" value="PUT">
<%-- <input type="hidden" value="${companion.getStudentBeanID()}" name="studentBeanID"> --%>

</table>
</div>
<button type="submit" class="btn btn-primary m-3" style="border-radius:8px">送出</button>
</form>
<div><a href="/companionFrontIndex"><button class="index btn btn-primary" style="background-color:#7D7DFF; border:0px; border-radius:8px">回首頁</button></a></div>
                      
                        </div>
                
              </div>

            </div>


          </div>
        </section>
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
    </body>

    </html>