<%@page import="java.text.SimpleDateFormat" %>
<%@page import="com.softskillz.mall.model.ProductBean" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品資料</title>

    <style>
        body {
            background-color: #E6F8E0;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            text-align: center;
            padding: 8px;
        }

        th {
            background-color: #a8fefa;
        }

        #img {
            width: 160px;
            height: auto;
        }

        button {
            padding: 8px 20px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }


        .add {
            background-color: #007bff;
        }

        .add:hover {
            background-color: #0056b3;
        }


        .index {
            background-color: #dc3545;
            display: flex;
            align-items: center;
            justify-content: flex-end;
        }

        .index:hover {
            background-color: #c82333;
        }

        .add {
            position: relative;
            align-items: center;
            justify-content: center;
        }


        .update {
            background-color: #28a745;
        }

        .update:hover {
            background-color: #218838;
        }


        .delete {
            background-color: #dc3545;
        }

        .delete:hover {
            background-color: #c82333;
        }
    </style>

</head>

<body>
<div align="center">
    <h2>商品資料</h2>
    <div style="text-align: right; margin-right: 5%; margin-bottom: 20px;">
        <button class="add" id="add">新增商品</button>
    </div>
    <table border="1">
        <tr style="background-color:#a8fefa">

            <th>商品編號
            <th>商品分類編號
            <th>商品名稱
            <th>商品描述
            <th>商品價格
            <th>商品庫存
            <th>商品圖片
            <th>目標受眾
            <th>商品創建日期
            <th>商品更新日期
            <th>修改
            <th>刪除

                    <% List<ProductBean> products = (ArrayList<ProductBean>)request.getAttribute("products");
SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
for(ProductBean product: products){ %>
        <tr>
            <td><%= product.getProductId()%>
            <td><%= product.getProductCategoryId()%>
            <td><%= product.getProductName()%>
            <td><%= product.getProductDescription()%>
            <td><%= product.getProductPrice()%>
            <td><%= product.getProductStock()%>
            <td><img id="img" src="<%= product.getProductImageUrl()%>" alt="沒有圖片">
            <td><%= product.getProductTargetAudience()%>
            <td><%= outputFormat.format(inputFormat.parse(product.getProductCreateDate()))%>
            <td><%= outputFormat.format(inputFormat.parse(product.getProductUpdateDate()))%>

            <td>
                <form method="post" action="GetUpdateDataP">
                    <input type="hidden" value="<%= product.getProductId() %>" name="product_id">
                    <button class="update" type="submit">修改</button>
                </form>
            </td>
            <td>
                <form method="post" action="${pageContext.request.contextPath}/DeleteProductById">
                    <input type="hidden" value="<%= product.getProductId() %>" name="product_id">
                    <button class="delete" type="submit">刪除</button>
                </form>
                    <%} %>
    </table>
    <h3>共<%= products.size() %>筆商品資料</h3>
    <div>
        <button class="index">回首頁</button>
    </div>
</div>

<script>
    const index = document.querySelector('.index')
    index.addEventListener('click', function () {
        location.href = "mall.do"
    })
    const add = document.querySelector('#add')
    add.addEventListener('click', function () {
        location.href = "mall.insert."
    })
</script>

</body>
</html>