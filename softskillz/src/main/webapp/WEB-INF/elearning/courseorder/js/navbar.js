function getnavbar() {
    return `<a href="/softskillz/fhomepage" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
    <h2 class="m-0 text-primary">
      <img src="/account/images/softskillz_logo.png" alt="SoftSkillz" class="me-3"
        style="max-width: 250px; height: auto; margin-top: 16px" />
    </h2>
  </a>
  <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <div class="navbar-nav ms-auto p-4 p-lg-0">
      <a href="/softskillz/fhomepage" class="nav-item nav-link active">首頁</a>
      <a href="/student/personal-center"  class="nav-item nav-link">個人中心</a>
      <a href="/studentScheduleFront/schedule" 
        class="nav-item nav-link">學生行事曆</a>
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
      <a href="#" class="nav-item nav-link">訂單</a>
      <a href="#" class="nav-item nav-link">論壇</a>
      <a href="#" class="nav-item nav-link">學伴</a>
      <a href="#" class="nav-item nav-link">商城</a>
      <a href="contact.html" class="nav-item nav-link">Contact</a>
    </div>
    
    <div class="navbar-nav p-4 p-lg-0">
      <div class="d-flex align-items-center">
        <form id="student-login-form" action="/student/student-loginPage" method="get">
          <button type="submit" class="btn btn-primary py-4 px-lg-5"
            style=" background-color: #3f6cba;color: white;border: 1px solid transparent;"> 學生登入</button>
        </form>
        <form id="teacher-login-form" action="/teacher/teacher-loginPage" method="get">
          <button type="submit" class="btn btn-primary py-4 px-lg-5"> 老師登入 </button>
        </form>
      </div>
      <form id="student-logout-form" action="/student/student-logout" method="post">
        <button type="submit" class="btn btn-primary py-4 px-lg-5"> 學生登出 </button>
      </form>
    </div>
  </div> `
}

document.querySelector(".navbar").innerHTML += getnavbar();