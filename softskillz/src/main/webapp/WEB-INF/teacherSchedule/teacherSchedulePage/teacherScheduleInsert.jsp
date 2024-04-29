<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/scheduleEdit.css" />
<title>新增教師行事曆頁面</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>新增教師行事曆資料</h2>
		<form id="scheduleForm" method="post"
			action="${pageContext.request.contextPath}/teacherSchedule/add">
			教師編號 : <select name="teacherID" required>
				<option value="">請選擇教師</option>
				<c:forEach items="${teachers}" var="teacher">
					<option value="${teacher.teacherId}">${teacher.teacherFirstName}
						${teacher.teacherLastName} (ID: ${teacher.teacherIdFormatted})</option>
				</c:forEach>
			</select>
			<p>
				<label for="courseDate">課程日期 :</label> <input type="date"
					id="courseDate" name="courseDate" required />
			<p>
			<fieldset>
				<legend>開課時段 :</legend>
				<!-- 使用 JavaScript 生成開課時段按鈕 -->
				<div class="row">
					<div id="timeSlots1" class="column"></div>
					<div id="timeSlots2" class="column"></div>
				</div>
			</fieldset>
			<p>
				<!-- 提交表單的按鈕 -->
				<input type="submit" value="新增" class="timeSlotButton" />
				<!-- 隐藏字段，用于传递已选择的时间段数据 -->
				<input type="hidden" id="teacherTimeSlotsInput"
					name="teacherTimeSlots" />
			</p>
		</form>
	</div>
	<script>
	fetch("/html/backendPage.html")
	.then(response => response.text())
	.then(data => {
	    var headerElement = document.querySelector('#header');
	    headerElement.insertAdjacentHTML('beforeend', data); // 在現有內容後新增，不影響現有內容和事件
	    generateTimeSlots(); // 確保這個調用在 HTML 內容加載後進行
	})
	.catch(error => console.error('Error loading the header:', error));
	
		var teacherTimeSlots = [];

		function createTimeSlotButton(hour) {
			var button = document.createElement('input');
			button.type = 'button';
			button.value = hour + ':00';
			button.classList.add('timeSlotButton');
			button.onclick = function() {
				if (this.classList.contains('selected')) {
					this.classList.remove('selected');
					var index = teacherTimeSlots.indexOf(this.value);
					teacherTimeSlots.splice(index, 1);
				} else {
					this.classList.add('selected');
					teacherTimeSlots.push(this.value);
				}
				document.getElementById('teacherTimeSlotsInput').value = JSON
						.stringify(teacherTimeSlots);
			};
			return button;
		}

		for (var i = 0; i < 24; i++) {
			var hour = ('0' + i).slice(-2);
			var button = createTimeSlotButton(hour);
			if (i < 12) {
				document.getElementById('timeSlots1').appendChild(button);
			} else {
				document.getElementById('timeSlots2').appendChild(button);
			}
		}

		document
				.getElementById('scheduleForm')
				.addEventListener(
						'submit',
						function(event) {
							event.preventDefault(); // 阻止表單預設提交行為
							var teacherID = document
									.querySelector('select[name="teacherID"]').value;
							var courseDate = document
									.getElementById('courseDate').value;

							if (teacherTimeSlots.length === 0) {
								alert('請至少選擇一個時段！');
								return;
							}

							// 發送 AJAX 請求到後端檢查是否存在相同的教師編號和課程日期
							$
									.ajax({
										url : '${pageContext.request.contextPath}/teacherSchedule/check',
										type : 'GET',
										data : {
											teacherID : teacherID,
											courseDate : courseDate
										},
										success : function(exists) {
											if (exists === "true") {
												if (confirm("該教師的行事曆在此日期已存在，是否轉到修改頁面？")) {
													window.location.href = '${pageContext.request.contextPath}/teacherSchedule/selectUpdate?teacherID='
															+ teacherID
															+ '&courseDate='
															+ courseDate;
												}
											} else {
												// 如果不存在重複，則正常提交表單
												document.getElementById(
														'scheduleForm')
														.submit();
											}
										},
										error : function() {
											alert('檢查資料失敗，請稍後再試。');
										}
									});
						});
	</script>

	<!-- 	<script>
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
		document
				.getElementById('scheduleForm')
				.addEventListener(
						'submit',
						function(event) {
							event.preventDefault(); // 阻止表單提交

							//檢查是否有重複的行事曆資料
							var teacherID = document
									.querySelector('select[name="teacherID"]').value;
							var courseDate = document
									.getElementById('courseDate').value;

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
	</script> -->
</body>
</html>
