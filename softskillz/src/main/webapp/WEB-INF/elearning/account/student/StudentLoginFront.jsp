<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>學生登入</title>
    <style>
      * {
        margin: 0;
        padding: 0;
      }

      body {
        font-family: Arial, sans-serif;
        background-image: url(/dist/account/images/student_login01.jpg);
        background-repeat: no-repeat;
        background-size: 100% 100%;
        background-attachment: fixed;
      }

      .login-container {
        position: absolute;
        top: 50%;
        right: 5%;
        transform: translateY(-50%);
        background-color: #ffffff;
        padding: 50px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
        width: 300px;
        height: 420px;
        text-align: center;
        /* Center the contents */
      }

      .logo {
        max-width: 250px;
        /* Adjust the max-width as needed */
        height: auto;
        margin-bottom: 20px;
      }

      h2 {
        text-align: center;
        margin-bottom: 20px;
      }

      input[type="text"],
      input[type="password"],
      button {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 16px;
      }

      button {
        background-color: rgb(78, 139, 224);
        color: white;
        border: none;
        cursor: pointer;
      }

      button:hover {
        background-color: #b5c4be;
      }

      .links {
        text-align: center;
      }

      .links a {
        margin-right: 10px;
        color: #666;
        text-decoration: none;
      }

      .links a:hover {
        text-decoration: underline;
      }

      .message {
        color: #919fc6;
        text-align: center; /* 文字居中 */
      }
    </style>
  </head>

  <body>
    <div class="login-container">
      <img
        src="/dist/account/images/softskillz_logo.png"
        alt="Softskillz Logo"
        class="logo"
      />
      <form id="loginForm" action="/student/student-login" method="POST">
        <!--  接資料是用mame-->
        <input
          type="text"
          id="usernameOrEmail"
          name="usernameOrEmail"
          placeholder="Username or Email"
          required
        />
        <input
          type="password"
          id="studentPassword"
          name="studentPassword"
          placeholder="Password"
          required
        />
        <button type="submit">Login</button>
        <button type="submit" id="oneclick" style="background-color: #666d7e">
          一鍵輸入
        </button>
      </form>
      <div class="links">
        <a href="/student/student-createPage">註冊</a> <span>|</span> &nbsp;
        <a href="/student/student-forgotPasssword">忘記密碼</a>
      </div>
      <br />
      <div class="message">${loginMsg}</div>
      <div class="message">${createMsg}</div>
      <br />
      <button
        type="button"
        class="forum-button btn btn-primary"
        onclick="forumLoginData()"
        style="margin-top: 50px"
      >
        論壇一鍵輸入
      </button>
    </div>
    <script>
      let oneclick = document.querySelector("#oneclick");
      oneclick.addEventListener("click", (e) => {
        e.preventDefault();
        document.querySelector("#usernameOrEmail").value = "puppy0102";
        document.querySelector("#studentPassword").value = "puppy0102";
      });

      function forumLoginData() {
        document.getElementById("usernameOrEmail").value = "leilu";
        document.getElementById("studentPassword").value = "ea1IzjDUv+";
      }
    </script>
  </body>
</html>
