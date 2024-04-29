<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/background.css" />
<title>刪除課程資料</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>刪除課程資料</h2>
		<form id="courseForm" method="post"
			action="${pageContext.request.contextPath}/course/deleted">
			課程編號 : <select name="courseID" required>
				<option value="">請選擇課程</option>
				<c:forEach items="${courses}" var="courses">
					<option value="${courses.courseID}">
						課程編號：${courses.courseID},
						教師編號：${courses.teacherID},課程名稱：${courses.courseName}</option>
				</c:forEach>
			</select>
			<p>
				<input type="submit" value="刪除課程" />
		</form>
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
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>
