
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
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
button {
								padding: 8px 20px;
								/* 按鈕內邊距 */
								margin-left: 0px;
								/* 按鈕間距 */
								border: none;
								/* 去除按鈕邊框 */
								border-radius: 4px;
								/* 設置按鈕圓角 */
								background-color: #007bff;
								/* 按鈕背景顏色 */
								color: #fff;
								/* 按鈕文字顏色 */
								cursor: pointer;
								/* 滑鼠懸停樣式 */
							}

							button:hover {
								background-color: #0056b3;
								/* 滑鼠懸停時的背景顏色 */
							}

							.index {
								background-color: #dc3545;
								/* 回首頁按鈕的背景顏色 */
								display: flex;
								align-items: center;
								justify-content: flex-end;
							}

							.index:hover {
								background-color: #c82333;
								/* 滑鼠懸停時的背景顏色 */
							}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<h2>學伴資料</h2>
<div>沒有找到該編號的學伴資料</div>
<div style="margin: 20px"><button class="index">回首頁</button></div>
</div>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"})
</script>
</body>
</html>