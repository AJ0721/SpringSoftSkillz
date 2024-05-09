<%@page import ="java.util.Map"%>
<%@page import ="com.softskillz.productorder.model.ProductCartItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的購物車</title>
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
    Map<Integer, ProductCartItem> map = (Map<Integer, ProductCartItem>)session.getAttribute("cart");
    double total = 0;
    for (Map.Entry<Integer, ProductCartItem> entry : map.entrySet()) {
        double subtotal = entry.getValue().getProduct().getProductPrice() * entry.getValue().getQuantity();
        total += subtotal;
    %>
    <tr align="center">
        <td><%=entry.getKey()%></td>
        <td><%=entry.getValue().getProduct().getProductName()%></td>
        <td><%=entry.getValue().getProduct().getProductPrice()%></td>
        <td><%=entry.getValue().getQuantity()%></td>
        <td><%=subtotal%></td>
    </tr>
    <%} %>
    <tr>
        <td colspan="4" align="right">總計</td>
        <td><%=total%></td>
    </tr>
</table>
<div style="text-align:center;font-size:36px;">
    <a href="productList.jsp">繼續購物</a>
</div>
</body>
</html>
