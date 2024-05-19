<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>老師登入</title>
<style>
* {
	margin: 0;
	padding: 0;
}

body, html {
	height: 100%;
	/* 为 body 和 html 设置高度，确保占满全屏 */
	display: flex;
	/* 使用 Flexbox 布局 */
	align-items: center;
	/* 垂直居中 */
	justify-content: center;
	/* 水平居中 */
	font-family: Arial, sans-serif;
}

.image-container {
	width: 800px;
	/* 图片容器占左侧40%的宽度 */
	height: 500px;
	/* 图片容器的高度，占满视口高度 */
	background-image: url(/dist/account/images/teacher_login01.jpg);
	background-size: cover;
	background-position: center;
	border-radius: 10px;
}

.login-container {
	width: 300px;
	/* 固定宽度 */
	height: 400px;
	padding: 50px;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
	margin-left: 5%;
	与图片容器有一定的间距
}

.logo {
	max-width: 250px;
	height: auto;
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

.message {
	color: #919fc6;
	text-align: center; /* 文字居中 */
}
</style>
</head>

<body>
	<div class="image-container"></div>
	<!-- 左側的圖片容器 -->
	<div class="login-container">
		<img src="/dist/account/images/softskillz_logo.png"
			alt="Softskillz Logo" class="logo">
		<form id="loginForm" action="/teacher/teacher-login" method="POST">
			<input type="text" id="usernameOrEmail" name="usernameOrEmail"
				placeholder="Username or Email" required> <input
				type="password" id="teacherPassword" name="teacherPassword"
				placeholder="Password" required>
			<button type="submit">Login</button>
		</form>
		<div class="links">
			<a href="/student/student-createPage">註冊</a> <span>|</span> <a
				href="forgot_password.html">忘記密碼</a>
		</div>
		<br />
		<div class="message">${loginMsg}</div>
		<div class="message">${createMsg}</div>
	</div>
</body>

</html>