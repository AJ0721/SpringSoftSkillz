<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>老師帳號管理</title>
</head>

<body>
	<div>
		<h2>老師帳號管理</h2>
		<div>
			<table>
				<td>
					<form method="get" action="TeacherSelectOne">
						老師ID搜尋：<input type="text" name="teacherId"></input>&nbsp;&nbsp; <input
							type="submit" value="搜尋"></input>
					</form>
				</td>
				<td>
					<form method="get" action="TeacherSelectAll">
						<input type="submit" value="搜尋全部"></input>
					</form>
				</td>
			</table>
			<table border="1">
				<thead>
					<tr>
						<th>老師編號</th>
						<th>姓氏</th>
						<th>名字</th>
						<th>帳號名稱</th>
						<th>帳號創建時間</th>
						<th>性別</th>
						<th>生日</th>
						<th>手機號碼</th>
						<th>電子信箱</th>
						<th>密碼</th>
						<th>國籍</th>
						<th>照片</th>
						<th>授課科目</th>
						<th>教學經驗</th>
						<th>在職狀態</th>
						<th>學歷</th>
						<th>證照</th>
						<th>一週可授課時數</th>
						<th>教學優勢</th>
						<th>論壇會員狀態</th>
						<th>課程狀態</th>
						<th hidden>學生s+id</th>
						<th>修改</th>
						<th>刪除</th>
					</tr>
				</thead>
				<tbody>
					<!-- items="${students}" 是從controller傳來的信封的名字，然後去宣告變數var，從list裡一個一個拿出來 -->
					<c:forEach items="${teachers}" var="teaher">
						<tr>
							<td>${teaher.teacherId}</td>
							<td>${teaher.teacherLastName}</td>
							<td>${teaher.teacherFirstName}</td>
							<td>${teaher.teacherUserName}</td>
							<td>${teaher.teacherRegistrationDate}</td>
							<td>${teaher.teacherGender}</td>
							<td>${teaher.teacherBirth}</td>
							<td>${teaher.teacherMobile}</td>
							<td>${teaher.teacherEmail}</td>
							<td>${teaher.teacherPassword}</td>
							<td>${teaher.teacherCountry}</td>
							<td>${teaher.teacherPhoto}</td>
							<td>${teaher.subject}</td>
							<td>${teaher.experience}</td>
							<td>${teaher.status}</td>
							<td>${teaher.teacherEducation}</td>
							<td>${teaher.certification}</td>
							<td>${teaher.teachTime}</td>
							<td>${teaher.strength}</td>
							<td>${teaher.teacherForumStatus}</td>
							<td>${teaher.teacherCourseStatus}</td>
							<td hidden>${teaher.teacherIdFormatted}</td>
							<td><a
								href="teaher-update?teaherId=${teaher.teacherId}"
								class="button-link">修改</a></td>
							<td>
								<form action="TeacherDelete" method="post">
									<input type="hidden" name="_method" value="delete"> <input
										type="hidden" name="teacherId" value="${teaher.teacherId}" />
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