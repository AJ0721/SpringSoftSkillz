<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/teacherScheduleSelectOne.css" />
<title>學生預約查詢成功</title>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>學生預約查詢成功</h2>
		<h3 style="color: #C5D0E2">預約時段</h3>
		<p>預約編號：${reservations.studentReservationID}</p>
		<p>課程編號：${reservations.courseID}</p>
		<p>預約日期：${reservations.reservationDate}</p>
		<p>總預約時數：${reservations.totalHours}</p>
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
		var selectedTimeSlots = '${reservations.studentTimeSlots}'.split('');

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
		generateTimeSlots();

		function redirectToLoginPage() {
			window.location.href = "studentReservationPage/studentReservationAllPage";
		}
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>
