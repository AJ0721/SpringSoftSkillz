<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>新增訂單</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        table {
            width: 60%; 
            margin: 20px auto; 
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #fcfcfc;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        input[type="text"], 
        input[type="datetime-local"], 
        input[type="submit"] {
            padding: 5px;
            margin: 0 2px;
            border: 1px solid #ccc;
            background-color: #fff;
        }
        input[type="submit"] {
            padding: 5px 10px;
            margin: 0 2px; 
            border: 1px solid #ccc;
            background-color: #fff;
        }
        .button-group {
            display: flex;
            justify-content: center;
            padding: 10px;
        }
        .button-group a {
           padding: 5px 10px;
    		margin: 0 2px;
    		border: 1px solid #ccc;
    		background-color: #fff;
    		cursor: pointer;

        }
    </style>
</head>
<body>
 <form id="orderForm" method="post" action="${pageContext.request.contextPath}/order/add">
        <table>
            <thead>
                <tr>
                    <th>學生編號</th>
                    <th>訂單日期</th>
                    <th>總金額</th>
                    <th>訂單狀態</th>
                    <th>收貨地址</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="text" required name="student_id"></td>
                    <td><input type="datetime-local" name="order_date" required></td>
                    <td><input type="text" name="total_amount"></td>
                    <td><input type="text" name="order_status"></td>
                    <td><input type="text" name="shipping_address"></td>
                </tr>
            </tbody>
        </table>
        <div class="button-group">
            <input type="submit" value="提交" />
        </div>
        <div class="button-group">
    <a href="${pageContext.request.contextPath}/showOrder/getOrder" class="button">返回訂單管理</a>
</div>

   
    </form>
<script>
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('orderForm').addEventListener('submit', function(e) {
        var orderDateInput = document.querySelector('[name="order_date"]');
        var shipmentDateInput = document.querySelector('[name="shipment_date"]'); // 假設您也有一個關於發貨日期的輸入欄位
        
        function formatInputDate(input) {
            if (input && input.value) {
                var localDate = new Date(input.value);
                var offset = localDate.getTimezoneOffset() * 60000;
                var adjustedDate = new Date(localDate.getTime() - offset);
                input.value = adjustedDate.toISOString().slice(0, 16);
            }
        }

        formatInputDate(orderDateInput);
        formatInputDate(shipmentDateInput); // 格式化發貨日期，如果有的話
    });
});
</script>
</body>
</html>
