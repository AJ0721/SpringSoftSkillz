<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>商品資料管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .div {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            background-color: #fff;
            border-bottom: 2px solid #ccc;
        }

        .div h2 {
            margin: 0;
            font-size: 24px;
            flex-grow: 1;
        }

        .div div {
            display: flex;
            align-items: center;
        }

        .div .index {
            display: flex;
            align-items: center;
        }

        .div .index button {
            margin-left: auto;
            padding: 8px 20px;
            border: none;
            border-radius: 4px;
            color: #fff;
            cursor: pointer;
        }

        .div2 {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background-color: #fff;
            border-bottom: 2px solid #ccc;
        }

        .id {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        #title {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        h2 {
            margin: 0;
            font-size: 24px;
        }

        label {
            margin-right: 10px;
        }

        input[type="text"] {
            padding: 5px;
            border: 1px solid #ccc;
        }

        button {
            padding: 8px 20px;
            margin-left: 10px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: #fff;
            cursor: pointer;
        }

        button:hover {
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

        .container {
            display: flex;
        }

    </style>
</head>


<body>
<div class="div">
    <h2 id="title" style="visibility: hidden;">商品資料管理</h2>
    <button class="index">回首頁</button>
</div>

<div class="div2">
    <div>
        <h2>商品資料管理</h2>
    </div>
</div>

<div class="div">
    <div>
        <h2>資料查詢</h2>
    </div>
    <div class="id">

        <form method="post" action="${pageContext.request.contextPath}/GetProductById">
            <label for="">商品編號 :</label>
            <input type="text" name="product_id"/>
            <button type="submit">查詢</button>
        </form>

        <div style="visibility: hidden;">空白</div>

        <form method="post" action="${pageContext.request.contextPath}/GetProductByName">
            <label for="">商品名稱 :
            <input type="text" name="product_name">
            </label>
            <button type="submit">查詢</button>
        </form>

    </div>

    <div>
        <form method="post" action="${pageContext.request.contextPath}/GetAllProducts">
            <button class="selectAll" type="submit">查詢全部</button>
        </form>
    </div>
</div>
		<div><a href="softskillz.homepage">回到後台首頁</a></div>

<script>
    const index = document.querySelector('.index')
    index.addEventListener('click', function () {
        location.href = "mall.do"
    })

    const select = document.querySelector('.select')
    select.addEventListener('click', function () {
        location.href = "mall.insert"
    })

    const select2 = document.querySelector('.select2')
    select2.addEventListener('click', function () {
        location.href = "mall.insert"
    })
</script>

</body>
</html>