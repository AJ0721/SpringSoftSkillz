<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Order</title>
</head>
<body>
    <form method="post" action="${pageContext.request.contextPath}/updateOrder2/updated">
        <table>
            <tr>
                <td><label for="id">訂單編號</label></td>
                <td><input type="text" name="order_id" id="id" value="${order.orderId}"></td>
            </tr>
            <tr>
                <td><label for="student">會員編號</label></td>
                <td><input type="text" name="student_id" id="student" value="${order.studentId}"></td>
            </tr>
            <tr>
                <td><label for="date">訂單日期</label></td>
                <td><input type="datetime-local" name="order_date" id="date" value="${order.orderDate}"></td>
            </tr>
            <tr>
                <td><label for="total">總金額</label></td>
                <td><input type="text" name="total_amount" id="total" value="${order.totalAmount}"></td>
            </tr>
            <tr>
                <td><label for="status">訂單狀態</label></td>
                <td><input type="text" name="order_status" id="status" value="${order.orderStatus}"></td>
            </tr>
            <tr>
                <td><label for="address">收貨地址</label></td>
                <td><input type="text" name="shipping_address" id="address" value="${order.shippingAddress}"></td>
            </tr>
        </table>
        <input type="submit" value="修改"/>
    </form>
</body>
</html>
