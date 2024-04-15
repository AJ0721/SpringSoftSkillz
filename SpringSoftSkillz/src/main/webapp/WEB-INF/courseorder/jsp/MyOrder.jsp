<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的訂單</title>
<script src="https://kit.fontawesome.com/8f15672443.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/bar.css">
<link rel="stylesheet" href="css/tablefotcart.css">

</head>
<style>
button {
	background-color: #ff8c00; /* Same as your link color */
	color: #fff; /* White text color */
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	font-size: 16px;
	border-radius: 5px;
}

button:hover {
	background-color: #ffad5c; /* Lighter shade of your link color */
}
</style>
<body>
	<%@ include file="../html/testiframe.html"%>

	<div>
		<table border="1" align="center">
			<thead>
				<tr>
					<th>訂單編號</th>
					<th>總金額</th>
					<th>購買時間</th>
					<th>付款方式</th>
					<th>訂單狀態</th>
					<th>詳細資料</th>
					<th>操作</th>
					<th style="display: none">操作</th>
				</tr>
			</thead>
			<c:forEach var="order" items="${orders}">
				<tr>
					<td class="orderID">${order.orderID}</td>
					<td>${order.orderPrice}</td>
					<td>${order.orderDate}</td>
					<td>${order.paymentMethod}</td>
					<td>${order.orderStatus}</td>
					<td><a href="doOrderInfo?orderID=${order.orderID}">詳細資料</a></td>
					<td><button class="cancel" onclick="cancel(this)">取消</button></td>
				</tr>
			</c:forEach>
			<tbody>
			</tbody>
		</table>
	</div>

	<script>

	
	function cancel(button){
		let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
		let data = {
				orderID : orderID
		}
		fetch("cancelOrder",{
			method:"post",
			headers:{"Content-Type":"application/json"},
	        body: JSON.stringify(data)
		}).then(response=>{
			if(response.ok){
	        	window.location.href = ""
	        	
			}
		})
		.catch(error=>{
			console.log(error);
		});
	}
	
	function delOrder(button){
	    let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
	    let data = {
	        orderID : orderID  
	    }
	    fetch("../../DeleteOrder",{
	        method:"post",
	        headers:{"Content-Type":"application/json"},
	        body: JSON.stringify(data)
	    }).then(response=>{
	        if(response.ok){
	            window.location.href = "../../GetOrder"
	        }
	    })
	    .catch(error=>{
	        console.log(error);
	    });
	}
	
	</script>
</body>
</html>