<%@ page import="java.util.Map, com.softskillz.productorder.model.ProductCartItem, java.util.List, com.softskillz.mall.model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>我的購物車</title>
    <link rel="stylesheet" href="/path/to/your/common/styles.css" />
</head>
<body>


<table width="100%" align="center" border="1px">
    <tr>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>單價</th>
        <th>數量</th>
        <th>小計</th>
    </tr>
    <%
    Map<Integer, ProductCartItem> cart = (Map<Integer, ProductCartItem>)session.getAttribute("cart");
    if (cart != null && !cart.isEmpty()) {
        double total = 0;
        for (ProductCartItem item : cart.values()) {
            double subtotal = item.getProduct().getProductPrice().doubleValue() * item.getQuantity();
            total += subtotal;
    %>
    <tr align="center">
        <td><%= item.getProduct().getProductId() %></td>
        <td><%= item.getProduct().getProductName() %></td>
        <td><%= item.getProduct().getProductPrice() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= subtotal %></td>
    </tr>
    <%  }
    %>
    <tr>
        <td colspan="4" align="right">總計</td>
        <td><%= total %></td>
    </tr>
    <% } else { %>
    <tr>
        <td colspan="5" align="center">您的購物車是空的</td>
    </tr>
    <% } %>
</table>
<div style="text-align:center;font-size:24px;">
    <a href="/productList.jsp">繼續購物</a>
</div>
</body>
</html>
