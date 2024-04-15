<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品資料</title>
<style>
#img{
width: 170px;
height: auto;
}
</style>
</head>
<body style="background-color:#E6F8E0">
<div align="center">
<h2>商品資料</h2>
<% SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");%>
<% SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%>

<jsp:useBean id="product" scope="request" class="com.softskillz.mall.model.ProductBean" />
<form action="Updateproduct" method="post">

<table>
<tr><td>商品編號<td><input type="text" value="<%= product.getProductId() %>" name="product_id" readonly>
<tr><td>商品分類編號<td><input type="text" value="<%= product.getProductCategoryId() %>" name="product_category_id" readonly>
<tr><td>商品名稱<td><input type="text" value="<%= product.getProductName() %>" name="product_name" >
<tr><td>商品描述<td><input type="text" value="<%= product.getProductDescription() %>" name="product_description" >
<tr><td>商品價格<td><input type="text" value="<%= product.getProductPrice() %>" name="product_price" >
<tr><td>商品庫存<td><input type="text" value="<%= product.getProductStock() %>" name=" product_stock" >
<tr><td>商品圖片<td><img id="img" src="${product.productImageUrl}" alt="Product_Photo" name="product_photo">
    <input type="hidden" value="${product.productImageUrl}" name="product_photo">
<tr><td>目標受眾<td><input type="text" value="<%= product.getProductTargetAudience() %>" name="product_target_audience" >
<tr><td>商品創建日期<td><input type="text" value="<%= outputFormat.format(inputFormat.parse(product.getProductCreateDate())) %>" name="product_create_date" >
<tr><td>商品更新日期<td><input type="text" value="<%= outputFormat.format(inputFormat.parse(product.getProductUpdateDate())) %>" name="product_update_date" >
</table>

<input type="submit" value="送出" />
</form>
</div>
</body>
</html>