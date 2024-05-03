<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/css/scheduleEdit.css" />
<title>新增教師行事曆頁面-查詢可預約時間</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>新增學生預約資料</h2>
		<form id="scheduleForm" method="post"
			action="${pageContext.request.contextPath}/studentReservation/add">
			課程編號 : <select name="courseID" id="courseID" required>
				<option value="">請選擇課程</option>
				<c:forEach items="${courses}" var="course">
					<option value="${course.courseID}"
						data-teacher-id="${course.teacherID}">${course.courseID},
						教師編號：${course.teacherID}, ${course.courseName}</option>
				</c:forEach>
			</select>
			<p>
				教師行事曆編號 : <select name="teacherScheduleID" id="teacherScheduleID"
					required>
					<option value="">請選擇教師行事曆</option>
					<c:forEach items="${teacherSchedules}" var="teacherSchedule">
						<option value="${teacherSchedule.teacherScheduleID}"
							class="teacher-schedule"
							data-teacher-id="${teacherSchedule.teacherID}">
							${teacherSchedule.teacherScheduleID},
							教師編號：${teacherSchedule.teacherID},
							日期：${teacherSchedule.courseDate}</option>
					</c:forEach>
				</select>
			<p>
				學生編號 : <select name="studentID" required>
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
	fetch("/html/backendPage.html")
	.then(response => response.text())
	.then(data => {
	    var headerElement = document.querySelector('#header');
	    headerElement.insertAdjacentHTML('beforeend', data); // 在現有內容後新增，不影響現有內容和事件
	    generateTimeSlots(); // 確保這個調用在 HTML 內容加載後進行
	})
	.catch(error => console.error('Error loading the header:', error));
	
	
	$(document).ready(function() {
        $('#courseID').change(function() {
            var selectedTeacherId = $(this).find('option:selected').data('teacher-id');
            $('#teacherScheduleID option').each(function() {
                if ($(this).data('teacher-id') == selectedTeacherId || $(this).val() == "") {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        var studentTimeSlots = [];

        var timeSlotsContainer1 = document.getElementById('timeSlots1');
        var timeSlotsContainer2 = document.getElementById('timeSlots2');
        for (var i = 0; i < 24; i++) {
        		
            var hour = ('0' + i).slice(-2) + ':00';
            var button = document.createElement('input');
            button.type = 'button';
            button.value = hour;
            button.classList.add('timeSlotButton');
            button.dataset.selected = 'false';
            button.onclick = function() {
                var btn = this;
                if (btn.dataset.selected === 'false') {
                    btn.classList.add('selected');
                    btn.dataset.selected = 'true';
                    studentTimeSlots.push(btn.value);
                } else {
                    btn.classList.remove('selected');
                    btn.dataset.selected = 'false';
                    var index = studentTimeSlots.indexOf(btn.value);
                    if (index !== -1) {
                        studentTimeSlots.splice(index, 1);
                    }
                }
            };
            if (i < 12) {
                timeSlotsContainer1.appendChild(button);
            } else {
                timeSlotsContainer2.appendChild(button);
            }
        }

        $('#scheduleForm').on('submit', function(e) {
            e.preventDefault();
            var today = new Date();
            var reservationDate = today.getFullYear() + '-' + (today.getMonth() + 1).toString().padStart(2, '0') + '-' + today.getDate().toString().padStart(2, '0');
            $('#reservationDate').val(reservationDate);
            $('#totalHours').val(studentTimeSlots.length);
            $('#studentTimeSlotsInput').val(JSON.stringify(studentTimeSlots));

            if (studentTimeSlots.length === 0) {
                alert('請至少選擇一個時段！');
                return;
            }

            var formData = $(this).serialize();

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                success: function(data) {
                    alert('預約新增成功！');
                    window.location.href = 'studentReservationPage/studentReservationAllPage'; // 成功後的跳轉
                },
                error: function(xhr) {
                    var error = JSON.parse(xhr.responseText);
                    alert(error.message);  // 顯示錯誤訊息的彈窗
                }
            });
        });
    });
	</script>
	<script src="/js/backend.js"></script>
</body>
</html>
