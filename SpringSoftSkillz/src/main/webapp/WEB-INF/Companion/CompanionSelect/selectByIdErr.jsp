
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>
<style>
#img{
width: 170px;
height: auto;
}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<h2>學伴資料</h2>
<div>沒有這筆學伴資料</div>
<div><button class="index">回首頁</button></div>
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
		location.href = "match.do"
	})
</script>
</body>
</html>