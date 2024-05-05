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
    <form method="get" action="/order/search" class="mb-4">
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
 </section>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
<script>
//当表单提交时
// document.querySelector('form').addEventListener('submit', function(event) {
//     event.preventDefault(); // 阻止表单的默认提交行为

//     // 获取输入的訂單編號
//     const orderId = document.getElementById('orderId').value;

//     // 发起搜索请求
//     fetch("/order/search?orderId=" + orderId)
//     .then(response => {
//     	return response.json();
//     })
//     .then(data => {
//     	c
//         if (data && data.order) {
//             // 如果找到了訂單，处理显示逻辑
//         } else {
//             // 如果没有找到訂單，显示提示信息
//             alert('找不到訂單');
//         }
//     }).catch(error => {
//         // 处理错误情况
//         alert('搜索请求失败');
//     });
// });

</script>
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
