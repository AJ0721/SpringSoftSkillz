
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.softskillz.mall.model.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品資料</title>
<style>
#img{
width: 170px;
height: auto;
}
</style>
</head>
<body style="background-color:#E6F8E0">
<div align="center">
<jsp:useBean id="product" scope="request" class="com.softskillz.mall.model.ProductBean" />
<h2>商品資料</h2>
<div>沒有這筆商品資料</div>
<div><button class="index">回首頁</button></div>
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
		location.href = "mall.do"
	})
</script>
</body>
</html>