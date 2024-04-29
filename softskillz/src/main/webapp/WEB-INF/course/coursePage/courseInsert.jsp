<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/background.css" />
<title>新增課程頁面</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>新增課程資料</h2>
		<form id="courseForm" method="post"
			action="${pageContext.request.contextPath}/course/add">
			教師編號 : <select name="teacherID" required>
				<option value="">請選擇教師</option>
				<c:forEach items="${teachers}" var="teacher">
					<option value="${teacher.teacherId}">${teacher.teacherFirstName}
						${teacher.teacherLastName} (ID: ${teacher.teacherIdFormatted})</option>
				</c:forEach>
			</select>
			<p>
				課程類別 : <select name="courseCategory" required>
					<option value="">請選擇課程類別</option>
					<option value="藝術">藝術</option>
					<option value="科學">科學</option>
					<option value="商業">商業</option>
					<option value="程式設計">程式設計</option>
					<option value="語言">語言</option>
					<option value="影片剪輯">影片剪輯</option>
				</select>
			<p>
				課程名稱 : <input type="text" name="courseName" required />
			<p>
				課程介紹 :
				<textarea name="courseInfo" rows="10" cols="50" required></textarea>
			<p>
				課程單價 : <input type="text" name="coursePrice" required />
			<p>
				<input type="submit" value="新增課程" />
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
