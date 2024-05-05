<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>註冊學生會員</title>
</head>

<body>
	<h2>學生註冊</h2>
	<form action="addStudent.jsp" method="post">
		姓：<input type="text" name="firstName" required><br> 名：<input
			type="text" name="lastName" required><br> 帳號：<input
			type="text" name="username" required><br> 密碼：<input
			type="password" name="password" required><br> 暱稱：<input
			type="text" name="nickname"><br> 性別：<select
			name="gender" required>
			<option value="Male">男性</option>
			<option value="Female">女性</option>
			<option value="Unspecified">不顯示</option>
		</select><br> 出生日期：<input type="date" name="birthDate" required><br>
		手機：<input type="text" name="mobile" required><br> 電子信箱：<input
			type="email" name="email" required><br> 國家：<input
			type="text" name="country"><br> <input type="submit"
			value="提交">
	</form>
</body>

</html>
