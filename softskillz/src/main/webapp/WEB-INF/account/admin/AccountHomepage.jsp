<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>後台頁面</title>
<style>
/* Center align the content */
body {
	text-align: center;
	font-family: Arial, sans-serif;
	background-color: #e4edec;
	margin: 0;
	padding: 0;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

/* Container style */
.container {
	background-color: white;
	padding: 40px;
	border-radius: 8px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

/* Style for buttons */
.button {
	background-color: #aab8ab;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	margin: 5px;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
	transition: background-color 0.3s ease;
}

.button:hover {
	background-color: #97a5c0;
}

/* Style for heading */
h3 {
	color: #333;
	margin-bottom: 20px;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/account/homepage/BackendPage.jsp" />
	<div class="container">
		<h3>選擇修改身份：</h3>
		<button class="button">
			<a href="/account/homepage/AdminHomepageCRUD.jsp"
				style="color: inherit; text-decoration: none;">管理員</a>
		</button>
		<button class="button">
			<a href="/account/homepage/StudentHomepageCRUD.jsp"
				style="color: inherit; text-decoration: none;">學生</a>
		</button>
		<button class="button">
			<a href="/account/homepage/TeacherHomepageCRUD.jsp"
				style="color: inherit; text-decoration: none;">老師</a>
		</button>
	</div>
</body>

</html>
