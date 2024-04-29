<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/teacherScheduleSelectOne.css" />
<title>教師行事曆查詢成功</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>教師行事曆查詢成功</h2>
		<h3 style="color:#C5D0E2">開放預約</h3>
		<h3 style="color:#bfbab0">已被預約</h3>
		<p>教師編號：${teacherSchedule.teacherID}</p>
		<p>教師帳號：${teacherSchedule.teacherUserName}</p>
		<p>課程日期：${teacherSchedule.courseDate}</p>
	</div>
	<div class="timeSlotContainer"></div>
	<p>
	<div class="info">
		<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>
	<script>
	fetch("/html/backendPage.html")
	.then(response => {
	if (response.ok) {
	   return response.text();
	}
	}).then(data => {
	document.querySelector('#header').innerHTML = data;
	})
	
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
		generateTimeSlots();

		function redirectToLoginPage() {
			window.location.href = "teacherSchedulePage/teacherScheduleAllPage";
		}
	</script>
</body>
</html>
