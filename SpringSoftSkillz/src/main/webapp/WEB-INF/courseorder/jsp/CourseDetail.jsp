<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/bar.css">
<link rel="stylesheet" href="css/tablefotcart.css">
<title>${course.courseName}</title>
</head>
<body>
	<%@ include file="../html/testiframe.html"%>
	<form method="get" action="addToCart" >
	<table>
		<thead>
			<tr>
				<th>課程ID</th>
				<th>教師名稱</th>
				<th>教師名稱</th>
				<th>課程名稱</th>
				<th>課程說明</th>
				<th>科目</th>
				<th>價格</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${course.courseID}</td>
				<td><img src="${course.teacherPhoto}"></td>
				<td>${course.teacherName}</td>
				<td>${course.courseName}</td>
				<td>${course.courseInfo}</td>
				<td>${course.courseCategory}</td>
				<td><select name="quantity">
						<option value="1">1*NT${course.price}/堂</option>
						<option value="5">5*NT${course.price}/堂</option>
						<option value="10">10*NT${course.price}/堂</option>
						<option value="20">20*NT${course.price}/堂</option>
				</select></td>
			</tr>
		</tbody>
		<tfoot>
			<td colspan="3"></td>
			<td colspan="2" align="center"><a href="${pageContext.request.contextPath}/course.do"><button
						type="button">返回</button></a></td>
			<td colspan="2" align="center"><button type="submit">加入購物車</button></td>
		</tfoot>
	</table>
	</form>
</body>
</html>