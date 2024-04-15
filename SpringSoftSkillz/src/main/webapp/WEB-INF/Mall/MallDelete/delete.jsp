<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品資料</title>
</head>
<body style="background-color:#E6F8E0">
<div align="center">
    <h2>學伴資料</h2>
    <jsp:useBean id="product" scope="request" class="com.softskillz.mall.model.ProductBean"/>
    <p>刪除成功</p>
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
