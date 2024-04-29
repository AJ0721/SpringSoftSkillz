<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>學生預約課程CRUD頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h3>歡迎進入學生預約課程資料系統</h3>
			<h4>請點選以下按鈕進入功能頁面</h4>
		</div>
		<br>

		<form method="get"
			action="${pageContext.request.contextPath}/studentReservation/select">
			<input type="submit" name="" value="查詢單筆學生預約" />
		</form>
		<br>
		<form method="get"
			action="${pageContext.request.contextPath}/studentReservation/selectAll">
			<input type="submit" name="" value="查詢單一學生所有預約" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/studentReservation/delete">
			<input type="submit" name="" value="刪除單筆學生預約" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/studentReservation/insert">
			<input type="submit" name="" value="新增單筆學生預約" />
		</form>
		<br>
		<form method="post"
			action="${pageContext.request.contextPath}/studentReservation/update">
			<input type="submit" name="" value="修改單筆學生預約(Demo)" />
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