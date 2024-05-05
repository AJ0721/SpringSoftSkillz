<%@page import="com.softskillz.account.model.bean.StudentBean"%>
<%@page import="java.text.SimpleDateFormat" %>
	<%@page import="com.softskillz.companion.model.CompanionBean" %>
		<%@page import="java.util.List" %>
			<%@page import="java.util.ArrayList" %>
				<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"
					%>
					<!DOCTYPE html>
					<html>

					<head>
						<meta charset="UTF-8">
						<title>學伴資料</title>

						<style>
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

							.right {
								display: flex;
								align-items: center;
								/* 	justify-content: flex-end; */
								margin-left: 1190px;
							}

							.add {
								background-color: #dc3545;
								/* 回首頁按鈕的背景顏色 */
								display: flex;
								align-items: center;
								justify-content: flex-end;
							}

							.add:hover {
								background-color: #c82333;
								/* 滑鼠懸停時的背景顏色 */
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

					<body style="background-color:#FFFAF2">
						<div align="center">
							<h2>學伴資料</h2>
							<div style="display: flex; justify-content: flex-end;">
							<form method="post" action="${pageContext.request.contextPath}/insertJSP">
							<button class="add" id="add" type="submit">新增</button>
							</form>
							</div>
							<div class="right">
								<div style="visibility: hidden">空白</div>
							</div>
							<table border="1">
								<tr style="background-color:#ffe4e1">
<!-- 									<th>學伴編號 -->
									<th>學生會員編號
									<th>暱稱
									<th>性別
<!-- 									<th>生日 -->
									<th>母語
									<th>其他會說的語言
									<th>學習興趣
									<th>學習頻率
									<th>關於我
									<th>照片
									<th>修改
									<th>刪除
										<% List<CompanionBean> companions = (ArrayList<CompanionBean>)request.getAttribute("companions");
												SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
												SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
												for(CompanionBean companion: companions){ 
												%>
								<tr>
<!-- 									<td> -->
<%-- 										<%= companion.getCompanionId()%> --%>
									<td>
										<%= companion.getStudentBeanID().getStudentId()%>
									<td>
										<%= companion.getStudentBeanID().getStudentNickname()%>
									<td>
										<%= companion.getStudentBeanID().getStudentGender()%>
<!-- 									<td> -->
<%-- 										<%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%> --%>
											<%-- <td>
												<%= companion.getCompanionBirth()%> --%>
									<td>
										<%= companion.getCompanionFirstLanguage()%>
									<td>
										<%= companion.getCompanionSpeakingLanguage()%>
									<td>
										<%= companion.getCompanionLearningInterest()%>
									<td>
										<%= companion.getCompanionLearningFrequency()%>
									<td>
										<%= companion.getCompanionAboutMe()%>
 									<td>
										<img id="img" src="<%=request.getContextPath()%>
										<%=companion.getStudentBeanID().getStudentPhoto()%>" alt=photo>
									<td>
										<form method="get" action="${pageContext.request.contextPath}/GetUpdateData">
											<input type="hidden" value="<%= companion.getCompanionId() %>"
												name="companion_id">
											<button class="update" type="submit">修改</button>
										</form>
									</td>
									<td>
										<form method="post"
											action="${pageContext.request.contextPath}/DeleteCompanionById">
											<input type="hidden" name="_method" value="DELETE">
											<input type="hidden" value="<%= companion.getCompanionId() %>"
												name="companion_id">
											<button class="delete" type="submit">刪除</button>
										</form>
										<%} %>
							</table>
							<h3>共<%= companions.size() %>筆學伴資料</h3>
							<div><button class="index">回首頁</button></div>
						</div>

						<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

						<script>
							const deleteButtons = document.querySelectorAll('.delete');
							deleteButtons.forEach(button => {
								button.addEventListener('click', function (event) {
									event.preventDefault();
									const deleteButton = event.target;
									Swal.fire({
										title: "確定要刪除這筆資料嗎？",
										text: "刪除後資料無法復原",
										icon: "question",
										confirmButtonText: "確定",
										cancelButtonText: "取消",
										showCloseButton: true,
										showCancelButton: true,
									}).then((result) => {
										if (result.isConfirmed) {
											// 在這裡編寫使用者確認後要執行的操作
											// 提交表單
											const form = deleteButton.closest('form');
											form.submit();
										}
									});
								});
							});
						</script>

						<script>
							const index = document.querySelector('.index')
							index.addEventListener('click', function () {
								location.href = "/index.html"
							})
// 							const add = document.querySelector('#add')
// 							add.addEventListener('click', function () {
// 								location.href = "../CompanionInsert/insert.jsp"
// 							})
						</script>
					</body>

					</html>