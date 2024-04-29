<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>教師行事曆CRUD頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h3>歡迎進入教師行事曆資料系統</h3>
			<h4>請點選以下按鈕進入功能頁面</h4>
		</div>
		<br>

		<form method="get"
			action="${pageContext.request.contextPath}/teacherSchedule/select">
			<input type="submit" name="" value="查詢單筆教師行事曆" />
		</form>
		<br>
		<form method="get"
			action="${pageContext.request.contextPath}/teacherSchedule/selectAll">
			<input type="submit" name="" value="查詢單一教師所有行事曆" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/delete">
			<input type="submit" name="" value="刪除單筆教師行事曆" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/insert">
			<input type="submit" name="" value="新增單筆教師行事曆" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/update">
			<input type="submit" name="" value="修改單筆教師行事曆" />
		</form>
	</div>
	<script>
	fetch("/html/backendPage.html")
	.then(response => {
	if (response.ok) {
	   return response.text();
	}
	}).then(data => {
	document.querySelector('#header').innerHTML = data;
	})
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>