<%@page import="com.softskillz.mall.model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>產品詳細資料</title>
</head>
<body>
<%-- 確保這個頁面能夠通過Model獲取產品資訊 --%>
<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        out.println("找不到指定的產品");
    } else {
        out.println("<h1>" + product.getProductName() + "</h1>");
        out.println("<p>描述: " + product.getProductDescription() + "</p>");
        out.println("<p>價格: " + product.getProductPrice() + "</p>");
        // 如果有圖片，可以這樣顯示
        out.println("<img src='" + product.getProductImageUrl() + "' alt='Product Image' style='width:100px;'>");
    }
%>
</body>
</html>
