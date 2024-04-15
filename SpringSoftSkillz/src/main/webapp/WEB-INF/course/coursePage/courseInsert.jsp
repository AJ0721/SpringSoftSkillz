<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>新增課程頁面</title>
<style>
body {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	text-align: center;
	margin: 0;
	padding: 0;
}

header {
	background-color: #425169;
	color: #fff;
	padding: 10px 0;
	text-align: center;
}

h2 {
	font-size: 34px;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	margin: 20px;
	color: #425169;
}

form {
	margin-top: 20px;
}

input[type="text"], textarea {
	border: 2px solid #425169;
	border-radius: 10px;
	padding: 10px;
	margin: 5px;
	font-size: 16px;
	width: 80%;
	max-width: 400px;
}

input[type="submit"] {
	background-color: #425169;
	color: #fff;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
	background-color: #2c3e50;
}
</style>
</head>
<body>
	<header>
		<h1>Soft Skillz</h1>
	</header>
	<h2>新增課程資料</h2>
	<form id="courseForm" method="post"
		action="${pageContext.request.contextPath}/course/add">
		教師編號 : <input type="text" name="teacherID" required />
		<p>
			課程類別 : <input type="text" name="courseCategory" required />
		<p>
			課程名稱 : <input type="text" name="courseName" required />
		<p>
			課程介紹 :
			<textarea name="courseInfo" rows="10" cols="50" required></textarea>
		<p>
			課程單價 : <input type="text" name="coursePrice" required />
		<p>
			<input type="submit" value="新增課程" />
	</form>

</body>
</html>
