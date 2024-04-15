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
<h2>學伴資料</h2>
<%-- <% SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");%> --%>
<%-- <% SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%> --%>
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionMatchBean" />
<table>
<tr><td>學生編號<td><input type="text" disabled value="<%= companion.getStudentAId() %>">
<tr><td>學伴編號<td><input type="text" disabled value="<%= companion.getStudentBId() %>">
<%-- <tr><td>學伴帳號名稱<td><input type="text" disabled value="<%= companion.getCompanionUsername() %>"> --%>
<%-- <tr><td>學伴性別<td><input type="text" disabled value="<%= companion.getCompanionGender() %>"> --%>
<%-- <tr><td>學伴生日<td><input class="birth" type="text" disabled value="<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%>"> --%>
<%-- <tr><td>學伴母語<td><input type="text" disabled value="<%= companion.getCompanionFirstLanguage() %>"> --%>
<%-- <tr><td>學伴會說語言<td><input type="text" disabled value="<%= companion.getCompanionSpeakingLanguage() %>"> --%>
<%-- <tr><td>學伴學習興趣<td><input type="text" disabled value="<%= companion.getCompanionLearningInterest() %>"> --%>
<%-- <tr><td>學伴學習頻率<td><input type="text" disabled value="<%= companion.getCompanionLearningFrequency() %>"> --%>
<%-- <td><img id="img" src="${pageContext.request.contextPath}/Companion/CompanionImg/rabbit.png" alt="Companion_Photo"></td> --%>
<!-- <tr><td>學伴照片</td> -->
<%-- <td><img id="img" src="${pageContext.request.contextPath}${companion.companionPhoto}" alt="Companion_Photo"></td> --%>
<%-- <td><img id="img" src="${companion.companionPhoto}" alt="Companion_Photo"></td> --%>
<%-- <tr><td>學伴照片<td><input type="text" disabled value="${companion.companionPhoto}"> --%>
</table>
<div style="visibility: hidden;">空白</div>
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