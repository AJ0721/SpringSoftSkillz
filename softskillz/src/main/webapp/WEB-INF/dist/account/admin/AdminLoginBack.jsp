<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>管理員登入</title>
    <style>
      * {
        margin: 0;
        padding: 0;
      }

      .login-container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ffffff;
        padding: 50px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
        width: 300px;
        height: 350px;
        text-align: center;
      }

      .errContainer {
        color: #919fc6;
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
    </style>
  </head>

  <body style="background-color: rgb(222, 233, 247)">
    <div class="login-container">
      <img
        src="/dist/account/images/softskillz_logo.png"
        alt="Softskillz Logo"
        class="logo"
      />
      <form id="loginForm" action="/admin/admin-login" method="POST">
        <input
          type="text"
          name="adminAccount"
          placeholder="Username"
          id="adminAccount"
          required
        /><input
          type="password"
          name="adminPassword"
          placeholder="Password"
          id="adminPassword"
          required
        />
        <button type="submit" id="oneclick" style="background-color: #666d7e">
          一鍵輸入
        </button>
        <button type="submit">Login</button>
        <br />
        <div class="errContainer">${errMsg}</div>
      </form>
    </div>
    <script>
      let oneclick = document.querySelector("#oneclick");
      oneclick.addEventListener("click", (e) => {
        e.preventDefault();
        document.querySelector("#adminAccount").value = "EmmaWatson";
        document.querySelector("#adminPassword").value = "EmmaW123*";
      });
    </script>
  </body>
</html>
