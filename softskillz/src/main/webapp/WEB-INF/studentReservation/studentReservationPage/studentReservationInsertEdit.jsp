<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/scheduleEdit.css" />
<title>新增教師行事曆頁面-新增學生預約</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<!-- 第一部分：查詢後的資料顯示，類似 TeacherScheduleEdit.jsp -->
	<div id="header"></div>
	<div class="info">
		<h2>教師行事曆查詢成功</h2>
		<p>課程名稱：${course.courseName}</p>
		<p>教師編號：${course.teacherID}</p>
		<p>教師行事曆編號：${teacherSchedule.teacherScheduleID}</p>
	</div>

	<div class="timeSlotContainer"></div>

	<script>
	fetch("/html/backendPage.html")
	.then(response => response.text())
	.then(data => {
	    var headerElement = document.querySelector('#header');
	    headerElement.insertAdjacentHTML('beforeend', data); // 在現有內容後新增，不影響現有內容和事件
	    generateTimeSlots(); // 確保這個調用在 HTML 內容加載後進行
	})
	.catch(error => console.error('Error loading the header:', error));
	
	
		// 獲取已選擇的時段資料
		var selectedTimeSlots = '${teacherSchedule.teacherTimeSlots}'.split('');

		// 生成時段並顯示在頁面上
 		function generateTimeSlots() {
			var container = document.querySelector('.timeSlotContainer');
			for (var i = 0; i < 24; i++) {
				var hour = ("0" + i).slice(-2);
				var timeSlot = document.createElement('div');
				timeSlot.textContent = hour + ':00';
				timeSlot.className = 'timeSlot';
				// 檢查該時段是否在已選擇的時段中
				if (selectedTimeSlots[i] === '1') {
					timeSlot.classList.add('selectedTimeSlot');
				}
				container.appendChild(timeSlot);
			}
		}	
	</script>
	<!-- 第二部分：時段選擇按鈕 -->
	<div class="info">
		<h2>新增學生預約資料</h2>
	</div>
	<div class="timeSlotsBtn">
		<form id="scheduleForm" method="post"
			action="${pageContext.request.contextPath}/studentReservation/add">
			<!-- 隱藏字段，傳遞課程編號、教師行事曆編號 -->
			<input type="hidden" name="courseID" value="${course.courseID}" /> <input
				type="hidden" name="teacherScheduleID"
				value="${teacherSchedule.teacherScheduleID}" /> 學生編號 : <select
				name="studentID" required>
				<option value="">請選擇學生</option>
				<c:forEach items="${students}" var="students">
					<option value="${students.studentId}">${students.studentFirstName}
						${students.studentLastName} (ID: ${students.studentIdFormatted})</option>
				</c:forEach>
			</select>
			<p>
			<fieldset>
				<legend>預約時段 :</legend>
				<!-- 使用 JavaScript 生成開課時段按鈕 -->
				<div class="row">
					<div id="timeSlots1" class="column"></div>
					<div id="timeSlots2" class="column"></div>
				</div>
			</fieldset>
			<p>
				<!-- 提交表單的按鈕 -->
				<input type="submit" value="新增" class="timeSlotButton" />

				<!-- 隐藏字段，用于传递已选择的時間段數據、預約日期、總選擇時段 -->
				<input type="hidden" id="studentTimeSlotsInput"
					name="studentTimeSlots" /> <input type="hidden"
					id="reservationDate" name="reservationDate" value=""> <input
					type="hidden" id="totalHours" name="totalHours" value="">
			</p>
		</form>
	</div>
	<script>
		// 存放已點擊的時段
		var studentTimeSlots = [];

		// 生成開課時段按鈕
		var timeSlotsContainer1 = document.getElementById('timeSlots1');
		var timeSlotsContainer2 = document.getElementById('timeSlots2');
		for (var i = 0; i < 24; i++) {
			var hour = ('0' + i).slice(-2);
			var button = document.createElement('input');
			button.type = 'button';
			button.value = hour + ':00';
			button.classList.add('timeSlotButton'); // 新增 CSS 類別以控制按鈕樣式
			button.dataset.selected = 'false'; // 初始狀態未選取
			button.addEventListener('click', function() {
				// 按鈕點擊事件處理函式
				if (this.dataset.selected === 'false') {
					// 若按鈕為未選取狀態，變色並加入已選取的時段列表
					this.classList.add('selected'); // 變色
					this.dataset.selected = 'true'; // 更新選取狀態
					studentTimeSlots.push(this.value); // 加入已選取的時段列表
				} else {
					// 若按鈕為已選取狀態，恢復原色並從已選取的時段列表中移除
					this.classList.remove('selected'); // 恢復原色
					this.dataset.selected = 'false'; // 更新選取狀態
					var index = studentTimeSlots.indexOf(this.value);
					if (index !== -1) {
						studentTimeSlots.splice(index, 1); // 從已選取的時段列表中移除
					}
				}
				console.log(studentTimeSlots); // 在控制台輸出已選取的時段列表
			});
			if (i < 12) {
				timeSlotsContainer1.appendChild(button);
			} else {
				timeSlotsContainer2.appendChild(button);
			}
		}

		// 監聽表單提交事件，防止直接提交表單
		document
				.getElementById('scheduleForm')
				.addEventListener(
						'submit',
						function(event) {
							event.preventDefault(); // 阻止表單提交

							// 設置當前日期
							var today = new Date();
							var dd = String(today.getDate()).padStart(2, '0');
							var mm = String(today.getMonth() + 1).padStart(2,
									'0'); //January is 0!
							var yyyy = today.getFullYear();
							today = yyyy + '-' + mm + '-' + dd;
							document.getElementById('reservationDate').value = today;

							// 設置選取的時段數
							document.getElementById('totalHours').value = studentTimeSlots.length;

							// 確認至少選擇了一個時段
							if (studentTimeSlots.length === 0) {
								alert('請至少選擇一個時段！');
								return;
							}

							// 將以選擇的時間段數據設置到隐藏字段中
							var studentTimeSlotsInput = document
									.getElementById('studentTimeSlotsInput');
							studentTimeSlotsInput.value = JSON
									.stringify(studentTimeSlots);

							// 提交表單
							this.submit();
						});
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>
