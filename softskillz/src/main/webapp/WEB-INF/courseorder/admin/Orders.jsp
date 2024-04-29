<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/js/AdminOrders.js"></script>
<link rel="stylesheet" href="/css/backtest.css">
</head>
<style>
.search button {
	background-color: #3498db;
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 4px;
}

.search button:hover {
	background-color: #2980b9;
}
</style>
<body>
	<div id="header"></div>
	<section>
		<div class="content">
			<div class="result">
				<div class="search">
					<button onclick="selectAll()">全部訂單</button>
				</div>
				<div class="date-selector">
					<label class="t1" for="">date:</label> <input type="date"
						name="date1" id="date1"><input type="date" name="date2"
						id="date2">
					<button onclick="getDate1()" class="custom-button">確定</button>
				</div>
				<div class="content">
					<div class="container">
						<table align="center" style="width: 100%;">
							<thead>
								<tr>
									<th>訂單編號</th>
									<th>購買人</th>
									<th>總金額</th>
									<th>購買時間</th>
									<th>付款方式</th>
									<th>訂單狀態</th>
									<th>詳細資料</th>
									<th>操作</th>
									<th>操作</th>
								</tr>
							</thead>
							<c:forEach var="order" items="${orders}">
								<tr>
									<td class="orderID">${order.orderID}</td>
									<td>${order.orderPrice}</td>
									<td>${order.studentID}</td>
									<td>${order.orderDate}</td>
									<td>${order.paymentMethod}</td>
									<td>${order.orderStatus}</td>
									<td><a href="/adminorder/orderitem/${order.orderID}"><button
												class="custom-button">詳細資料</button></a></td>
									<td><button class="custom-button cancel"
											onclick="cancel(this)">取消訂單</button></td>
									<td><button class="custom-button cancel"
											onclick="delOrder(this)">刪除</button></td>
								</tr>
							</c:forEach>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>
    fetch('/html/backtest.html')
    .then(response => response.text())
    .then(data => {
        document.getElementById('header').innerHTML = data;
    })
    .catch(error => console.error('頁首內容加載錯誤:', error));
	</script>
</body>
</html>