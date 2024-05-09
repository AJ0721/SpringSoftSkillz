<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>管理員註冊</title>
</head>

<body style="background-color: #white">
	<div align="center">
		<h3>管理員帳號註冊</h3>
		<form method="post" action="/admin/admin-create">
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