<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>課程CRUD頁面</title>
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
	font-size: 24px;
	margin: 5px;
	border-radius: 10px;
	border: solid;
	background-color: #425169;
	color: #fff;
	padding: 5px;
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
</style>
</head>
<body>
	<header>
		<h1>Soft Skillz</h1>
	</header>
	<div class="head">
		<h2>歡迎進入課程資料系統</h2>
		<h4>請點選以下按鈕進入功能頁面</h4>
	</div>
	<br>

	<!-- 查詢單筆 -->
	<form method="get"
		action="${pageContext.request.contextPath}/course/select">
		<input type="submit" value="查詢單筆課程" />
	</form>
	<br>
	<!-- 查詢全部 -->
	<form method="get"
		action="${pageContext.request.contextPath}/course/selectAll">
		<input type="submit" name="" value="查詢所有課程" />
	</form>
	<br>
	<!-- 刪除 -->
	<form method="post"
		action="${pageContext.request.contextPath}/course/delete">
		<input type="submit" name="" value="刪除" />
	</form>
	<br>
	<!-- 新增 -->
	<form method="post"
		action="${pageContext.request.contextPath}/course/insert">
		<input type="submit" name="" value="新增單筆課程" />
	</form>
	<br>
	<!-- 修改 -->
	<form method="post"
		action="${pageContext.request.contextPath}/course/update">
		<input type="submit" name="" value="修改單筆課程" />
	</form>
	
			<div><a href="../../softskillz.homepage">回到後台首頁</a></div>
	
</body>
</html>
