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
      <link rel="stylesheet" href="/elearning/companion/companionCSS/chatindex.css" />
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
<!--             首頁學伴選單 -->
            <div class="nav-item dropdown">
            <a href="/companionFrontIndex" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">學伴</a>
            <div class="dropdown-menu fade-down m-0">
                <a href="/GetMyData" class="dropdown-item">個人條件設定</a>
                <a href="/companionFrontChatroom" class="dropdown-item">學伴聊天室</a>
              </div>
            </div>
           <!--             首頁學伴選單 --> 
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

      <div align="center">
        <h2 class="mt-5">學伴聊天室</h2>
      </div>
      
      <div id="username-page">
        <div class="username-page-container">
          <h1 class="title">輸入你的暱稱</h1>
          <form id="usernameForm" name="usernameForm">
            <div class="form-group">
              <input type="text" id="name" placeholder="輸入暱稱" autocomplete="off" class="form-control" style="border-radius:20px" />
            </div>
            <div class="form-group">
              <button type="submit" class="accent username-submit" style="border-radius: 10px;">開始聊天</button>
            </div>
          </form>
        </div>
      </div>

<div id="user-list-page" align="center" class="hidden">
  <h2>選擇一個用戶開始聊天</h2>
  <ul id="userList"></ul>
</div>

      <div id="chat-page" class="hidden">
        <div class="chat-container" style="border-radius: 20px;">
          <div class="chat-header">
            <h2>開始聊天吧！</h2>
          </div>
          <div class="connecting">
            Connecting...
          </div>
          <ul id="messageArea">
          </ul>
          
          <form id="messageForm" name="messageForm">
            <div class="form-group">
              <div class="input-group clearfix">
                <input type="text" id="message" placeholder="輸入訊息" autocomplete="off"
                  class="form-control" style="border-radius: 10px;"/>
                <button type="submit" class="primary" style="border-radius: 10px;">送出</button>
              </div>
            </div>
          </form>
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


      <script src="https://cdn.bootcss.com/sockjs-client/1.1.4/sockjs.min.js"></script>
      <script src="https://cdn.bootcss.com/stomp.js/2.3.3/stomp.min.js"></script>
      <script src="/js/main.js"></script>

<script>
var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var userListPage = document.querySelector('#user-list-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var userListElement = document.querySelector('#userList');
var connectingElement = document.querySelector('.connecting');
var chatContainer = document.querySelector('.chat-container');

var stompClient = null;
var username = null;
var targetUser = null;

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

function connect(event) {
    username = document.querySelector('#name').value.trim();

    if(username) {
        usernamePage.classList.add('hidden');
// usernamePage.style.display = 'none';
//         userListPage.classList.remove('hidden');
        chatPage.classList.remove('hidden');

        var socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, onConnected, onError);
    }
    event.preventDefault();
}


function onConnected() {
    // Subscribe to the Public Topic
    stompClient.subscribe('/topic/public', onMessageReceived);

    // Tell your username to the server
    stompClient.send("/app/chat.addUser",
        {},
        JSON.stringify({sender: username, type: 'JOIN'})
    )

    connectingElement.classList.add('hidden');
}


function onError(error) {
    connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
    connectingElement.style.color = 'red';
}


function sendMessage(event) {
    var messageContent = messageInput.value.trim();
    if(messageContent && stompClient) {
        var chatMessage = {
            sender: username,
            content: messageInput.value,
            type: 'CHAT'
        };
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = '';
    }
    event.preventDefault();
}

//添加消息時滾動到最底部函數
function scrollChatToBottom() {
    // 滾動到最底部
    chatContainer.scrollTop = chatContainer.scrollHeight;
}

function onMessageReceived(payload) {
    var message = JSON.parse(payload.body);

    var messageElement = document.createElement('li');

    if(message.type === 'JOIN') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' 加入對話';
    } else if (message.type === 'LEAVE') {
        messageElement.classList.add('event-message');
        message.content = message.sender + ' 離開對話';
    } else {
        messageElement.classList.add('chat-message');

        var avatarElement = document.createElement('i');
        var avatarText = document.createTextNode(message.sender[0]);
        avatarElement.appendChild(avatarText);
        avatarElement.style['background-color'] = getAvatarColor(message.sender);

        messageElement.appendChild(avatarElement);

        var usernameElement = document.createElement('span');
        var usernameText = document.createTextNode(message.sender);
        usernameElement.appendChild(usernameText);
        messageElement.appendChild(usernameElement);
    }

    var textElement = document.createElement('p');
    var messageText = document.createTextNode(message.content);
    textElement.appendChild(messageText);

    messageElement.appendChild(textElement);

    messageArea.appendChild(messageElement);
    messageArea.scrollTop = messageArea.scrollHeight;
    scrollChatToBottom();
}


function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}

usernameForm.addEventListener('submit', connect, true)
messageForm.addEventListener('submit', sendMessage, true)



function selectUser(target) {
  targetUser = target;
  userListPage.classList.add('hidden');
  chatPage.classList.remove('hidden');
}
function onUserListReceived(payload) {
	  var users = JSON.parse(payload.body);
	  userListElement.innerHTML = '';

	  users.forEach(function(user) {
	    if (user !== username) {
	      var userElement = document.createElement('li');
	      userElement.textContent = user;
	      userElement.onclick = function() { selectUser(user); };
	      userListElement.appendChild(userElement);
	    }
	  });
	}
</script>
    </body>

    </html>