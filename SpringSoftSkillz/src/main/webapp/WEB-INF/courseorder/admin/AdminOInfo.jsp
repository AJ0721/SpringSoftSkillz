<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/AdminOrders.js"></script>
<link rel="stylesheet" href="css/backtest.css">
</head>
<style>
</style>
<body>
	<%@ include file="backtest.html"%>


	<div class="content">
		<div class="result">
			<section>
				<div class="date-selector">

					<button onclick="goBack()" class="custom-button">返回</button>
				</div>
				<div class="content">
					<div class="container">
						<table align="center" style="width: 100%;">
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
										<td>${items.orderID}</td>
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
						</table>
					</div>
				</div>
			</section>
		</div>
	</div>
	<script>
		
	</script>
</body>
</html>
