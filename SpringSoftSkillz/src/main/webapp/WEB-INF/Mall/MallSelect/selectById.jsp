<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.softskillz.mall.model.ProductBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品資料</title>
    <style>
        #img {
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
    <jsp:useBean id="product" scope="request" class="com.softskillz.mall.model.ProductBean"/>
    <table>
        <tr>
            <td>商品編號
            <td><input type="text" disabled value="<%= product.getProductId() %>">
        <tr>
            <td>商品分類編號
            <td><input type="text" disabled value="<%= product.getProductCategoryId() %>">
        <tr>
            <td>商品名稱
            <td><input type="text" disabled value="<%= product.getProductName() %>">
        <tr>
            <td>商品描述
            <td><input type="text" disabled value="<%= product.getProductDescription() %>">
        <tr>
            <td>商品價格
            <td><input type="text" disabled value="<%= product.getProductPrice() %>">
        <tr>
        <tr>
            <td>商品庫存
            <td><input type="text" disabled value="<%= product.getProductStock() %>">
        <tr>
            <td>商品圖片
            <td><img id="img" src="<%= product.getProductImageUrl()%>" alt="沒有圖片">
        <tr>
            <td>目標受眾
            <td><input type="text" disabled value="<%= product.getProductTargetAudience() %>">
        <tr>
            <td>商品創建日期
            <td><input class="create_date" type="text" disabled value="<%= outputFormat.format(inputFormat.parse(product.getProductCreateDate()))%>">
        <tr>
        <tr>
            <td>商品更新日期
            <td><input class="update_date" type="text" disabled value="<%= outputFormat.format(inputFormat.parse(product.getProductUpdateDate()))%>">
        <tr>

    </table>
    <div style="visibility: hidden;">空白</div>
    <div>
        <button class="index">回首頁</button>
    </div>
</div>

<script>
    const index = document.querySelector('.index')
    index.addEventListener('click', function () {
        location.href = "mall.do"
    })
</script>

</body>
</html>