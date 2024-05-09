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
        <h2>學生註冊</h2>
        <form action="studentCreate.jsp" method="post">
            姓：<input type="text" name="firstName" required><br>
            名：<input type="text" name="lastName" required><br>
            帳號：<input type="text" name="username" required><br>
            性別：<select name="gender" required>
                <option value="Male">男性</option>
                <option value="Female">女性</option>
                <option value="Unspecified">不顯示</option>
            </select><br>
            出生日期：<input type="date" name="birthDate" required><br>
            手機：<input type="text" name="mobile" required><br>
            電子信箱：<input type="email" name="email" required><br>
            密碼：<input type="password" name="password" required><br>
            <label for="country">國家：</label>
            <select id="country" name="student_country">
                <option value="阿富汗">阿富汗</option>
                <option value="阿爾巴尼亞">阿爾巴尼亞</option>
                <option value="阿爾及利亞">阿爾及利亞</option>
                <option value="安道爾">安道爾</option>
                <option value="安哥拉">安哥拉</option>
                <option value="安提瓜和巴布達">安提瓜和巴布達</option>
                <option value="阿根廷">阿根廷</option>
                <option value="亞美尼亞">亞美尼亞</option>
                <option value="澳大利亞">澳大利亞</option>
                <option value="奧地利">奧地利</option>
                <option value="阿塞拜疆">阿塞拜疆</option>
                <option value="巴哈馬">巴哈馬</option>
                <option value="巴林">巴林</option>
                <option value="孟加拉國">孟加拉國</option>
                <option value="巴巴多斯">巴巴多斯</option>
                <option value="白俄羅斯">白俄羅斯</option>
                <option value="比利時">比利時</option>
                <option value="貝寧">貝寧</option>
                <option value="不丹">不丹</option>
                <option value="玻利維亞">玻利維亞</option>
                <option value="波斯尼亞和黑塞哥維那">波斯尼亞和黑塞哥維那</option>
                <option value="博茨瓦納">博茨瓦納</option>
                <option value="巴西">巴西</option>
                <option value="保加利亞">保加利亞</option>
                <option value="布基納法索">布基納法索</option>
                <option value="布隆迪">布隆迪</option>
                <option value="柬埔寨">柬埔寨</option>
                <option value="喀麥隆">喀麥隆</option>
                <option value="台灣">台灣</option>
                <option value="加拿大">加拿大</option>
                <option value="佛得角">佛得角</option>
                <option value="中非共和國">中非共和國</option>
                <option value="查德">查德</option>
                <option value="智利">智利</option>
                <option value="中國">中國</option>
                <option value="哥倫比亞">哥倫比亞</option>
                <option value="科摩羅">科摩羅</option>
                <option value="剛果（布）">剛果（布）</option>
                <option value="剛果（金）">剛果（金）</option>
                <option value="哥斯達黎加">哥斯達黎加</option>
                <option value="克羅地亞">克羅地亞</option>
                <option value="古巴">古巴</option>
                <option value="塞浦路斯">塞浦路斯</option>
                <option value="捷克共和國">捷克共和國</option>
                <option value="丹麥">丹麥</option>
                <option value="吉布提">吉布提</option>
            </select><br>
            <input type="submit" value="提交">
        </form>
    </body>

    </html>