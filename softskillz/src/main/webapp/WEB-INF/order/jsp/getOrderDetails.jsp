<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>查詢結果</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	 <link href="/css/backtest.css	" rel="stylesheet">
</head>
<body>
<div id="heade"></div>
      <section>
<div class="container mt-5">
    <jsp:useBean id="order" scope="request" class="com.softskillz.productorder.model.Order" />
    <h2 class="text-center mb-4">訂單詳情</h2>
    <div class="mb-3">
        <label for="orderId" class="form-label">訂單編號:</label>
        <input type="text" class="form-control" id="orderId" value="<%= order.getOrder_id() %>" disabled>
    </div>
    <div class="mb-3">
        <label for="studentId" class="form-label">學生編號:</label>
        <input type="text" class="form-control" id="studentId" value="<%= order.getStudent_id() %>" disabled>
    </div>
    <div class="mb-3">
        <label for="orderDate" class="form-label">訂單時間:</label>
        <input type="text" class="form-control" id="orderDate" value="<%= order.getOrder_date() %>" disabled>
    </div>
    <div class="mb-3">
        <label for="totalAmount" class="form-label">訂單金額:</label>
        <input type="text" class="form-control" id="totalAmount" value="<%= order.getTotal_amount() %>" disabled>
    </div>
    <div class="mb-3">
        <label for="orderStatus" class="form-label">訂單狀態:</label>
        <input type="text" class="form-control" id="orderStatus" value="<%= order.getOrder_status() %>" disabled>
    </div>
    <div class="mb-3">
        <label for="shippingAddress" class="form-label">收貨地址:</label>
        <input type="text" class="form-control" id="shippingAddress" value="<%= order.getShipping_address() %>" disabled>
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
