<%@page import="java.util.List"%>
<%@page import="com.softskillz.order.model.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>訂單詳情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }
        table, th, td {
            border: 1px solid #ddd;
            border-collapse: collapse;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f0f0f0;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .button-group {
            margin: 20px 0;
            text-align: center;
        }
        .button-group form {
            display: inline;
            margin: 0 10px;
        }
        .button-group input[type="submit"] {
            padding: 5px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .button-group input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div align="center">
        <h2>訂單詳情</h2>
        <table>
            <tr>
                <th>訂單編號</th>
                <th>會員編號</th>
                <th>訂單日期</th>
                <th>總金額</th>
                <th>訂單狀態</th>
                <th>收貨地址</th>
                <th>操作</th>
            </tr>
            <% 
            List<OrderBean> orders = (List<OrderBean>)request.getAttribute("orders");
            for(OrderBean order : orders) {
            %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getStudentId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.getTotalAmount() %></td>
                    <td><%= order.getOrderStatus() %></td>
                    <td><%= order.getShippingAddress() %></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/updateOrder1/update" method="post">
                            <input type="hidden" name="order_id" value="<%= order.getOrderId() %>"/>
                            <input type="submit" value="修改"/>
                        </form>
                        <form action="${pageContext.request.contextPath}/deleteOrder/delete" method="post">
                            <input type="hidden" name="order_id" value="<%= order.getOrderId() %>"/>
                            <input type="submit" value="刪除"/>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    </div>
    <div class="button-group">
        <a href="${pageContext.request.contextPath}/showOrder/getOrder">返回訂單管理</a>
    </div>
</body>
</html>
