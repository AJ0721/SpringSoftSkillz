<%@page import="com.softskillz.mall.model.Product"%>
<%@page import="com.softskillz.mall.service.ProductService"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <title>商品詳細資訊</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    String id = request.getParameter("id");
    ProductService productService = new ProductService(); 
    Product product = productService.getProductById(Integer.parseInt(id));

    if (product == null) {
        out.println("<h2>找不到該商品</h2>");
    } else {
%>
<div style="text-align:right;font-size:36px;">
    <a href="cart.jsp">我的購物車</a>
</div>
<table align="center" width="100%">
    <tr>
        <th>商品編號</th>
        <th>商品名稱</th>
        <th>商品價格</th>
    </tr>
    <tr align="center">
        <td><%=product.getProductId()%></td>
        <td><%=product.getProductName()%></td>
        <td><%=product.getProductPrice()%></td>
    </tr>
</table>
<%
    }
%>
<div style="text-align:center;font-size:36px;">
    <a href="product_list.jsp">返回商品列表</a>
</div>
</body>
</html>
