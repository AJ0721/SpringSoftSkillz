<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>修改學生資料</title>
</head>

<body>
	<h2>修改學生資料</h2>
	<form action="/student/StudentUpdate" method="post">
		<input type="hidden" name="_method" value="put"> 學生ID：<span>${student.studentId}</span>
		<input type="hidden" name="studentId" value="${student.studentId}"><br>
		帳號：<span>${student.studentUsername}</span> <input type="hidden"
			name="studentUsername" value="${student.studentUsername}"><br>
		出生日期：<span>${student.studentBirth}</span> <input type="hidden"
			name="studentBirth" value="${student.studentBirth}"><br>
		姓：<input type="text" name="studentLastName"
			value="${student.studentLastName}" required><br> 名：<input
			type="text" name="studentFirstName"
			value="${student.studentFirstName}" required><br> 密碼：<input
			type="password" name="studentPassword"
			value="${student.studentPassword}" required><br> 電子信箱：<input
			type="email" name="studentEmail" value="${student.studentEmail}"
			required><br> 性別：<select name="studentGender" required>
			<option value="Male"
				${student.studentGender == 'Male' ? 'selected' : ''}>男性</option>
			<option value="Female"
				${student.studentGender == 'Female' ? 'selected' : ''}>女性</option>
			<option value="Unspecified"
				${student.studentGender == 'Unspecified' ? 'selected' : ''}>不顯示</option>
		</select><br> 國家：<select id="studentCountry" name="studentCountry"
			required>
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
		</select><br> 手機號碼：<input type="text" name="studentMobile"
			value="${student.studentMobile}" required><br> 教育程度：<select
			id="studentEducation" name="studentEducation" required>
			<option value="幼稚園">幼稚園</option>
			<option value="小學">小學</option>
			<option value="國中">國中</option>
			<option value="高中">高中</option>
			<option value="大學">大學</option>
			<option value="碩士">碩士</option>
			<option value="博士">博士</option>
			<option value="博士后">博士后</option>
		</select><br> 學習頻率：<select id="learningFrequency" name="learningFrequency"
			required>
			<option value="一週小於14小時"
				${student.learningFrequency == '一週小於14小時' ? 'selected' : ''}>一週小於14小時</option>
			<option value="一週約14到28小時"
				${student.learningFrequency == '一週約14到28小時' ? 'selected' : ''}>一週約14到28小時</option>
			<option value="一週約28到42小時"
				${student.learningFrequency == '一週約28到42小時' ? 'selected' : ''}>一週約28到42小時</option>
			<option value="一週大於42小時"
				${student.learningFrequency == '一週大於42小時' ? 'selected' : ''}>一週大於42小時</option>
		</select><br> <input type="reset" value="清除"> <input type="submit"
			value="提交">
	</form>
</body>

</html>
