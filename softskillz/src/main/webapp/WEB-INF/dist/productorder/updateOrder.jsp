<%@page import="com.softskillz.productorder.model.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>更新訂單</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/backtest.css	" rel="stylesheet">
</head>
<body>
    <div id="heade"></div>
    <section>
   
    <h2 class="text-center mb-4">更新訂單</h2>
	<form method="post" action="/order/update" onsubmit="return validateForm()">
    <input type="hidden" name="_method" value="put">
        <div class="mb-3">
            <label for="id" class="form-label">訂單編號:</label>
            <input type="text" class="form-control" id="id" name="order_id" value="${order.order_id}" readonly>
        </div>
        <div class="mb-3">
            <label for="student" class="form-label">會員編號:</label>
            <input type="text" class="form-control" id="student" name="student_id" value="${order.student_id}"readonly>
        </div>
        <div class="mb-3">
            <label for="coupon" class="form-label">優惠券編號:</label>
            <input type="text" class="form-control" id="coupon" name="coupon_id" value="${order.coupon_id}"required>
        </div>
        <div class="mb-3">
            <label for="date" class="form-label">訂單日期:</label>
			<input type="datetime-local" class="form-control" id="date" name="order_date" value="${formattedorder_date}" required>
            <small id="dateError" class="text-danger"></small> 
        </div>
        <div class="mb-3">
            <label for="total" class="form-label">訂單金額:</label>
            <input type="text" class="form-control" id="total" name="total_amount" value="${order.total_amount}">
        </div>
        <div class="mb-3">
            <label for="orderStatus" class="form-label">訂單狀態:</label>
            <select class="form-control" id="orderStatus" name="order_status">
    <option value="">請選擇</option>
    <option value="支付成功" ${order.payment_method == '支付成功' ? 'selected':''}>支付成功</option>
    <option value="支付失敗" ${order.payment_method == '支付失敗' ? 'selected':''}>支付失敗</option>
	</select>
        </div>
        <div class="mb-3">
    <label for="paymentMethod" class="form-label">付款方式:</label>
   <select class="form-control" id="paymentMethod" name="payment_method">
    <option value="">請選擇</option>
    <option value="綠界" ${order.payment_method == '綠界' ? 'selected':''}>綠界</option>
    <option value="藍新(智富通)" ${order.payment_method == '藍新(智富通)' ? 'selected':''}>藍新(智富通)</option>
    <option value="LINE PAY" ${order.payment_method == 'LINE PAY' ? 'selected':''}>LINE PAY</option>
	</select>
	</div>
    <div class="mb-3">
        <label for="shipmentDate" class="form-label">出貨日期:</label>
        <input type="datetime-local" class="form-control" id="shipmentDate" name="shipment_date" value="${formatted_shipment_date}">
    </div>
        <div class="mb-3">
        <label for="shipmentStatus" class="form-label">出貨狀態:</label>
        <select class="form-control" id="shipmentStatus" name="shipment_status">
    <option value="">請選擇</option>
    <option value="已出貨" ${order.shipment_status == '已出貨' ? 'selected':''}>已出貨</option>
    <option value="處理運送中" ${order.shipment_status == '處理運送中' ? 'selected':''}>處理運送中</option>
    <option value="未出貨" ${order.shipment_status == '未出貨' ? 'selected':''}>未出貨</option>
	</select>
    </div>
    </form>
        <div class="mb-3">
            <label for="address" class="form-label">收貨地址:</label>
            <input type="text" class="form-control" id="address" name="shipping_address" value="${order.shipping_address}">
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">修改</button>
        </div>
</div>
  </section>
<script>
function validateForm() {
    var orderDate = document.getElementById("date").value;

    // 檢查日期是否為空
    if (!orderDate) {
        document.getElementById("dateError").innerText = "請選擇訂單日期";
        return false; // 阻止表單提交
    } else {
        document.getElementById("dateError").innerText = ""; // 清除錯誤消息
    }
    return true; // 表單驗證通過
}
</script>
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
