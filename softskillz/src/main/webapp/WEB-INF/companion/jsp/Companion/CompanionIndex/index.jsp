<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學伴資料管理</title>
<style>
body {
	font-family: Arial, sans-serif;
	/* 設置字體 */
	margin: 0;
	/* 去除頁面邊距 */
	padding: 0;
	/* 去除頁面內邊距 */
	background-color: #f0f0f0;
	/* 設置背景顏色 */
}

.div {
	display: flex;
	align-items: center;
	justify-content: space-between;
	/* 水平置中對齊 */
	padding: 20px;
	/* 內邊距 */
	background-color: #fff;
	/* 背景顏色 */
	border-bottom: 2px solid #ccc;
	/* 底部邊框 */
}

.div h2 {
	margin: 0;
	font-size: 24px;
	flex-grow: 1;
	/* 讓 h2 佔據剩餘空間 */
}

.div div {
	display: flex;
	/* 將內部元素橫向排列 */
	align-items: center;
	/* 垂直置中對齊 */
}

.div .index {
	display: flex;
	align-items: center;
}

.div .index button {
	margin-left: auto;
	/* 將 button 推到右側 */
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
	/* 水平靠右對齊 */
	padding: 20px;
	/* 內邊距 */
	background-color: #fff;
	/* 背景顏色 */
	border-bottom: 2px solid #ccc;
	/* 底部邊框 */
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
	/* 去除標題的外邊距 */
	font-size: 24px;
	/* 設置標題字體大小 */
}

/*         form { */
/*             display: flex; */
/*             /* 表單內元素橫向排列 */
	/*         } */

        label {
	margin-right: 10px;
	/* 標籤與輸入框之間的間距 */
}

input[type="text"] {
	padding: 5px;
	/* 輸入框內邊距 */
	border: 1px solid #ccc;
	/* 輸入框邊框 */
}

button {
	padding: 8px 20px;
	/* 按鈕內邊距 */
	margin-left: 10px;
	/* 按鈕間距 */
	border: none;
	/* 去除按鈕邊框 */
	border-radius: 4px;
	/* 設置按鈕圓角 */
	background-color: #007bff;
	/* 按鈕背景顏色 */
	color: #fff;
	/* 按鈕文字顏色 */
	cursor: pointer;
	/* 滑鼠懸停樣式 */
}

button:hover {
	background-color: #0056b3;
	/* 滑鼠懸停時的背景顏色 */
}

.index {
	background-color: #dc3545;
	/* 回首頁按鈕的背景顏色 */
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

.index:hover {
	background-color: #c82333;
	/* 滑鼠懸停時的背景顏色 */
}
.container {
    display: flex;
}

/* .container form { */
/*     margin-right: 20px; */
/* } */

/* .container table { */
/*     margin-right: 20px; */
/* } */

/* .container button { */
/*     margin-top: 10px; */
/* } */
</style>
</head>

<body>
	<div class="div">
		<h2 id="title" style="visibility: hidden;">學伴資料管理</h2>
		<button class="index">回首頁</button>
	</div>

	<div class="div2">
		<div>
			<h2>學伴資料管理</h2>
		</div>
	</div>

	<div class="div">
		<div>
			<h2>資料查詢</h2>
		</div>
		<div class="id">
			<form method="post" action="${pageContext.request.contextPath}/GetCompanionById">
				<label for="">學伴id :</label>
				<input type="text" name="companion_id" />
				<!-- 					<input type="submit" value="查詢" /> -->
				<button type="submit">查詢</button>
				
			</form>
			<div style="visibility: hidden;">空白</div>
			<form method="post" action="${pageContext.request.contextPath}/GetCompanionByName">
				<label for="">學伴帳號名稱 :</label>
				<input type="text" name="companion_username">
				<button type="submit">查詢</button>
			</form>
		</div>
		<div>
			<form method="post" action="${pageContext.request.contextPath}/GetAllCompanions">
				<button class="selectAll" type="submit">查詢全部</button>
			</form>
		</div>
	</div>

	<div class="div">
		<div>
			<h2>學伴配對</h2>
		</div>
		<div class="container">
			<form method="post" action="${pageContext.request.contextPath}/GetCompanionByInterest">
				<div><label for="">請輸入你的帳號名稱 :</label><input type="text" name="companion_username" /></div>
				<label for="">請輸入你的學習興趣 :</label><input type="text" name="companion_learning_interest" />
				<button type="submit">查詢</button>
			</form>
			<div style="visibility: hidden">空白
		</div>
			<form method="post" action="${pageContext.request.contextPath}/GetCompanionMatchById">
				<label for="">請輸入學生編號:</label><input type="text" name="fk_student_a_id" />
				<button class="selectMatch">查詢學伴配對</button>
			</form>
		</div>
		<div>
		</div>
		<div style="display: flex;"></div>
	</div>

</body>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"

	const select = document.querySelector('.select')
	select.addEventListener('click', function() {
		location.href = "../CompanionInsert/insert.jsp"
	})

	const select2 = document.querySelector('.select2')
	select2.addEventListener('click', function() {
		location.href = "../CompanionInsert/insert.jsp"
	})
</script>

</html>