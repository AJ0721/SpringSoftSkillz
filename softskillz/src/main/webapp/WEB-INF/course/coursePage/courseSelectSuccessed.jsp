<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.softskillz.course.model.CourseBean"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/successed.css" />
<title>課程資料</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div class="head">
			<h2>課程資料</h2>
			<%
			// Assuming 'course' attribute is set in the request scope by the servlet/controller
			CourseBean course = (CourseBean) request.getAttribute("course");
			if (course != null) {
			%>
			<table>
				<tr>
					<td>課程編號</td>
					<td></td>
					<td><%=course.getCourseID()%></td>
				</tr>
				<tr>
					<td>教師編號</td>
					<td></td>
					<td><%=course.getTeacherID()%></td>
				</tr>
				<tr>
					<td>教師帳號</td>
					<td></td>
					<td><%=course.getTeacherBean().getTeacherUserName()%></td>
				</tr>
				<tr>
					<td>課程類別</td>
					<td></td>
					<td><%=course.getCourseCategory()%></td>
				</tr>
				<tr>
					<td>課程名稱</td>
					<td></td>
					<td><%=course.getCourseName()%></td>
				</tr>
				<tr>
					<td>課程介紹</td>
					<td></td>
					<td><%=course.getCourseInfo()%></td>
				</tr>
				<tr>
					<td>課程單價</td>
					<td></td>
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
	</div>
	<script>
	fetch("/html/backendPage.html")
	.then(response => {
	if (response.ok) {
	   return response.text();
	}
	}).then(data => {
	document.querySelector('#header').innerHTML = data;
	})
	
		function redirectToLoginPage() {
			window.location.href = "coursePage/courseAllPage";
		}
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>