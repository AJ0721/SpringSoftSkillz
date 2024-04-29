<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/courseorder/css/backtest.css">
</head>
<style>
td img {
	width: 100%;
	height: auto;
	max-width: 100px;
}

table {
	width: 90%; /* 根据需要调整 */
	margin: auto; /* 居中表格 */
	border-collapse: collapse;
	margin-top: 20px;
	background-color: #425169; /* 与侧边栏接近的颜色 */
	color: #fff; /* 文本颜色 */
}

/* 表头样式 */
th {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	background-color: #34495e; /* 与侧边栏接近的颜色 */
	color: #fff; /* 文本颜色 */
	text-align: center;
}

/* 单元格样式 */
td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: center;
	background-color: #fff; /* 白色背景 */
	color: #425169; /* 与侧边栏接近的颜色 */
}

/* 偶数行样式 */
tbody tr:nth-child(even) {
	background-color: #425169; /* 与侧边栏接近的颜色 */
	color: #fff; /* 文本颜色 */
}

/* 鼠标悬停效果 */
tbody tr:hover {
	background-color: #34495e; /* 与侧边栏接近的颜色 */
	color: #fff; /* 文本颜色 */
}

.custom-button {
	background-color: #3498db;
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 4px;
}

.custom-button:hover {
	background-color: #2980b9;
}
</style>
<body>


	<div id="header"></div>
	<div class="content">
		<div class="result">
			<section>
				<div class="date-selector">

					<button onclick="goBack()" class="custom-button">返回</button>
				</div>
				<div class="content">
					<div class="container">
						<table align="center" style="width: 100%;">
							<thead>
								<tr>
									<th>訂單編號</th>
									<th>教師名稱</th>
									<th>課程名稱</th>
									<th>課程類別</th>
									<th>課程單家</th>
									<th>購買堂數</th>
									<th>小記</th>
									<th>使用狀態</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="items" items="${items}">
									<tr>
										<td>${items.orderID}</td>
										<td>${items.teacherName }</td>
										<td>${items.courseName}</td>
										<td>${items.courseCategory}</td>
										<td class="price">${items.coursePrice}</td>
										<td class="qty">${items.qty}</td>
										<td>${items.coursePrice*items.qty}</td>
										<td>${items.status}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>
		</div>
	</div>
	<script>
    fetch("/html/backtest.html")
    .then(response => {
        if (response.ok) {
            return response.text();
        }
    }).then(data => {
        console.log(data);
        document.querySelector("#header").innerHTML = data;
    })
    
    function goBack() {
	window.history.back();
}
	</script>
</body>
</html>
