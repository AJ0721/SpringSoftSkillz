<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單管理</title>
 <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }
        .button-group {
            display: flex;
            justify-content: center;
            align-items: center; 
            padding: 10px;
            background: #f2f2f2;
            border-bottom: 1px solid #ddd;
        }
        .button-group form,
        .search-group {
            display: flex;
            justify-content: center;
            align-items: center; 
            margin: 0 2px;
        }
        .button-group input[type="submit"], 
        .button-group input[type="text"] {
            padding: 5px 10px;
            margin: 0 2px; 
            border: 1px solid #ccc;
            background-color: #fff;
            cursor: pointer;
        }
        .footer {
            text-align: center;
            padding: 20px;
            background: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="button-group">
        <!-- 查询、多笔查询 -->
        <div class="search-group">
            <form action="${pageContext.request.contextPath}/showOrder/selectOrder" method="post" id="GetOrder" >
                <input type="text" name="order_id" placeholder="輸入訂單編號" required/>
                <input type="submit" value="查詢"/>
            </form>
             <form action="${pageContext.request.contextPath}/showAllOrder/selectAllOrder" method="get" id="GetOrderAll">
            <input type="submit" value="查詢全部"/>
        </form>
        </div>
    <div class="button-group">
        <!-- 新增、修改、删除 -->
        <form action="${pageContext.request.contextPath}/order/insert" method="post">
            <input type="submit" value="新增"/>
        </form>
        <form action="${pageContext.request.contextPath}/updateOrder1/update" method="post">
            <input type="submit" value="修改"/>
        </form>
        <form action="${pageContext.request.contextPath}/deleteOrder/delete" method="post" id="DeleteOrderID">
            <input type="text" name="order_id" placeholder="輸入訂單編號" required/>
            <input type="submit" value="删除"/>
        </form>
    </div>
    
    		<div><a href="../softskillz.homepage">回到後台首頁</a></div>
    
</body>
</html>
