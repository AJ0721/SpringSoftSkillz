<%@page import ="java.util.List"%>
<%@page import ="com.softskillz.mall.service.ProductService"%>
<%@page import ="com.softskillz.mall.model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商品列表</title>
</head>
<body>
    <div style="text-align: right;font-size:36px;">
        <a href="cartPage.jsp">我的購物車</a>
    </div>
    <table align="center" width="100%">
        <tr>
            <th>產品編號</th>
            <th>產品名稱</th>
            <th>價格</th>
            <th>庫存</th>
            <th>類別</th>
            <th>描述</th>
        </tr>
        <c:forEach var="product" items="${products}">
            <tr align="center">
                <td>${product.productId}</td>
                <td>${product.productName}</td>
                <td>${product.productPrice}</td>
                <td>${product.stock}</td>
                <td>${product.category}</td>
                <td>${product.description}</td>
                <td>
                    <button onclick="addToCart(${product.productId}, 1)">添加到購物車</button>
                </td>
            </tr>
        </c:forEach>
    </table>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    function addToCart(productId, quantity) {
        $.ajax({
            url: '${pageContext.request.contextPath}/productcart/add',
            type: 'POST',
            data: { productId: productId, quantity: quantity },
            success: function(response) {
                alert('產品已加入購物車');
            },
            error: function() {
                alert('加入購物車失敗');
            }
        });
    }
    </script>
</body>
</html>
