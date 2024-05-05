<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學生CRUD頁面</title>
</head>

<body>
	<div>
		<h2>學生CRUD頁面</h2>
		<div>
			<table>
				<td>
					<form method="get" action="">
						學生id搜尋：<input type="text" name="admin_id"></input>&nbsp;&nbsp; <input
							type="submit" value="搜尋"></input>
					</form>
				</td>
				<td>
					<form method="get" action="studentSelectAll">
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
					<c:forEach items="${student}" var="students">
						<tr>
							<td>${students.studentId}</td>
							<td>${students.studentLastName}</td>
							<td>${students.studentFirstName}</td>
							<td>${students.studentUsername}</td>
							<td>${students.studentNickname}</td>
							<td>${students.studentRegistrationDate}</td>
							<td>${students.studentGender}</td>
							<td>${students.studentBirth}</td>
							<td>${students.studentMobile}</td>
							<td>${students.studentEmail}</td>
							<td>${students.studentPassword}</td>
							<td>${students.studentCountry}</td>
							<td>${students.studentPhoto}</td>
							<td>${students.studentEducation}</td>
							<td>${students.studentForumStatus}</td>
							<td>${students.studentCourseStatus}</td>
							<td>${students.firstLanguage}</td>
							<td>${students.learningFrequency}</td>
							<td hidden>${students.studentIdFormatted}</td>
							<td>
								<form action="" method="post">
									<input type="hidden" name="adminId" value="${admin.adminId}" />
									<button type="submit">修改</button>
								</form>
							</td>
							<td>
								<form action="" method="post">
									<input type="hidden" name="adminId" value="${admin.adminId}" />
									<button type="submit">刪除</button>
								</form>
							</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>

</html>