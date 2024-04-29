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
			margin: 10px;
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
<h2>符合學習興趣的學伴資料</h2>
<%-- <jsp:useBean id="companion" scope="request" class="com.project2.bean.CompanionBean" /> --%>
<!-- <form action="InsertCompanionByInterestDemo" method="post"> -->
<table border="1">
<tr style="background-color:#a8fefa">
<th>學伴編號<th>學生會員編號<th>學伴帳號名稱<th>學伴性別<th>學伴母語<th>學伴會說語言<th>學伴學習興趣<th>學伴學習頻率<th>學伴照片<th>送出申請
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
<td><img id ="img" src= "<%=request.getContextPath()%><%=companion.getCompanionPhoto()%>" alt=photo>
<td style="text-align: center;">

<form method="post" action="${pageContext.request.contextPath}/InsertCompanion">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<%-- <input type="hidden" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest"> --%>
<button>申請配對</button>

</form>
</td>
<%} %>
</table>
<div><button class="index">回首頁</button></div>
<!-- </form> -->
</div>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"})
</script>
</body>
</html>