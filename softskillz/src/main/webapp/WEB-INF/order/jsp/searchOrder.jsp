<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單搜尋</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="/css/backtest.css	" rel="stylesheet">
</head>
<body>
  <div id="heade"></div>
    <section>
    <h2 class="text-center mb-4">訂單管理</h2>
    <form method="get" action="${pageContext.request.contextPath}/order/search" class="mb-4">
        <div class="mb-3">
            <label for="orderId" class="form-label">請輸入訂單編號進行搜尋:</label>
            <input type="text" class="form-control" id="orderId" name="orderId" required>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">搜尋單筆訂單</button>
        </div>
    </form>
    <div class="text-center mb-3">
        <a href="/order/all" class="btn btn-secondary">搜尋全部訂單</a>
    </div>
    <div class="text-center">
        <a href="/order/create" class="btn btn-success">新增訂單</a>
    </div>
</div>
 </section>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
<script>
fetch("/html/backtest.html")
.then(response => {
if (response.ok) {
   return response.text();
}
}).then(data => {
document.querySelector('#heade').innerHTML = data;
})
</script>
</body>
</html>
