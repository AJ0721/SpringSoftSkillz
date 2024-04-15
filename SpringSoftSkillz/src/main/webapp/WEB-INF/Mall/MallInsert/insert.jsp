<%@ page import="com.softskillz.mall.model.ProductCategoryBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>新增商品資料</title>
	<style>
		body {
			font-family: 'Arial', sans-serif;
			background-color: #E6F8E0;
			margin: 0;
			padding: 20px;
		}

		.form-container {
			background-color: #fff;
			padding: 20px;
			border-radius: 8px;
			box-shadow: 0 4px 8px rgba(0,0,0,0.1);
			max-width: 500px;
			margin: 20px auto;
		}

		h2 {
			color: #333;
		}

		label {
			display: block;
			margin: 10px 0 5px;
		}

		input[type="text"], input[type="file"], button, .ok {
			width: calc(100% - 16px); /* Adjust width to ensure padding is included */
			padding: 8px;
			margin: 5px 0 20px;
			border-radius: 4px;
			border: 1px solid #ccc;
			box-sizing: border-box;
		}

		.ok, .back-button {
			background-color: #007bff;
			color: white;
			border: none;
			cursor: pointer;
			display: inline-block; /* Make buttons inline */
			width: auto; /* Auto width based on text content */
			padding: 8px 20px; /* Consistent padding */
		}

		.ok:hover, .back-button:hover {
			background-color: #0056b3;
		}

		.back-button {
			background-color: #dc3545;
		}

		.back-button:hover {
			background-color: #c82333;
		}

		.button-container {
			text-align: center;
			margin-bottom: 20px;
		}
	</style>
</head>
<body>
<div class="form-container" align="center">
	<h2>新增商品資料</h2>
	<form method="post" action="InsertProduct">

<%--		<label for="product_category">請選擇商品分類 :</label>--%>
<%--		<select name="product_category" id="product_category">--%>
<%--			<option value="教材影片">教材影片</option>--%>
<%--			<option value="實體教材">實體教材</option>--%>
<%--			<option value="周邊商品">周邊商品</option>--%>
<%--		</select>--%>

<%--	<label for="product_category">請選擇商品分類 :</label>--%>
<%--	<select name="product_category" id="product_category">--%>
<%--		<c:forEach items="${categories}" var="category">--%>
<%--			<option value="${category.productCategoryId}">${category.productCategoryName}</option>--%>
<%--		</c:forEach>--%>
<%--	</select>--%>


		<label>輸入商品名稱 :</label>
		<input type="text" name="product_name"/>

		<label>輸入商品描述 :</label>
		<input type="text" name="product_description" />

		<label>輸入商品價格 :</label>
		<input type="text" name="product_price" />

		<label>輸入商品庫存 :</label>
		<input type="text" name="product_stock" />

<%--		<label for="product_image">插入商品圖片 :</label>--%>
<%--		<input type="file" name="product_image" id="product_image" />--%>

		<label>輸入目標受眾 :</label>
		<input type="text" name="product_target_audience"/>

		<label >輸入商品創建日期 :</label>
		<input type="text" name="product_create_date" />

		<label>輸入商品更新日期 :</label>
		<input type="text" name="product_update_date"  />

		<div class="button-container">
			<input class="ok" type="submit" value="確定" />
		</div>
	</form>
	<button class="back-button" onclick="location.href='/SpringSoftSkillz/Mall/MallIndex/index.jsp'">回首頁</button>
</div>
<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
		location.href = "Mall/MallIndex/index.jsp"
	})
</script>
</body>
</html>
