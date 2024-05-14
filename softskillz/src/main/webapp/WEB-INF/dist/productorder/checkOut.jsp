<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>結帳</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/productcart/checkout" method="post">
    <h2>填寫您的送貨信息</h2>
    <label>姓名:</label>
    <input type="text" name="name" required><br>
    <label>地址:</label>
    <input type="text" name="address" required><br>
    <label>電話:</label>
    <input type="text" name="phone" required><br>
    <input type="submit" value="提交訂單">
</form>
</body>
</html>
