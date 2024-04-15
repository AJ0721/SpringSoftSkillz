<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增課程資料成功</title>
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

.head {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 22px;
	margin: 5px;
	border-radius: 10px;
	padding: 20px;
}

button {
	font-weight: bolder;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	border-radius: 10px;
	font-size: 20px;
	margin: 20px;
	background-color: #425169;
	color: #fff;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

button:hover {
	background-color: #2c3e50;
}
</style>
</head>
<body>
	<header>
		<h1>Soft Skillz</h1>
	</header>
	<div class="head">
		<h2>新增課程資料成功</h2>
		<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>
	<script>
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
</body>
</html>