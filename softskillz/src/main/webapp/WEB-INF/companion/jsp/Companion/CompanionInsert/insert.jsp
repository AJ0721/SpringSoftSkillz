<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
	<h2>新增學伴資料</h2>
	<form method="post" action="${pageContext.request.contextPath}/Insert">
		<table border="1">
		<tr style="background-color:#a8fefa">
		<th>欄位<th>資料
<!-- 			<tr> -->
<!-- 				<td>輸入學伴編號 :</td> -->
<!-- 				<td><input type="text" name="companion_id" /></td> -->
			<tr>
				<td>輸入學生會員編號 :</td>
				<td><input type="text" name="student_id" /></td>
			<tr>
				<td>輸入學伴帳號名稱 :</td>
				<td><input type="text" name="companion_username" /></td>
			<tr>
				<td>輸入學伴性別 :</td>
				<td><input type="text" name="companion_gender" /></td>
			<tr>
				<td>輸入學伴生日 :</td>
				<td><input type="text" name="companion_birth" /></td>
			<tr>
				<td>輸入學伴母語 :</td>
				<td><input type="text" name="companion_first_language" /></td>
			<tr>
				<td>輸入學伴會說語言 :</td>
				<td><input type="text" name="companion_speaking_language" /></td>
			<tr>
				<td>輸入學伴學習興趣 :</td>
				<td><input type="text" name="companion_learning_interest" /></td>
			<tr>
				<td>輸入學伴學習頻率 :</td>
				<td><input type="text" name="companion_learning_frequency" />
				<input type="hidden" name="companion_photo" value="/Companion/CompanionImg/Default.jpg" />
				</td>
				
<!-- 			<tr> -->
<!-- 				<td>輸入學伴照片 :</td> -->
<!-- 				<td><input type="hidden" name="companion_photo"/></td> -->
				
		</table>
		<input class="ok" type="submit" value="確定" />
	</form>
	<div><button class="index">回首頁</button></div>
	</div>
	<script>
	const index = document.querySelector('.index')
	index.addEventListener('click', function() {
	location.href = "/index.html"
	})
</script>
</body>
</html>
