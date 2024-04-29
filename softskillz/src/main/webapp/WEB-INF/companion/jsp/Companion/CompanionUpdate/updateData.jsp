<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<% SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");%>
<% SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%>
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<form action="${pageContext.request.contextPath}/Update" method="post">
<table>
<tr><td>學伴編號<td><input type="text" value="<%= companion.getCompanionId()%>" name="companion_id" readonly>
<tr><td>學生會員編號<td><input type="text" value="<%= companion.getStudentId() %>" name="student_id">
<tr><td>學伴帳號名稱<td><input type="text" value="<%= companion.getCompanionUsername() %>" name="companion_username" >
<tr><td>學伴性別<td><input type="text" value="<%= companion.getCompanionGender() %>" name="companion_gender">
<tr><td>學伴生日<td><input type="text" value="<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth())) %>" name="companion_birth">
<tr><td>學伴母語<td><input type="text" value="<%= companion.getCompanionFirstLanguage() %>" name="companion_first_language">
<tr><td>學伴會說語言<td><input type="text" value="<%= companion.getCompanionSpeakingLanguage() %>" name="companion_speaking_language">
<tr><td>學伴學習興趣<td><input type="text" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest">
<tr><td>學伴學習頻率<td><input type="text" value="<%= companion.getCompanionLearningFrequency() %>" name="companion_learning_frequency">
<tr><td>學伴照片<td><img id="img" src="${pageContext.request.contextPath}${companion.companionPhoto}" alt="Companion_Photo" name="companion_photo">
<input type="hidden" name="_method" value="PUT">
<input type="hidden" value="${companion.companionPhoto}" name="companion_photo">
</table>
<input type="submit" value="送出" />
</form>
</div>
</body>
</html>