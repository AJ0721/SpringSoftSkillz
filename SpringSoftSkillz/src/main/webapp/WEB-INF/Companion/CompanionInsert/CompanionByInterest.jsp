<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>符合學習興趣的學伴資料</title>
<style>
#img{
width: 160px;
height: auto;
}
tr{
text-align:center;
}
td{
text-align:center;
}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>符合學習興趣的學伴資料</h2>
<%-- <jsp:useBean id="companion" scope="request" class="com.project2.bean.CompanionBean" /> --%>
<!-- <form action="InsertCompanionByInterestDemo" method="post"> -->
<table border="1">
<tr style="background-color:#a8fefa">
<th>學伴編號<th>學生會員編號<th>學伴帳號名稱<th>學伴性別<th>學伴母語<th>學伴會說語言<th>學伴學習興趣<td>學伴學習頻率<td>學伴照片<td>新增
<% List<CompanionBean> companions = (ArrayList<CompanionBean>)request.getAttribute("companions");
SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
for(CompanionBean companion: companions){ %>
<tr><td><%= companion.getCompanionId()%>
<td><%= companion.getStudentId()%>
<td><%= companion.getCompanionUsername()%>
<td><%= companion.getCompanionGender()%>
<%-- <td><%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%> --%>
<%-- <td><%= companion.getCompanionBirth()%> --%>
<td><%= companion.getCompanionFirstLanguage()%>
<td><%= companion.getCompanionSpeakingLanguage()%>
<td><%= companion.getCompanionLearningInterest()%>
<td><%= companion.getCompanionLearningFrequency()%>
<td><img id ="img" src= "<%=companion.getCompanionPhoto()%>" alt=photo>
<td>

<form method="post" action="${pageContext.request.contextPath}/InsertCompanion">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<input type="hidden" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest">
<button id="add">新增</button>
</form>

<%} %>
</table>
<div><button class="index">回首頁</button></div>
<!-- </form> -->
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
	location.href = "match.do"
	})
</script>
</body>
</html>