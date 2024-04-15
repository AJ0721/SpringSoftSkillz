<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.softskillz.course.model.CourseDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>課程資料</title>
<style type="text/css">
body {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	text-align: center;
	margin: 0;
	padding: 0;
}

header {
	background-color: #425169;
	color: #fff;
	padding: 10px 0;
	text-align: center;
}

.head {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 22px;
	margin: 20px;
	border-radius: 10px;
	border: solid;
	background-color: #fff;
	padding: 20px;
}

td {
	text-align: center;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 22px;
	margin: 5px;
}

input[type="text"] {
	border: none;
	border-bottom: 1px solid #ccc;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 20px;
	margin: 5px;
	padding: 5px;
	background-color: transparent;
	text-align: center;
	width: 100%;
	max-width: 400px;
}

textarea {
	border: 1px solid #ccc;
	border-radius: 5px;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 20px;
	margin: 5px;
	padding: 10px;
	width: 100%;
	max-width: 400px;
	height: 150px; /* 設置文字方塊的高度 */
	resize: vertical; /* 可以垂直調整大小 */
}

button {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	background-color: #425169;
	color: #fff;
	font-size: 22px;
	margin: 5px;
	border-radius: 10px;
	border: solid;
}
</style>
</head>
<body>
	<header>
		<h1>Soft Skillz</h1>
	</header>
	<div class="head">
		<h2>課程資料</h2>
		<%
		// Assuming 'course' attribute is set in the request scope by the servlet/controller
		CourseDTO course = (CourseDTO) request.getAttribute("course");
		if (course != null) {
		%>
		<table>
			<tr>
				<td>課程編號</td>
				<td><%=course.getCourseID()%></td>
			</tr>
			<tr>
				<td>教師編號</td>
				<td><%=course.getTeacherID()%></td>
			</tr>
			<tr>
				<td>教師名稱</td>
				<td><%=course.getTeacherUserName()%></td>
			</tr>
			<tr>
				<td>課程類別</td>
				<td><%=course.getCourseCategory()%></td>
			</tr>
			<tr>
				<td>課程名稱</td>
				<td><%=course.getCourseName()%></td>
			</tr>
			<tr>
				<td>課程介紹</td>
				<td><%=course.getCourseInfo()%></td>
			</tr>
			<tr>
				<td>課程單價</td>
				<td><%=course.getCoursePrice()%></td>
			</tr>
		</table>
		<%
		} else {
		%>
		<p>課程資料無法顯示。請確認是否正確設置了課程資料。</p>
		<%
		}
		%>
		<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>
	<script>
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
</body>
</html>