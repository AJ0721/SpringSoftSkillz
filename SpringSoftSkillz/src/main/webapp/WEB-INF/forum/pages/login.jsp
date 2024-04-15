<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<style>
* {
	margin: 0;
	padding: 0;
}

.login-container {
	height: 100%;
	display: flex;
	flex-direction: row;
	justify-content: center;
	width: 80%;
	margin: auto;
	margin-top: 40px;
}

.login-form {
	padding: 20px;
	border: grey solid 2px;
	border-radius: 15px;
	margin: 10px;
	width: 100%;
}

.title {
	font-family: system-ui, -apple-system, BlinkMacSystemFont, Robot;
	text-align: center;
	margin: 20px 0 60px 0;
}

button {
	background-color: chocolate;
	border-radius: 2px;
	text-align: center;
	border: 0;
	height: 40px;
	width: 100%;
	color: antiquewhite;
	font-weight: bold;
	margin-top: 30px;
	box-sizing: border-box;
	font-size: 20px;
	cursor: pointer;
}

input {
	padding: 10px;
	font-size: 20px;
	margin: 5px 0px 15px 0px;
	width: 100%;
	box-sizing: border-box;
}
</style>

<title>登入</title>

</head>
<body>
<p style="color: red; text-align: center; margin-top: 30px;">${errors.loginError}</p>
	
	<div class="login-container">
		<div class="login-form">
			<h2 class="title">學生登入</h2>



			<form action="studentchecklogin.controller" method="post">
				<label for="s.username">帳號: ${errors.sNameError}</label> <input
					type="text" name="studentUsername" id="s.username">
				<p>


					<label for="s.password">密碼: ${errors.sPasswordError}</label> <input
						type="password" name="studentPassword" id="s.password">
				<p>


					<button type="submit" value="">登入</button>
			</form>
		</div>

		<div class="login-form">
			<h2 class="title">教師登入</h2>
			<form action="teacherchecklogin.controller" method="post">
				<label for="t.username">帳號: ${errors.tNameError}</label> <input type="text"
					name="teacherUsername" id="t.username">
				<p>

					<label for="t.password">密碼: ${errors.tPasswordError}</label> <input type="password"
						name="teacherPassword" id="t.password">
				<p>
				<div>
					<button type="submit" value="">登入</button>
			</form>
		</div>
	</div>
</body>
</html>