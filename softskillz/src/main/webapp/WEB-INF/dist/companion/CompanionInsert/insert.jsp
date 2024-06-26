<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.softskillz.companion.model.CompanionBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert Companion data</title>
<style>
/* .index{ */
/* margin:10px */
/* } */
.ok{
margin:10px
}
							#img {
								width: 160px;
								height: auto;
							}

							tr {
								text-align: center;
							}

							button {
								padding: 8px 20px;
								/* 按鈕內邊距 */
/* 								margin: 10px; */
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

							.right {
								display: flex;
								align-items: center;
								/* 	justify-content: flex-end; */
								margin-left: 1190px;
							}
							
							.add{
							margin: 10px;
							}
							/* 表格整體風格 */
table {
  width: 100%;
  border-collapse: collapse;
  box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.2);
}

/* 表格標題樣式 */
th {
  background-color: #FFDEDE; /* 背景顏色 */
  color: #333; /* 文字顏色 */
  font-weight: bold; /* 加粗 */
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 表格內容樣式 */
td {
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 奇數行背景色 */
tr:nth-child(odd) {
  background-color: #FFF2F2;
}

/* 鼠標懸停時的背景色 */
tr:hover {
  background-color: #D2E9FF;
}
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
	<h2>新增學伴資料</h2>
	<form method="post" action="${pageContext.request.contextPath}/Insert">
	<input type="hidden" name="_method" value="PUT">
		<table border="1">
		<tr style="background-color:#a8fefa">
		<th>欄位<th>資料
<!-- 			<tr> -->
<!-- 				<td>輸入學伴編號 :</td> -->
<!-- 				<td><input type="text" name="companion_id" /></td> -->
			<tr>
				<td>輸入學生會員編號 :</td>
				<td><input type="text" name="student_id" /></td>
<!-- 			<tr> -->
<!-- 				<td>輸入學伴帳號名稱 :</td> -->
<!-- 				<td><input type="text" name="companion_username" /></td> -->
<!-- 			<tr> -->
<!-- 				<td>輸入學伴性別 :</td> -->
<!-- 				<td><input type="text" name="companion_gender" /></td> -->
<!-- 			<tr> -->
<!-- 				<td>輸入學伴生日 :</td> -->
<!-- 				<td><input type="text" name="companion_birth" /></td> -->
			<tr>
				<td>輸入母語 :</td>
				<td><input type="text" name="companion_first_language" /></td>
			<tr>
				<td>輸入其他會說語言 :</td>
				<td><input type="text" name="companion_speaking_language" /></td>
			<tr>
				<td>輸入學習興趣 :</td>
				<td><input type="text" name="companion_learning_interest" /></td>
			<tr>
				<td>輸入學習頻率 :</td>
				<td><input type="text" name="companion_learning_frequency" />
			<tr>
				<td>輸入關於我 :</td>
				<td><textarea name="companion_about_me" rows="3"></textarea>
			<tr>
				<td>照片 :</td>
				<td><img id="img" src="/Companion/CompanionImg/Default.jpg" alt="Companion_Photo" name="companion_photo">
				<input type="hidden" name="companion_photo" value="/Companion/CompanionImg/Default.jpg" />
				</td>
				
<!-- 			<tr> -->
<!-- 				<td>輸入學伴照片 :</td> -->
<!-- 				<td><input type="hidden" name="companion_photo"/></td> -->
				
		</table>
		<button class="add" type="submit">確定</button>
	</form>
	<div><button class="index">回首頁</button></div>
	</div>
	<script>
	const index = document.querySelector('.index')
    index.addEventListener('click', function () {
      location.href = "/companionIndex"
    })
</script>
</body>
</html>
