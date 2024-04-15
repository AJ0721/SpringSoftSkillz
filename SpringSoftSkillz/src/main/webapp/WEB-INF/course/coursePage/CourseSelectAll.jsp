<%@page import="java.util.ArrayList"%>
<%@page import="com.softskillz.course.model.CourseDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!@SuppressWarnings("unchecked")%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>所有課程資料</title>
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
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 22px;
	margin: 5px;
	border-radius: 10px;
	border: solid;
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

th, td {
	text-align: center;
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	font-size: 22px;
	margin: 5px;
}

</style>
</head>

<body>
	<header>
		<h1>Soft Skillz</h1>
	</header>
	<div align="center" class="head">
		<h2>所有課程資料</h2>
		<table border="1" id="myTable" class="display cell-border">
			<tr style="background-color: #EDEFEE">
				<th>課程編號</th>
				<th>教師編號</th>
				<th>教師名稱</th>
				<th>課程類別</th>
				<th>課程名稱</th>
				<th>課程介紹</th>
				<th>課程單價</th>
				<!-- <th>刪除</th> -->
			</tr>
			<%
			List<CourseDTO> courses = (List<CourseDTO>) request.getAttribute("courses");
			for (CourseDTO course : courses) {
			%>
			<tr>
				<td><%=course.getCourseID().toString()%></td>
				<td><%=course.getTeacherID()%></td>
				<td><%=course.getTeacherUserName()%></td>
				<td><%=course.getCourseCategory()%></td>
				<td><%=course.getCourseName()%></td>
				<td><%=course.getCourseInfo()%></td>
				<td><%=course.getCoursePrice()%></td>
				<%-- <td><a
					href="CourseDeleteJNDI?teacher_id=<%=course.getTeacherBean().getTeacherId()%>&course_name=<%=course.getCourseName()%>"
					class="delete-button">刪除</a></td> --%>
				<%
				}
				%>
			</tr>
		</table>
		<h3>
			共<%=courses.size()%>筆課程資料
		</h3>
		<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>

	<script>
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
</body>
</html>