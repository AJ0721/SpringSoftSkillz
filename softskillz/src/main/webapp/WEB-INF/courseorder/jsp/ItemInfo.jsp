<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>訂單詳細</title>
			<script src="https://kit.fontawesome.com/8f15672443.js" crossorigin="anonymous"></script>
			<script src="/courseorder/js/fetch.js"></script>

			<link rel="stylesheet" href="/courseorder/css/reset.css">
			<link rel="stylesheet" href="/courseorder/css/bar.css">
			<link rel="stylesheet" href="/courseorder/css/tablefotcart.css">

		</head>
		<style>
			.header {
				background-image: url(/img/xxx.jpg);
				max-width: 100%;
				height: 420px;
				background-repeat: no-repeat;
				background-size: cover;
				background-position: center center;

				.text {
					text-align: center;
				}
			}
		</style>

		<body>
			<div id="fetch"></div>

			<table>
				<thead>
					<tr>
						<th>訂單編號</th>
						<th>教師名稱</th>
						<th>課程名稱</th>
						<th>課程類別</th>
						<th>課程單家</th>
						<th>購買堂數</th>
						<th>小記</th>
						<th>使用狀態</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="items" items="${items}">
						<tr>
							<td class="orderID">${items.orderID}</td>
							<td>${items.teacherName }</td>
							<td>${items.courseName}</td>
							<td>${items.courseCategory}</td>
							<td class="price">${items.coursePrice}</td>
							<td class="qty">${items.qty}</td>
							<td>${items.coursePrice*items.qty}</td>
							<td>${items.status}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<td colspan="3"></td>
					<td colspan="2" align="center"><a href="/courses/course.do"></a></td>
					<td colspan="3" align="center"><button id="send" onclick="goBack()">返回</button></td>
				</tfoot>
			</table>

			<script>

				function goBack() {
					window.history.back();
				}
				fetch("/courseorder/html/testiframe3.html")
					.then(response => {
						if (response.ok) {
							return response.text();
						}
					}).then(data => {
						document.querySelector('#fetch').innerHTML = data;
					})
			</script>
		</body>

		</html>