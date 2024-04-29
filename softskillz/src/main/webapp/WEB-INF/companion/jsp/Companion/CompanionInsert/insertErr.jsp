<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>學伴資料</h2>
<p>新增失敗，資料表中已有相同學生會員編號的資料</p>
<div><button class="index">回首頁</button></div>
</div>
</body>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"
</script>
</html>