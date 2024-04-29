<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>查詢教師行事曆資料頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>查詢教師行事曆資料</h2>
		<form id="queryForm" method="get"
			action="${pageContext.request.contextPath}/teacherSchedule/oneTeacherSchedule">
			教師編號 : <select name="teacherID" required>
				<option value="">請選擇教師</option>
				<c:forEach items="${teachers}" var="teacher">
					<option value="${teacher.teacherId}">${teacher.teacherFirstName}
						${teacher.teacherLastName} (ID: ${teacher.teacherIdFormatted})</option>
				</c:forEach>
			</select>
			<p>
				課程日期 : <input type="date" name="courseDate" required />
			<p>
				<input type="submit" value="查詢單筆教師行事曆" />
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
</body>
</html>