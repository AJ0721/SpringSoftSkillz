<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>查詢單筆課程資料</title>
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

input[type="text"] {
	font-weight: bolder;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	border-radius: 10px;
	font-size: 20px;
	margin: 5px;
	padding: 10px;
	width: 80%;
	max-width: 400px;
}

input[type="submit"] {
	font-weight: bolder;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	border-radius: 10px;
	font-size: 20px;
	margin: 5px;
	padding: 10px 20px;
	background-color: #425169;
	color: #fff;
	border: none;
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
	<h2>顯示課程資料</h2>
	<form method="get" action="${pageContext.request.contextPath}/course/onecourse">
		<label for="course_id">輸入課程編號 :</label> <input type="text"
			name="course_id" id="course_id" required />
		<p>
			<input type="submit" value="查詢" />
	</form>
</body>
</html>