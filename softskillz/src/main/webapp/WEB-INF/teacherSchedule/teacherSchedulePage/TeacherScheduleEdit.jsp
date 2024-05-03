<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/scheduleEdit.css" />
<title>修改教師行事曆頁面</title>
</head>
<body>
	<!-- 第一部分：查詢後的資料顯示，類似 TeacherScheduleSelectSuccessed.jsp -->
	<%-- <%@ include file="TeacherScheduleSelectSuccessed.jsp"%> --%>
	<div id="header"></div>
	<div class="info">
		<h2>教師行事曆查詢成功</h2>
		<h3 style="color: #C5D0E2">開放預約</h3>
		<h3 style="color: #bfbab0">已被預約</h3>
		<p>教師編號：${teacherSchedule.teacherID}</p>
		<p>教師帳號：${teacherSchedule.teacherUserName}</p>
		<p>課程日期：${teacherSchedule.courseDate}</p>
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
				var hour = ("0" + i).slice(-2) + ':00';
				var timeSlot = document.createElement('div');
				timeSlot.textContent = hour;
				timeSlot.className = 'timeSlot';
				// 檢查該時段是否在已選擇的時段中
				if (selectedTimeSlots[i] === '1') {
					timeSlot.classList.add('selectedTimeSlot');
				} else if (selectedTimeSlots[i] === '2') {
					timeSlot.classList.add('teachedTimeSlot');
				}
				container.appendChild(timeSlot);
			}
		}
	</script>

	<!-- 第二部分：時段選擇按鈕 -->
	<div class="timeSlotsBtn">
		<form id="scheduleForm" method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/updated">
			<!-- 隱藏字段，傳遞教師編號和課程日期 -->
			<input type="hidden" name="teacherScheduleID"
				value="${teacherSchedule.teacherScheduleID}" /> <input
				type="hidden" name="teacherID" value="${teacherSchedule.teacherID}" />
			<input type="hidden" name="courseDate"
				value="${teacherSchedule.courseDate}" />

			<!-- 使用 JavaScript 生成時段選擇按鈕 -->
			<fieldset>
				<legend>選擇時段</legend>
				<div class="row">
					<div id="timeSlots1" class="column"></div>
					<div id="timeSlots2" class="column"></div>
				</div>
			</fieldset>

			<p>
				<!-- 提交表單的按鈕 -->
				<input type="submit" value="修改" class="timeSlotButton" />
				<!-- 隐藏字段，用于传递已选择的时间段数据 -->
				<input type="hidden" id="teacherTimeSlotsInput"
					name="teacherTimeSlots" />
			</p>
		</form>
	</div>

	<script>
	
		// 存放已點擊的時段
		var teacherTimeSlots = [];

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
					teacherTimeSlots.push(this.value); // 加入已選取的時段列表
				} else {
					// 若按鈕為已選取狀態，恢復原色並從已選取的時段列表中移除
					this.classList.remove('selected'); // 恢復原色
					this.dataset.selected = 'false'; // 更新選取狀態
					var index = teacherTimeSlots.indexOf(this.value);
					if (index !== -1) {
						teacherTimeSlots.splice(index, 1); // 從已選取的時段列表中移除
					}
				}
				console.log(teacherTimeSlots); // 在控制台輸出已選取的時段列表
			});
			if (i < 12) {
				timeSlotsContainer1.appendChild(button);
			} else {
				timeSlotsContainer2.appendChild(button);
			}
		}

		// 監聽表單提交事件，防止直接提交表單
		document.getElementById('scheduleForm').addEventListener(
				'submit',
				function(event) {
					event.preventDefault(); // 阻止表單提交

					// 將以選擇的時間段數據設置到隐藏字段中
					var teacherTimeSlotsInput = document
							.getElementById('teacherTimeSlotsInput');
					teacherTimeSlotsInput.value = JSON
							.stringify(teacherTimeSlots);

					// 確認至少選擇了一個時段
					if (teacherTimeSlots.length === 0) {
						alert('請至少選擇一個時段！');
						return;
					}
					// 提交表單
					this.submit();
				});
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>