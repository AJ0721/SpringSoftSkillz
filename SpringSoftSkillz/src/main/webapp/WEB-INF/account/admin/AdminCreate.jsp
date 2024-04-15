<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>新增管理員</title>
</head>

<body style="background-color: #e4edec">
	<div align="center">
		<h3>新增管理員帳號</h3>
		<form method="post" action="${pageContext.request.contextPath}/admin">
			<table>
				<tr>
					<td><label for="admin_account"> 管理員帳號：</label></td>
					<td><input type="text" name="adminAccount" id="admin_account"></td>
				</tr>
				<tr>
					<td><label for="admin_password"> 管理員密碼：</label></td>
					<td><input type="text" name="adminPassword"
						id="admin_password"></td>
				</tr>
			</table>
			<br /> <input type="submit" value="送出"> <input type="reset"
				value="清除"> <br />
			<div class="errContainer">${StatusMsg}</div>
		</form>
	</div>
</body>
</html>