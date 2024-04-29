<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>
<style>
div{
	display: flex;
	align-items: center;
	justify-content: center;
}
button {
	padding: 8px 20px;
	/* 按鈕內邊距 */
 	margin-left: 0px;
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
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>學伴資料</h2>
<%-- <jsp:useBean id="companion" scope="request" class="com.project2.bean.CompanionBean" /> --%>

</div>
<div>配對成功</div>
<div style="visibility:hidden;">空白</div>
<div><button class="index">回首頁</button></div>
<div style="visibility:hidden;">空白</div>
<div>
<!-- <form method="post" action="../../SelectMatchByNameDemo"> -->
<!-- 請輸入你的學生編號：<input type="text" name="studentA" /> -->
<!-- <button class="selectMatch">查詢學伴配對</button> -->
<!-- </form> -->
</div>

</body>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/index.html"})
</script>
</html>