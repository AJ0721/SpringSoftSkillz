<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>查詢結果</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/backtest.css" rel="stylesheet">
</head>
<body>
<div id="heade"></div>
<section>
    <div class="container mt-5">
        <jsp:useBean id="order" scope="request" class="com.softskillz.productorder.model.Order"/>
        <h2 class="text-center mb-4">訂單詳情</h2>
        <div class="mb-3">
            <label for="orderId" class="form-label">訂單編號:</label>
            <input type="text" class="form-control" id="orderId" value="${order.orderId}" disabled>
        </div>
        <div class="mb-3">
            <label for="studentId" class="form-label">會員編號:</label>
            <input type="text" class="form-control" id="studentId" value="${order.studentId}" disabled>
        </div>
        <div class="mb-3">
            <label for="orderDate" class="form-label">訂單日期:</label>
            <input type="text" class="form-control" id="orderDate" value="${order.orderDate}" disabled>
        </div>
        <div class="mb-3">
            <label for="totalAmount" class="form-label">訂單金額:</label>
            <input type="text" class="form-control" id="totalAmount" value="${order.totalAmount}" disabled>
        </div>
        <div class="mb-3">
            <label for="orderStatus" class="form-label">訂單狀態:</label>
            <input type="text" class="form-control" id="orderStatus" value="${order.orderStatus}" disabled>
        </div>
        <div class="mb-3">
            <label for="paymentMethod" class="form-label">付款方式:</label>
            <input type="text" class="form-control" id="paymentMethod" value="${order.paymentMethod}" disabled>
        </div>
        <div class="mb-3">
            <label for="shipmentStatus" class="form-label">出貨狀態:</label>
            <input type="text" class="form-control" id="shipmentStatus" value="${order.shipmentStatus}" disabled>
        </div>
        <div class="mb-3">
            <label for="shippingAddress" class="form-label">收貨地址:</label>
            <input type="text" class="form-control" id="shippingAddress" value="${order.shippingAddress}" disabled>
        </div>
        <div class="text-center">
            <a href="/order/all" class="btn btn-secondary">返回訂單列表</a>
        </div>
    </div>
</section>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
<script>
    fetch("/html/backtest.html")
        .then(response => {
            if (response.ok) {
                return response.text();
            }
        }).then(data => {
        document.querySelector('#heade').innerHTML = data;
    })
</script>
</body>
</html>
