<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學生登入</title>
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	font-family: Arial, sans-serif;
	background-image: url(AccountPhoto/s_login.png);
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
	height: 400px;
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

input[type="text"], input[type="password"], button {
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

<body>
	<div class="login-container">
		<img src="/images/softskillz_logo.png" alt="Softskillz Logo"
			class="logo">
		<form id="loginForm" action="/student/student-login" method="POST">
			<!--  接資料是用mame-->
			<input type="text" id="usernameOrEmail" name="usernameOrEmail"
				placeholder="Username or Email" required> <input
				type="password" id="studentPassword" name="studentPassword"
				placeholder="Password" required>
			<button type="submit">Login</button>
		</form>
		<div class="links">
			<a href="/student/student-createPage">註冊</a> <span>|</span> <a
				href="forgot_password.html">忘記密碼</a>
		</div>
		<br />
		<div>${loginMsg}</div>
		<div>${createMsg}</div>
	</div>
</body>

</html>
