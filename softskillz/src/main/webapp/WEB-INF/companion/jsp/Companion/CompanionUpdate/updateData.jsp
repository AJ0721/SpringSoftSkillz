<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>學伴資料</title>
<style>
#img {
	width: 170px;
	height: auto;
}

button {
	padding: 8px 20px;
	/* 按鈕內邊距 */
	margin: 10px;
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
<%
SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
%>
<% SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");%>
<jsp:useBean id="companion" scope="request" class="com.softskillz.companion.model.CompanionBean" />
<jsp:useBean id="student" scope="request" class="com.softskillz.account.model.bean.StudentBean" />
<form action="${pageContext.request.contextPath}/Update" method="post">
<table>
<tr><td>學伴編號<td><input type="text" value="<%= companion.getCompanionId()%>" name="companion_id" readonly style="background-color: #FFF2F2">
<tr><td>學生會員編號<td><input type="text" value="<%= companion.getStudentBeanID().getStudentId() %>" name="student_id" readonly style="background-color: #FFF2F2">
<tr><td>暱稱<td><input type="text" value="<%= companion.getStudentBeanID().getStudentNickname() %>" name="companion_username" readonly style="background-color: #FFF2F2">
<%-- <tr><td>學伴性別<td><input type="text" value="<%= companion.getCompanionGender() %>" name="companion_gender"> --%>
<%-- <tr><td>學伴生日<td><input type="text" value="<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth())) %>" name="companion_birth"> --%>
<tr><td>母語<td><input type="text" value="<%= companion.getCompanionFirstLanguage() %>" name="companion_first_language">
<tr><td>其他會說語言<td><input type="text" value="<%= companion.getCompanionSpeakingLanguage() %>" name="companion_speaking_language">
<tr><td>學習興趣<td><input type="text" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest">
<tr><td>學習頻率<td><input type="text" value="<%= companion.getCompanionLearningFrequency() %>" name="companion_learning_frequency">
<tr><td>關於我<td><textarea name="companion_about_me" rows="3" style="resize: none;"><%= companion.getCompanionAboutMe() %></textarea>
<tr><td>照片<td><img id="img" src="${pageContext.request.contextPath}${companion.getStudentBeanID().getStudentPhoto()}" alt="Companion_Photo" name="companion_photo">
<input type="hidden" name="_method" value="PUT">
<input type="hidden" value="${companion.getStudentBeanID().getStudentPhoto()}" name="companion_photo">
<input type="hidden" value="${companion.getStudentBeanID()}" name="studentBeanID">

</table>
<button type="submit">送出</button>
</form>
<div><button class="index">回首頁</button></div>
		<script>
			const index = document.querySelector('.index')
			index.addEventListener('click', function() {
				location.href = "/companionIndex.html"
			})
		</script>
	</div>
</body>
</html>