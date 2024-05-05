<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Add Student</title>
        <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/background.css" />
    </head>

    <body>
        <h2>新增學生</h2>
        <form action="addStudent.jsp" method="post">
            姓：<input type="text" name="firstName" required><br>
            名：<input type="text" name="lastName" required><br>
            使用者名稱：<input type="text" name="username" required><br>
            暱稱：<input type="text" name="nickname"><br>
            性別：<select name="gender" required>
                <option value="Male">男性</option>
                <option value="Female">女性</option>
                <option value="Unspecified">不顯示</option>
            </select><br>
            出生日期：<input type="date" name="birthDate" required><br>
            手機：<input type="text" name="mobile" required><br>
            電子信ㄒㄧ：<input type="email" name="email" required><br>
            密碼：<input type="password" name="password" required><br>
            國家：<input type="text" name="country"><br>
            <input type="submit" value="提交">
        </form>
    </body>

    </html>
