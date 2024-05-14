<%@page import ="com.softskillz.mall.model.Product"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>產品詳細資料的頁面</title>
</head>
<body>
<div style="text-align:right;font-size:36px;">
    <a href="cartPage.jsp">我的購物車</a>
</div>
<table align="center" cellpadding="20" cellspacing="20">
    <tr>
        <th>產品編號</th>
        <th>產品名稱</th>
        <th>價格</th>
        <th>庫存</th>
        <th>描述</th>
        <th>圖片</th>
    </tr>
    <%
        Product product = (Product) session.getAttribute("product");
        if (product != null) {
    %>
    <tr align="center">
        <td><%= product.getProductId() %></td>
        <td><%= product.getProductName() %></td>
        <td><%= product.getProductPrice() %></td>
        <td><%= product.getProductStock() %></td>
        <td><%= product.getProductDescription() %></td>
    </tr>
    <tr>
        <td colspan="3"></td>
        <td>
            <form action="productcart/add" method="post">
                <input type="hidden" name="productId" value="<%=product.getProductId()%>">
                <input type="number" name="quantity" value="1" min="1" style="width:50px;">
                <input type="submit" value="加入購物車">
            </form>
        </td>
        <td colspan="2"><a href="productList.jsp">返回產品列表</a></td>
    </tr>
    <%
        } else {
    %>
    <tr><td colspan="6">產品資料未找到。</td></tr>
    <%
        }
    %>
</table>
</body>
</html>
