<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>刪除課程資料</title>
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

input[type="text"] {
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
	<h2>刪除課程資料</h2>
	<form id="courseForm" method="post"
		action="${pageContext.request.contextPath}/course/deleted">
		課程編號 : <input type="text" name="courseID" required /> <br>
		<input type="submit" value="刪除課程" />
	</form>

</body>
</html>
