<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>新增訂單</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/backtest.css	" rel="stylesheet">
</head>
<body>
   <div id="heade"></div>
     <section>
      
    <h2 class="text-center mb-4">新增訂單</h2>
    <form method="post" action="/order/create">
        <div class="mb-3">
            <label for="studentId" class="form-label">會員編號:</label>
            <input type="text" class="form-control" id="studentId" name="student_id" required>
        </div>
        <div class="mb-3">
            <label for="couponId" class="form-label">優惠券編號:</label>
            <input type="text" class="form-control" id="couponId" name="coupon_id" required>
        </div>
        <div class="mb-3">
            <label for="orderDate" class="form-label">訂單日期:</label>
            <input type="datetime-local" class="form-control" id="orderDate" name="order_date" required>
        </div>
        <div class="mb-3">
            <label for="totalAmount" class="form-label">總金額:</label>
            <input type="number" class="form-control" id="totalAmount" name="total_amount" required>
        </div>
        <div class="mb-3">
            <label for="orderStatus" class="form-label">訂單狀態:</label>
            <select class="form-control" id="orderStatus" name="order_status">
        <option value="">請選擇訂單狀態</option>
        <option value="支付成功">支付成功</option>
        <option value="支付失敗">支付失敗</option>
        </select>
        </div>
        <div class="mb-3">
    	<label for="paymentMethod" class="form-label">付款方式:</label>
    	<select class="form-control" id="paymentMethod" name="payment_method">
        <option value="">請選擇付款方式</option>
        <option value="綠界">綠界</option>
        <option value="藍新(智富通)">藍新(智富通)</option>
        <option value="LINE PAY">LINE PAY</option>
        </select>
        <div class="mb-3">
    	<label for="shipmentDate" class="form-label">出貨日期:</label>
    	<input type="datetime-local" class="form-control" id="shipmentDate" name="shipment_date">
		</div>
        <div class="mb-3">
    	<label for="shipmentStatus" class="form-label">出貨狀態:</label>
    	<select class="form-control" id="shipmentStatus" name="shipment_status">
        <option value="">請選擇出貨狀態</option>
        <option value="已出貨">已出貨</option>
        <option value="處理運送中">處理運送中</option>
        <option value="未出貨">未出貨</option>
    	</select>
		</div>
        <div class="mb-3">
            <label for="shippingAddress" class="form-label">收貨地址:</label>
            <input type="text" class="form-control" id="shippingAddress" name="shipping_address" required>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">提交</button>
            <a href="/order/all" class="btn btn-secondary">返回訂單列表</a>
        </div>
    </form>
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
