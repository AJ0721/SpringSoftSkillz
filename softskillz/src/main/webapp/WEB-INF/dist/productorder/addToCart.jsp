<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加到購物車</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    function addToCart() {
        var productId = document.getElementById('productId').value;
        var quantity = document.getElementById('quantity').value;
        $.ajax({
            url: '${pageContext.request.contextPath}/productcart/add', // 确保这个路径是正确的
            type: 'POST',
            data: { productId: productId, quantity: quantity },
            success: function(response) {
                alert('產品已加入購物車');
            },
            error: function(xhr) {
                // 使用服务器的响应信息进行更精确的错误反馈
                var errorMsg = '加入購物車失敗';
                if(xhr.responseJSON && xhr.responseJSON.message) {
                    errorMsg += ': ' + xhr.responseJSON.message;
                }
                alert(errorMsg);
            }
        });
    }
    </script>
</head>
<body>
<form action="/productcart/add" method="POST">
    <input type="hidden" name="productId" value="1">
    <input type="number" name="quantity" min="1" value="1">
    <button type="submit">添加到購物車</button>
</form>
<script>
function addToCart(productId, quantity) {
    $.ajax({
        url: '/productcart/add',  
        type: 'POST',  
        data: {
            productId: productId,
            quantity: quantity
        },
        success: function(response) {
            console.log('添加成功');
        },
        error: function(xhr) {
            console.error('添加失败: ', xhr.responseText);
        }
    });
}
</script>

</body>
</html>
