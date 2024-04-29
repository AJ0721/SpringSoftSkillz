<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/background.css" />
<title>刪除學生預約資料</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>刪除學生預約資料</h2>
		<form id="deleteForm" method="post"
			action="${pageContext.request.contextPath}/studentReservation/deleted">
			預約編號 : <select name="studentReservationID" required>
				<option value="">請選擇預約</option>
				<c:forEach items="${reservations}" var="reservations">
					<option value="${reservations.studentReservationID}">
						課程編號：${reservations.studentReservationID},
						教師編號：${reservations.courseID},
						學生編號：${reservations.studentID}</option>
				</c:forEach>
			</select>
			<p>
				<input type="submit" value="刪除預約" />
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
