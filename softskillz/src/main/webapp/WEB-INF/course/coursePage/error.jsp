<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>出現錯誤</title>
</head>
<body>
	<header>
		<h1>
			<a href="${pageContext.request.contextPath}/homepage">Soft Skillz</a>
		</h1>
	</header>
	<div class="head">
		<h2>出現錯誤</h2>
		<h4>請重新操作一次</h4>
		<p>
			<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>
	<script>
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
</body>
</html>