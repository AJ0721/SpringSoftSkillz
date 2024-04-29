<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/successed.css" />
<title>刪除課程資料</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h2>刪除課程資料成功</h2>
			<button onclick="redirectToLoginPage()">回到功能頁面</button>
		</div>
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
	
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>