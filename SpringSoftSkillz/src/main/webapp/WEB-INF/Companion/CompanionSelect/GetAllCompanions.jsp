<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>

<style>
#img{
width: 160px;
height: auto;
}
tr{
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
.right{
	display: flex;
	align-items: center;
/* 	justify-content: flex-end; */
	margin-left:1190px;
}
.add {
	background-color: #dc3545;
	/* 回首頁按鈕的背景顏色 */
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

.add:hover {
	background-color: #c82333;
	/* 滑鼠懸停時的背景顏色 */
}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>學伴資料</h2>
<div class="right">
<button class="add" id="add">新增</button>
<div style="visibility: hidden">空白</div>
</div>
<table border="1">
<tr style="background-color:#a8fefa">
<th>學伴編號<th>學生會員編號<th>學伴帳號名稱<th>學伴性別<th>學伴生日<th>學伴母語<th>學伴會說語言<th>學伴學習興趣<td>學伴學習頻率<td>學伴照片<td>修改<td>刪除
<% List<CompanionBean> companions = (ArrayList<CompanionBean>)request.getAttribute("companions");
SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
for(CompanionBean companion: companions){ %>
<tr><td><%= companion.getCompanionId()%>
<td><%= companion.getStudentId()%>
<td><%= companion.getCompanionUsername()%>
<td><%= companion.getCompanionGender()%>
<td><%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%>
<%-- <td><%= companion.getCompanionBirth()%> --%>
<td><%= companion.getCompanionFirstLanguage()%>
<td><%= companion.getCompanionSpeakingLanguage()%>
<td><%= companion.getCompanionLearningInterest()%>
<td><%= companion.getCompanionLearningFrequency()%>
<td><img id ="img" src= "<%=companion.getCompanionPhoto()%>" alt=photo>
<td>
<form method="post" action="${pageContext.request.contextPath}/GetUpdateData">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<button class="update" type="submit">修改</button>
</form>
</td>
<td>
<form method="post" action="${pageContext.request.contextPath}/DeleteCompanionById">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<button class="delete" type="submit">刪除</button>
</form>
<%} %>
</table>
<h3>共<%= companions.size() %>筆學伴資料</h3>
<div><button class="index">回首頁</button></div>
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
	location.href = "match.do"
	})
	const add = document.querySelector('#add')
	add.addEventListener('click', function() {
		location.href = "match.insert"
	})
</script>
</body>
</html>