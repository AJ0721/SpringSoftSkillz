<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學生帳號管理</title>
</head>

<body>
	<div>
		<h2>學生帳號管理</h2>
		<div>
			<table>
				<td>
					<form method="get" action="StudentSelectOne">
						學生ID搜尋：<input type="text" name="studentId"></input>&nbsp;&nbsp; <input
							type="submit" value="搜尋"></input>
					</form>
				</td>
				<td>
					<form method="get" action="StudentSelectAll">
						<input type="submit" value="搜尋全部"></input>
					</form>
				</td>
			</table>
			<table border="1">
				<thead>
					<tr>
						<th>學生編號</th>
						<th>姓氏</th>
						<th>名字</th>
						<th>帳號名稱</th>
						<th>暱稱</th>
						<th>帳號創建時間</th>
						<th>性別</th>
						<th>生日</th>
						<th>手機號碼</th>
						<th>電子信箱</th>
						<th>密碼</th>
						<th>國籍</th>
						<th>照片</th>
						<th>學歷</th>
						<th>論壇會員狀態</th>
						<th>課程狀態</th>
						<th>母語</th>
						<th>學習頻率</th>
						<th hidden>學生s+id</th>
						<th>&nbsp;&nbsp;修改&nbsp;&nbsp;</th>
						<th>&nbsp;&nbsp;刪除&nbsp;&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<!-- items="${students}" 是從controller傳來的信封的名字，然後去宣告變數var，從list裡一個一個拿出來 -->
					<c:forEach items="${students}" var="student">
						<tr>
							<td>${student.studentId}</td>
							<td>${student.studentLastName}</td>
							<td>${student.studentFirstName}</td>
							<td>${student.studentUsername}</td>
							<td>${student.studentNickname}</td>
							<td>${student.studentRegistrationDate}</td>
							<td>${student.studentGender}</td>
							<td>${student.studentBirth}</td>
							<td>${student.studentMobile}</td>
							<td>${student.studentEmail}</td>
							<td>${student.studentPassword}</td>
							<td>${student.studentCountry}</td>
							<td>${student.studentPhoto}</td>
							<td>${student.studentEducation}</td>
							<td>${student.studentForumStatus}</td>
							<td>${student.studentCourseStatus}</td>
							<td>${student.firstLanguage}</td>
							<td>${student.learningFrequency}</td>
							<td hidden>${student.studentIdFormatted}</td>
							<td><a
								href="student-update?studentId=${student.studentId}"
								class="button-link">修改</a></td>
							<td>
								<form action="StudentDelete" method="post">
									<input type="hidden" name="_method" value="delete"> <input
										type="hidden" name="studentId" value="${student.studentId}" />
									<button type="submit">刪除</button>
								</form>
							</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
			<div>${rowMsg}</div>
		</div>
	</div>

</body>

</html>