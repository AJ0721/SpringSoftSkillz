<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<style>
.button-container {
	display: flex;
	justify-content: flex-end;
	padding-top: 30px;
}

.button-container input {
	width: auto;
	margin-right: 20px;
}
</style>
<meta charset="UTF-8">
<title>學生註冊</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/assets/compiled/css/app.css">
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth() + 1; //January is 0!
		var yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd;
		}
		if (mm < 10) {
			mm = '0' + mm;
		}
		today = yyyy + '-' + mm + '-' + (dd - 1); // 將日期減去一天
		document.getElementById("studentBirth").setAttribute("max", today);
	});
</script>
</head>

<body>
	<div class="container mt-4">
		<div class="card">
			<div class="card-header">
				<h2 class="card-title">學生註冊</h2>
			</div>
			<div class="card-body">
				<form action="/student/student-create" method="post">
					<div class="row">
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentLastName" class="form-label">姓氏</label> <input
									type="text" id="studentLastName" class="form-control"
									placeholder="Last Name" name="studentLastName" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentFirstName" class="form-label">名字</label> <input
									type="text" id="studentFirstName" class="form-control"
									placeholder="First Name" name="studentFirstName" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentUsername" class="form-label">帳號</label> <input
									type="text" id="studentUsername" class="form-control"
									placeholder="Username" name="studentUsername" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentPassword" class="form-label">密碼</label> <input
									type="password" id="studentPassword" class="form-control"
									placeholder="Password" name="studentPassword" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentBirth" class="form-label">出生日期</label> <input
									type="date" id="studentBirth" class="form-control"
									name="studentBirth" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentGender" class="form-label">性別</label> <select
									id="studentGender" class="form-control" name="studentGender"
									required>
									<option value="Male">男性</option>
									<option value="Female">女性</option>
									<option value="Unspecified">不顯示</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentEmail" class="form-label">電子信箱</label> <input
									type="email" id="studentEmail" class="form-control"
									placeholder="Email" name="studentEmail" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group mandatory">
								<label for="studentMobile" class="form-label">手機號碼</label> <input
									type="text" id="studentMobile" class="form-control"
									placeholder="Mobile Number" name="studentMobile" required>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="country" class="form-label">國家</label> <select
									id="country" class="form-control" name="studentCountry">
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
									<option value="台灣" selected>台灣</option>
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
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="firstLanguage" class="form-label">母語</label> <select
									id="firstLanguage" class="form-control" name="firstLanguage">
									<option value="中文" selected>中文</option>
									<option value="達利語">達利語</option>
									<option value="阿爾巴尼亞語">阿爾巴尼亞語</option>
									<option value="阿拉伯語">阿拉伯語</option>
									<option value="加泰隆尼亞語">加泰隆尼亞語</option>
									<option value="葡萄牙語">葡萄牙語</option>
									<option value="英語">英語</option>
									<option value="西班牙語">西班牙語</option>
									<option value="亞美尼亞語">亞美尼亞語</option>
									<option value="德語">德語</option>
									<option value="阿塞拜疆語">阿塞拜疆語</option>
									<option value="孟加拉語">孟加拉語</option>
									<option value="白俄羅斯語">白俄羅斯語</option>
									<option value="荷蘭語">荷蘭語</option>
									<option value="法語">法語</option>
									<option value="宗卡語">宗卡語</option>
									<option value="波士尼亞語">波士尼亞語</option>
									<option value="塞茨瓦納語">塞茨瓦納語</option>
									<option value="保加利亞語">保加利亞語</option>
									<option value="高棉語">高棉語</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="studentEducation" class="form-label">教育程度</label> <select
									id="studentEducation" class="form-control"
									name="studentEducation">
									<option value="幼稚園">幼稚園</option>
									<option value="小學">小學</option>
									<option value="國中">國中</option>
									<option value="高中">高中</option>
									<option value="大學" selected>大學</option>
									<option value="碩士">碩士</option>
									<option value="博士">博士</option>
									<option value="博士后">博士后</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-12">
							<div class="form-group">
								<label for="learningFrequency" class="form-label">學習頻率</label> <select
									id="learningFrequency" class="form-control"
									name="learningFrequency">
									<option value="一週小於14小時">一週小於14小時</option>
									<option value="一週約14到28小時">一週約14到28小時</option>
									<option value="一週約28到42小時">一週約28到42小時</option>
									<option value="一週大於42小時">一週大於42小時</option>
								</select>
							</div>
						</div>
						<div class="button-container">
							<input type="submit" value="提交" class="btn btn-primary">
							<input type="reset" value="清除" class="btn btn-secondary">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

</html>