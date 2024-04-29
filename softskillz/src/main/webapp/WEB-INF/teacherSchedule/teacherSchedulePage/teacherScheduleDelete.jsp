<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>刪除教師行事曆頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>刪除教師行事曆資料</h2>
		<form id="deleteForm" method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/deleted">
			教師行事曆編號 : <select name="teacherScheduleID" required>
				<option value="">請選擇教師行事曆</option>
				<c:forEach items="${teacherSchedules}" var="teacherSchedules">
					<option value="${teacherSchedules.teacherScheduleID}">
						編號:${teacherSchedules.teacherScheduleID}
						,教師編號:${teacherSchedules.teacherID}
						,開課日期:${teacherSchedules.courseDate}</option>
				</c:forEach>
			</select>
			<p>

				<input type="submit" value="刪除" />
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
