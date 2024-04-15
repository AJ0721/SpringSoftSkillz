<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<script src="https://kit.fontawesome.com/8f15672443.js" crossorigin="anonymous"></script>
<script src="js/Cart2.js"></script>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/bar.css">
<link rel="stylesheet" href="css/tablefotcart.css">

</head>
<style>
.del {
	background-color: #ff6347;
	color: #fff;
	border: none;
	padding: 8px 16px;
	cursor: pointer;
	border-radius: 4px;
	transition: background-color 0.3s;
}

.del:hover {
	background-color: #ff4838;
}
</style>

<body>
	<%@ include file="../html/testiframe.html"%>
	
	<table>
		<thead>
			<tr>
				<th></th>
				<th>教師名稱</th>
				<th>課程名稱</th>
				<th>課程說明</th>
				<th>科目</th>
				<th>堂數</th>
				<th>小計</th>
				<th></th>
			</tr>
		</thead>
		<tbody>

				<c:forEach var="entry" items="${cart}">
					<tr>
						<td><img src="${entry.value.course.teacherPhoto}"></td>
						<td>${entry.value.course.teacherName}</td>
						<td>${entry.value.course.courseName}</td>
						<td>${entry.value.course.courseInfo}</td>
						<td>${entry.value.course.courseCategory}</td>
						<td style="display: none;"><input type="hidden"
							class="cartitemid" value="${entry.key}"></td>
						<td><select name="quantity" class="quantity"
							onchange="change(this)">
								<option value="${1 * entry.value.course.price}"
									${entry.value.quantity == 1 ? 'selected' : ''}>1*NT${entry.value.course.price}/堂
								</option>
								<option value="${5 * entry.value.course.price}"
									${entry.value.quantity == 5 ? 'selected' : ''}>5*NT${entry.value.course.price}/堂
								</option>
								<option value="${10 * entry.value.course.price}"
									${entry.value.quantity == 10 ? 'selected' : ''}>10*NT${entry.value.course.price}/堂
								</option>
								<option value="${20 * entry.value.course.price}"
									${entry.value.quantity == 20 ? 'selected' : ''}>20*NT${entry.value.course.price}/堂
								</option>

						</select></td>
						<td class="subtotal">NT$</td>
						<td><button class="del" type="submit" onclick="remove(this)">
								<i class="fa-solid fa-xmark"></i>
							</button></td>
					</tr>
				</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td class="total" colspan="9" align="right">總金額:</td>
			</tr>
			<tr>
				<td colspan="1"><a href="${pageContext.request.contextPath}/clearCart"><button
							class="del clear" align="center">清空購物車</button></a>
				<td>
				<td colspan="8" align="right"><button type="submit"
						onclick="toOrder(this)">確定</button></td>
			</tr>
		</tfoot>
	</table>


	<script>
		
	</script>
</body>
</html>
