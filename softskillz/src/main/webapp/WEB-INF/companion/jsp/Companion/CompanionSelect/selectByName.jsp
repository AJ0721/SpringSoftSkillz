<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@page import="com.softskillz.account.model.bean.StudentBean"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
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
<h2>學伴資料</h2>
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<%-- <jsp:useBean id="student" scope="request" class="com.softskillz.account.model.bean.StudentBean" /> --%>
<table>
<tr><td>學伴編號<td><input type="text" disabled value="<%= companion.getCompanionId()%>">
<tr><td>學生會員編號<td><input type="text" disabled value="<%= companion.getStudentBeanID().getStudentId() %>">
<tr><td>學伴帳號名稱<td><input type="text" disabled value="<%= companion.getStudentBeanID().getStudentNickname() %>">
<tr><td>學伴性別<td><input type="text" disabled value="<%= companion.getStudentBeanID().getStudentGender() %>">
<tr><td>學伴生日<td><input class="birth" type="text" disabled value="<%= companion.getStudentBeanID().getStudentBirth()%>">
<tr><td>學伴母語<td><input type="text" disabled value="<%= companion.getCompanionFirstLanguage() %>">
<tr><td>學伴會說語言<td><input type="text" disabled value="<%= companion.getCompanionSpeakingLanguage() %>">
<tr><td>學伴學習興趣<td><input type="text" disabled value="<%= companion.getCompanionLearningInterest() %>">
<tr><td>學伴學習頻率<td><input type="text" disabled value="<%= companion.getCompanionLearningFrequency() %>">
<tr><td>學伴照片<td><img id="img" src="${pageContext.request.contextPath}${companion.studentBeanID.studentPhoto}" alt="Companion_Photo" name="companion_photo">
</table>
<div style="visibility: hidden;">空白</div>
<div><button class="index">回首頁</button></div>
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
		location.href = "/companionIndex.html"
	})
</script>
</body>
</html>