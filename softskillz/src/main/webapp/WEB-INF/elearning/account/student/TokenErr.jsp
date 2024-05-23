<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>連結已超時</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #2cb7e1ae; /* 天空藍色背景 */
            color: #333; /* 深色文字 */
            margin: 0;
            padding: 0;
            margin-top: 150px;
        }
        .email-container {
            background-color: #ffffff; /* 白色背景 */
            width: 80%;
            max-width: 600px;
            margin: 20px auto; /* 自動邊距 */
            padding: 20px;
            border: 1px solid #ccc; /* 輕微的邊框 */
            border-radius: 10px;
            text-align: center; /* 置中對齊 */
        }
        .logo {
            max-width: 250px;
            height: auto;
            margin-top: 50px;
            margin-bottom: 20px;
        }
        .button {
            display: inline-block;
            width: 250px;
            background-color: #386391; /* 深藍色 */
            color: white; /* 白色文字 */
            text-align: center;
            padding: 10px 0;
            text-decoration: none;
            border-radius: 5px;
            font-size: 20px; /* 文字大小 */
            margin: 20px 0;
        }
        .content {
            text-align: center;
            background-color: #ffffff;
        }
        h1 {
            color: #386391;
        }
    </style>
</head>
<body>
    <div class="email-container">
        <img src="/dist/account/images/softskillz_logo.png" alt="Softskillz Logo" class="logo">
        <div class="content">
            <h1>錯誤頁面</h1>
            <p>請求錯誤</p>
            <a href="/student/student-loginPage" class="button">返回登入頁面</a>
            <p>如果您沒有請求重設密碼，請忽略這封郵件</p>
            <p>from SoftSkillz Team</p>
        </div>
    </div>
</body>
</html>