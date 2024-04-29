<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>學生註冊表單</title>
<style>
.s_pic {
	margin: 50px auto;
	max-width: 200px;
	max-height: 200px;
	margin-bottom: 10px;
	display: block;
}

h3 {
	text-align: center;
}

.container-in {
	color: black;
	display: flex;
	justify-content: space-around;
	align-items: flex-start;
	max-width: 1000px;
	margin: 0 auto;
}

.column {
	flex: 1;
	padding: 10px;
}

.column label {
	display: block;
	margin-bottom: 5px;
}

.column input, .column select {
	width: calc(100% - 12px);
	padding: 6px;
	margin-bottom: 10px;
}

.countrycode {
	width: calc(50% - 6px);
	padding: 6px;
	margin-bottom: 10px;
}

.submit-button {
	text-align: center;
	margin-top: 20px;
}

.container-out {
	background-color: #ffffff;
	padding: 20px 30px;
	border-radius: 8px;
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 900px;
	margin: 40px auto;
}
</style>
</head>

<body style="background-color: #919fc6">
	<div class="container-out">
		<form id="registrationForm" action="submit_student.php" method="POST"
			enctype="multipart/form-data">
			<img class="s_pic" id="personal_image"
				src="${pageContext.request.contextPath}/account/images/s_headshot.png"
				alt="預設圖片"> <input class="s_pic" type="file"
				id="profile_picture" name="profile_picture" accept="image/*">
			<h3>學生基本資料</h3>
			<div class="container-in">

				<div class="column">
					<label for="first_name">名字：</label> <input type="text"
						id="first_name" name="student_first_name" required><br>

					<label for="username">使用者名稱：</label> <input type="text"
						id="username" name="student_username" pattern="[a-zA-Z0-9_]+"
						title="只能輸入英文或符號" required><br> <label for="gender">性別：</label>
					<select id="gender" name="student_gender" required>
						<option value="">請選擇</option>
						<option value="Male">男性</option>
						<option value="Female">女性</option>
						<option value="Unspecified">不顯示</option>
					</select><br> <label for="email">電子郵件：</label> <input type="email"
						id="email" name="student_email" readonly required><br>
					<label for="country">國家：</label> <select id="country"
						name="student_country" required>
						<option value="">請選擇</option>
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
					</select><br> <label for="phone_number">手機國碼：</label>
					<div>
						<select class="countrycode" id="phone_code" name="phone_code"
							required>
							<option value="">請選擇</option>
							<option value="+93">阿富汗 (+93)</option>
							<option value="+355">阿爾巴尼亞 (+355)</option>
							<option value="+213">阿爾及利亞 (+213)</option>
							<option value="+376">安道爾 (+376)</option>
							<option value="+244">安哥拉 (+244)</option>
							<option value="+1268">安提瓜和巴布達 (+1268)</option>
							<option value="+54">阿根廷 (+54)</option>
							<option value="+374">亞美尼亞 (+374)</option>
							<option value="+61">澳大利亞 (+61)</option>
							<option value="+43">奧地利 (+43)</option>
							<option value="+994">阿塞拜疆 (+994)</option>
							<option value="+1242">巴哈馬 (+1242)</option>
							<option value="+973">巴林 (+973)</option>
							<option value="+886">台灣 (+886)</option>
							<option value="+1">加拿大 (+1)</option>
							<option value="+238">佛得角 (+238)</option>
							<option value="+236">中非共和國 (+236)</option>
							<option value="+235">查德 (+235)</option>
							<option value="+56">智利 (+56)</option>
							<option value="+86">中國 (+86)</option>
							<option value="+57">哥倫比亞 (+57)</option>
							<option value="+269">科摩羅 (+269)</option>
							<option value="+243">剛果（布） (+243)</option>
							<option value="+243">剛果（金） (+243)</option>
							<option value="+506">哥斯達黎加 (+506)</option>
							<option value="+385">克羅地亞 (+385)</option>
							<option value="+53">古巴 (+53)</option>
							<option value="+357">塞浦路斯 (+357)</option>
							<option value="+420">捷克共和國 (+420)</option>
							<option value="+45">丹麥 (+45)</option>
							<option value="+253">吉布提 (+253)</option>
						</select>
					</div>

					<label for="learning_frequency">學習頻率：</label> <select
						id="learning_frequency" name="learning_frequency" required>
						<option value="">請選擇</option>
						<option value="<14">一週小於14小時</option>
						<option value="14-28">一週14~28小時</option>
						<option value="28-42">一週28~42小時</option>
						<option value=">42">一週大於42小時</option>
					</select><br>
				</div>

				<div class="column">
					<label for="last_name">姓氏：</label> <input type="text"
						id="last_name" name="student_last_name" required><br>

					<label for="nickname">暱稱：</label> <input type="text" id="nickname"
						name="student_nickname"><br> <label for="birth">出生日期：</label>
					<input type="date" id="birth" name="student_birth" required><br>

					<label for="password">密碼：</label><input type="text" id="password"
						name="student_password" readonly required> <br>
					<label for="first_language">母語：</label><select id="languageSelect"
						required>
						<option value="">請選擇</option>
						<option value="zh-TW">繁體中文</option>
						<option value="zh-CN">簡體中文</option>
						<option value="en-US">英文</option>
						<option value="ja">日文</option>
						<option value="ko">韓文</option>
						<option value="es">西班牙文</option>
						<option value="fr">法文</option>
						<option value="de">德文</option>
						<option value="it">義大利文</option>
						<option value="pt">葡萄牙文</option>
						<option value="ru">俄文</option>
						<option value="ar">阿拉伯文</option>
						<option value="hi">印地文</option>
						<option value="bn">孟加拉文</option>
						<option value="vi">越南文</option>
						<option value="af">南非荷蘭文</option>
						<option value="am">阿姆哈拉文</option>
						<option value="bg">保加利亞文</option>
						<option value="cs">捷克文</option>
						<option value="da">丹麥文</option>
						<option value="el">希臘文</option>
						<option value="fa">波斯文</option>
						<option value="fi">芬蘭文</option>
						<option value="he">希伯來文</option>
						<option value="hu">匈牙利文</option>
						<option value="id">印尼文</option>
						<option value="ms">馬來文</option>
						<option value="nl">荷蘭文</option>
						<option value="no">挪威文</option>
						<option value="pl">波蘭文</option>
						<option value="ro">羅馬尼亞文</option>
						<option value="sk">斯洛伐克文</option>
						<option value="sl">斯洛維尼亞文</option>
						<option value="sv">瑞典文</option>
						<option value="ta">泰米爾文</option>
						<option value="th">泰文</option>
						<option value="tr">土耳其文</option>
						<option value="uk">烏克蘭文</option>
						<option value="ur">烏爾都文</option>
						<option value="uz">烏茲別克文</option>
						<option value="yi">意第緒文</option>
						<option value="yo">約魯巴文</option>
						<option value="zu">祖魯文</option>
						<option value="other">其他</option>
					</select> <br> <label for="phone_number">手機號碼：</label> <input
						type="text" id="phone_number" name="phone_number" pattern="[0-9]+"
						title="只能輸入數字" required><br> <label for="education">教育程度：</label>
					<select id="education" name="student_education" required>
						<option value="">請選擇</option>
						<option value="幼稚園">幼稚園</option>
						<option value="小學">小學</option>
						<option value="國中">國中</option>
						<option value="高中">高中</option>
						<option value="大學">大學</option>
						<option value="碩士">碩士</option>
						<option value="博士">博士</option>
						<option value="博士后">博士后</option>
					</select><br> </select><br>
				</div>
			</div>
			<div class="submit-button">
				<button type="submit">提交</button>
			</div>
		</form>
	</div>
</body>

</html>


