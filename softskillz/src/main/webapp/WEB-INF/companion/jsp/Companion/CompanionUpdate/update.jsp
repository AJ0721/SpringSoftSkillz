<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>學伴資料</h2>
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />

<p>修改成功</p>
<div><button class="index">回首頁</button></div>
</div>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"})
</script>
</body>
</html>