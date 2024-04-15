<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>管理員CRUD頁面</title>
<style>
.bottom-link {
	margin-top: 20px;
	display: block;
	text-decoration: none;
	color: #4285f4;
	font-size: 16px;
}

/* 調整表格邊框和間隙 */
table {
	border: #000;
	/* 讓表格的邊框合併為單一邊框 */
	margin: auto;
	/* 讓表格在頁面中水平居中 */
	padding: 10px 25px;
	/* 上下為10px，左右為20px */
	text-align: center;
	/* 讓文字在欄位中居中顯示 */
}

.crud-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
	width: 80%;
	max-width: 800px;
	margin: 40px auto;
	text-align: center;
}

th {
	padding: 5px 20px;
	background-color: #606a92;
	color: #ffffff;
	/* 上下為10px，左右為20px */
}

td {
	padding: 5px;
	/* 上下為10px，左右為20px */
}
</style>
</head>

<body style='background-color: #919fc6'>
	<div class="crud-container" align="center">
		<h2>管理員CRUD頁面</h2>
		<div class="button-container"></div>
		<table>
			<tr>
				<td>
					<form method="post"
						action="${pageContext.request.contextPath}/AdminSelectOne">
						管理員id搜尋：<input type="text" name="admin_id"></input>&nbsp;&nbsp; <input
							type="submit" value="搜尋"></input>
					</form>
				</td>
				<td>
					<form method="post"
						action="${pageContext.request.contextPath}/AdminSelectAll">
						<input type="submit" value="搜尋全部"></input>
					</form>
				</td>
			</tr>
		</table>
		<table border="1">
			<tr>
				<th>管理員id</th>
				<th>管理員帳號</th>
				<th>管理員密碼</th>
				<th>管理員層級</th>
					<th>&nbsp;&nbsp;修改&nbsp;&nbsp;</th>
				<th>&nbsp;&nbsp;刪除&nbsp;&nbsp;</th>
			</tr>
			<!-- forEach用在list上 -->
			<!-- var="admin" 去接AdminSelectOne的sevlet傳過來的 ${admins} -->
			<c:forEach items="${admin}" var="admin">
				<tr>
					<!-- var="admin"加拿到的值 -->
					<td>${admin.adminId}</td>
					<td>${admin.adminAccount}</td>
					<td><input type="password" value="${admin.adminPassword}"
						disabled="disabled"
						style="border: none; background-color: transparent;"></td>
					<td>${admin.adminLevel}</td>
					<td>
						<form action="${pageContext.request.contextPath}/AdminUpdate"
							method="Get">
							<input type="hidden" name="adminId" value="${admin.adminId}" />
							<select name="adminLevel">
								<option value="1">Level 1</option>
								<option value="2">Level 2</option>
								<option value="3" selected>Level 3</option>
								<option value="4">Level 4</option>
								<option value="5">Level 5</option>
								<option value="6">Level 6</option>
								<option value="7">Level 7</option>
								<!-- 添加更多層級選項 -->
							</select> <input type="submit" value="修改層級" />
						</form>
					<td><a href="AdminDelete?adminId=${admin.adminId}"><button>刪除</button></a> <%-- 			&nbsp; <a href="AdminUpdate?adminId=${admin.adminId}"><button>修改</button></a>
		 --%></td>
				</tr>
			</c:forEach>
		</table>
		<div><a href="softskillz.homepage">回到後台首頁</a></div>
		<div class="selectErr">${selectErr}</div>
		<div class="rowMsg">${rowMsg}</div>
	</div>
</body>
</body>