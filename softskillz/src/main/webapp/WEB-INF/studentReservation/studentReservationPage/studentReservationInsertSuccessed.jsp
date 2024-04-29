<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/successed.css" />
<title>新增學生資料成功</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h2>新增學生預約資料成功</h2>
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
			window.location.href = "studentReservationPage/studentReservationAllPage";
		}
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>