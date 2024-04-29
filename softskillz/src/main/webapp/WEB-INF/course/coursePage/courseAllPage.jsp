<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>課程CRUD頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h3>歡迎進入課程資料系統</h3>
			<h4>請點選以下按鈕進入功能頁面</h4>
		</div>
		<br />
		<!-- 查詢單筆 -->
		<form method="get"
			action="${pageContext.request.contextPath}/course/select">
			<input type="submit" value="查詢單筆課程" />
		</form>
		<br />
		<!-- 查詢全部 -->
		<form method="get"
			action="${pageContext.request.contextPath}/course/selectAll">
			<input type="submit" name="" value="查詢所有課程" />
		</form>
		<br />
		<!-- 刪除 -->
		<form method="post"
			action="${pageContext.request.contextPath}/course/delete">
			<input type="submit" name="" value="刪除單筆課程" />
		</form>
		<br />
		<!-- 新增 -->
		<form method="post"
			action="${pageContext.request.contextPath}/course/insert">
			<input type="submit" name="" value="新增單筆課程" />
		</form>
		<br />
		<!-- 修改 -->
		<form method="post"
			action="${pageContext.request.contextPath}/course/update">
			<input type="submit" name="" value="修改單筆課程" />
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
