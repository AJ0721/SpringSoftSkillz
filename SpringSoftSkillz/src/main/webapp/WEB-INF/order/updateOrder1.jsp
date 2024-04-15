<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更新訂單</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background: #f2f2f2;
    }
    .form-container {
        display: flex;
        justify-content: center;
        padding: 20px;
    }
    form {
        background: #fff;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .input-group {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .input-group input[type="text"] {
        padding: 10px;
        width: 70%;
        margin-right: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .input-group input[type="submit"] {
        padding: 5px 10px;
        background-color: #FFFFFF;
        border: 1px solid #ccc;
        color: black;
        cursor: pointer;
    }
    .input-group input[type="submit"]:hover {
        background-color: #F0F0F0;
    }
    .button-group {
        display: flex;
        justify-content: center;
        padding: 10px;
    }
    .button-group a {
        padding: 5px 10px;
        margin: 0 2px;
        border: 1px solid #ccc;
        background-color: #fff;
        cursor: pointer;
    }
        
</style>
</head>
<body>
    <div class="form-container">
        <form action="${pageContext.request.contextPath}/updateOrder1/updated" method="post">
            <div class="input-group">
                <input type="text" name="order_id" placeholder="輸入訂單編號"/>
                <input type="submit" value="修改"/>
            </div>
        </form>
    </div>
    <div class="button-group">
       <a href="${pageContext.request.contextPath}/showOrder/getOrder">返回訂單管理</a>
    </div>
</body>
</html>
