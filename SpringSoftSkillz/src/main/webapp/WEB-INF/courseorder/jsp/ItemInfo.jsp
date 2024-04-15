<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單詳細</title>
<script src="https://kit.fontawesome.com/8f15672443.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/bar.css">
<link rel="stylesheet" href="css/tablefotcart.css">

</head>
<body>
	<%@ include file="../html/testiframe.html"%>

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

	<script>
		
	</script>
</body>
</html>