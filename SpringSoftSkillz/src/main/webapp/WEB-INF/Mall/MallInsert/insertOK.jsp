<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品資料</title>
</head>
<body style="background-color:#E6F8E0">
<div align="center">
<h2>商品資料</h2>
<p>新增成功</p>
<div><button class="index">回首頁</button></div>
</div>

<script>
    const index = document.querySelector('.index')
    index.addEventListener('click', function() {
        location.href = "Mall/MallIndex/index.jsp"
    })
</script>
</body>
</html>