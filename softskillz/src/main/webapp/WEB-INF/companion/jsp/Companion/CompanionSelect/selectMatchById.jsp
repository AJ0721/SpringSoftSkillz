<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.softskillz.companion.model.CompanionMatchBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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

tr{
text-align:center;
}

td{

text-align:center;

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

		table {
  width: 100%;
  border-collapse: collapse;
  box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);
}

/* 表格標題樣式 */
th {
  background-color: #FFDEDE; /* 背景顏色 */
  color: #333; /* 文字顏色 */
  font-weight: bold; /* 加粗 */
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 表格內容樣式 */
td {
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 奇數行背景色 */
tr:nth-child(odd) {
  background-color: #FFF2F2;
}

/* 鼠標懸停時的背景色 */
tr:hover {
  background-color: #D2E9FF;
}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>學伴資料</h2>
<%-- <% SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");%> --%>
<%-- <% SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%> --%>
<table border="1">
<tr style="background-color:#a8fefa">
<th>你的學生編號<th>已配對學伴的會員編號<th>學伴帳號名稱<th>學伴性別<th>學伴母語<th>學伴會說語言<th>學伴學習興趣<th>學伴學習頻率<th>學伴照片
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<% List<CompanionMatchBean> companionMatches = (ArrayList<CompanionMatchBean>)request.getAttribute("companionMatch");
for(CompanionMatchBean companionMatch: companionMatches){ %>
<tr><td><%= companionMatch.getCompanionAId().getCompanionId() %>
<td><%= companionMatch.getCompanionBId().getCompanionId() %>

<td><%= companionMatch.getCompanionBId().getCompanionUsername() %>
<td><%= companionMatch.getCompanionBId().getCompanionGender() %>
<%-- <tr><td>學伴生日<td><input class="birth" type="text" disabled value="<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%>"> --%>
<td><%= companionMatch.getCompanionBId().getCompanionFirstLanguage() %>
<td><%= companionMatch.getCompanionBId().getCompanionSpeakingLanguage() %>
<td><%= companionMatch.getCompanionBId().getCompanionLearningInterest() %>
<td><%= companionMatch.getCompanionBId().getCompanionLearningFrequency() %>
<%-- <td><img id="img" src="${pageContext.request.contextPath}/Companion/CompanionImg/rabbit.png" alt="Companion_Photo"></td> --%>
<!-- <tr><td>學伴照片</td> -->
<td><img id="img" src="<%=request.getContextPath()%><%=companionMatch.getCompanionBId().getCompanionPhoto()%>" alt="Companion_Photo"></td>
<%-- <td><img id="img" src="${companion.companionPhoto}" alt="Companion_Photo"></td> --%>
<%-- <tr><td>學伴照片<td><input type="text" disabled value="${companion.companionPhoto}"> --%>
<%} %>
</table>
<div style="visibility: hidden;">空白</div>
<div><button class="index">回首頁</button></div>
</div>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"})
</script>
</body>
</html>