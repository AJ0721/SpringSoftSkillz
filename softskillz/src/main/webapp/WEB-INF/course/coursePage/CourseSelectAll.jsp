<%@page import="java.util.ArrayList"%>
<%@page import="com.softskillz.course.model.CourseBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="/css/selectAll.css" />
<title>所有課程資料</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<div align="center" class="head">
			<h2>所有課程資料</h2>
			<table border="1" id="myTable" class="display cell-border">
				<thead>
					<tr>
						<th>課程編號</th>
						<th>教師編號</th>
						<th>教師帳號</th>
						<th>課程類別</th>
						<th>課程名稱</th>
						<th>課程介紹</th>
						<th>課程單價</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<CourseBean> courses = (List<CourseBean>) request.getAttribute("courses");
					for (CourseBean course : courses) {
					%>
					<tr>
						<td><%=course.getCourseID().toString()%></td>
						<td><%=course.getTeacherID()%></td>
						<td><%=course.getTeacherBean().getTeacherUserName()%></td>
						<td><%=course.getCourseCategory()%></td>
						<td><%=course.getCourseName()%></td>
						<td><%=course.getCourseInfo()%></td>
						<td><%=course.getCoursePrice()%></td>
						<td>
							<form action="${pageContext.request.contextPath}/course/deleted"
								method="post">
								<input type="hidden" name="courseID"
									value="<%=course.getCourseID()%>" />
								<button type="submit">刪除</button>
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<h3>
				共<%=courses.size()%>筆課程資料
			</h3>
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
	<script>
$(document).ready(function () {
    $('#myTable').DataTable({
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "language": {
            "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh_HANT.json"
        }
    });
});
</script>
	<script src="/js/backend.js"></script>
</body>
</html>