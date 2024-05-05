<%@page import="java.util.List"%>
<%@page import="com.softskillz.mall.service.ProductService"%>
<%@page import="com.softskillz.mall.model.Product"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <title>商品列表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    ProductService productService = new ProductService(); 
    List<Product> list = productService.getAllProducts();
%>
<div style="text-align:right;font-size:36px;">
    <a href="cart.jsp">購物車</a>
</div>
<table align="center" width="100%">
    <tr>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>商品價格</th>
    </tr>
    <%
        for(Product p : list){
    %>
    <tr align="center">
        <td><%=p.getProductId()%></td>
        <td><a href="product_detail.jsp?id=<%=p.getProductId()%>"><%=p.getProductName()%></a></td>
        <td><%=p.getProductPrice()%></td>
    </tr>
    <%} %>
</table>
</body>
</html>
