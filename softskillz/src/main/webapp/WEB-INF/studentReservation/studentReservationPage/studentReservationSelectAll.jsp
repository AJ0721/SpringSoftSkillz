<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/background.css" />
<title>查詢單一學生預約資料頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>查詢單一教師所有行事曆資料</h2>
		<form id="queryForm" method="get"
			action="${pageContext.request.contextPath}/studentReservation/allReservations">
			學生編號 : <select name="studentId" required>
				<option value="">請選擇學生</option>
				<c:forEach items="${student}" var="student">
					<option value="${student.studentId}">
						${student.studentFirstName} ,${student.studentLastName} (ID:
						${student.studentIdFormatted})</option>
				</c:forEach>
			</select>
			<p>
				<input type="submit" value="查詢" />
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