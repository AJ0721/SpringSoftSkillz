<%@page import="java.util.List"%>
<%@page import="com.softskillz.productorder.model.Order"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/css/backtest.css	" rel="stylesheet">

</head>
<style>
 .table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
    background-color: #ddd;
}
.button-group {
    margin-top: 20px;
    text-align: center;
}
.button-group a {
    margin: 0 10px;
}
</style>
<body>

   
    <div id="heade"></div>
      <section>
    
    <h2 class="text-center mb-4">訂單列表</h2>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>訂單編號</th>
        		<th>會員編號</th>
        		<th>優惠券編號</th>
        		<th>訂單日期</th>
        		<th>總金額</th>
        		<th>訂單狀態</th>
        		<th>付款方式</th>
        		<th>出貨日期</th>
        		<th>出貨狀態</th>
        		<th>收貨地址</th>
        		<th>操作</th>
            </tr>
        </thead>
        <tbody>
            <% 
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            List<Order> orders = (List<Order>)request.getAttribute("orders");
            for(Order currentOrder : orders) {
            %>
            <tr>
                <td><%= currentOrder.getOrder_id() %></td>
                <td><%= currentOrder.getStudent_id() %></td>                
                 <td>
            <% if (currentOrder.getCoupon_id() == null) { %>
            <% } else { %>
                <%= currentOrder.getCoupon_id() %>
            <% } %>
        </td>               
                <% if(currentOrder.getOrder_date() != null) { %>
                    <td><%= currentOrder.getOrder_date().format(formatter) %></td>
                <% } else { %>
                    <td>未設定</td>
                <% } %>             
                <td><%= currentOrder.getTotal_amount() %></td>
                <td><%= currentOrder.getOrder_status() %></td>
                <td><%= currentOrder.getPayment_method() %></td>
                <td><%= currentOrder.getShipment_date() != null ? currentOrder.getShipment_date().format(formatter) : "未出貨" %></td>
                <td><%= currentOrder.getShipment_status() != null ? currentOrder.getShipment_status() : "未出貨" %></td>
                <td><%= currentOrder.getShipping_address() %></td>
                <td>
                    <form method="get" action="/order/searchforupdate/<%= currentOrder.getOrder_id() %>">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-pencil-square"></i> 
                        </button>
                    </form>

                    <form method="post" action="/order/delete/<%= currentOrder.getOrder_id() %>" onsubmit="return confirm('您確定要刪除這個訂單嗎?');">
                        <input type="hidden" name="_method" value="delete" />
                        <button type="submit" class="btn btn-danger"><i class="bi bi-trash3"></i></button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <div class="button-group">
        <a href="/order/create" class="btn btn-success">新增訂單</a>
        <a href="/order" class="btn btn-secondary">返回訂單管理</a>
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
