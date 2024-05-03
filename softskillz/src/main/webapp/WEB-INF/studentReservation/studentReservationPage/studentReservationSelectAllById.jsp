<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page
	import="com.softskillz.studentreservation.model.StudentReservationBean"%>
<%@ page
	import="com.softskillz.teacherschedule.model.TeacherScheduleBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="/css/teacherScheduleSelectAll.css" />
<title>單一學生預約查詢結果</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
</head>
<body>
	<div id="header"></div>
	<div class="info">
		<h2>所有預約</h2>
		<table id="reservationTable" class="display">
			<thead>
				<tr>
					<th>預約編號</th>
					<th>課程名稱</th>
					<th>課程日期</th>
					<th>預約日期</th>
					<th>總預約時數</th>
					<th>預約時段</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<StudentReservationBean> reservations = (List<StudentReservationBean>) request.getAttribute("reservations");
				for (StudentReservationBean reservation : reservations) {
				%>
				<tr>
					<td><%=reservation.getStudentReservationID()%></td>
					<td><%=reservation.getCourseBean().getCourseName()%></td>
					<td><%=reservation.getTeacherScheduleBean().getCourseDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%></td>
					<td><%=reservation.getReservationDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%></td>
					<td><%=reservation.getTotalHours()%></td>
					<td>
						<%
						String timeSlots = reservation.getStudentTimeSlots();
						StringBuilder availableSlots = new StringBuilder();
						StringBuilder reservedSlots = new StringBuilder();
						for (int i = 0; i < timeSlots.length(); i++) {
							char slot = timeSlots.charAt(i);
							String hour = String.format("%02d:00", i);
							if (slot == '1') {
								availableSlots.append(hour).append(", ");
							} else if (slot == '2') {
								reservedSlots.append(hour).append(", ");
							}
						}
						if (availableSlots.length() > 0)
							availableSlots.setLength(availableSlots.length() - 2); // Remove trailing comma
						if (reservedSlots.length() > 0)
							reservedSlots.setLength(reservedSlots.length() - 2); // Remove trailing comma
						out.print(availableSlots.toString());
						%>
					</td>
					<td>
						<form
							action="${pageContext.request.contextPath}/studentReservation/deleted"
							method="post">
							<input type="hidden" name="studentReservationID"
								value="<%=reservation.getStudentReservationID()%>" />
							<button type="submit">刪除</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<button onclick="redirectToLoginPage()">回到功能頁面</button>
	</div>
	<script>
    $(document).ready(function () {
        $('#reservationTable').DataTable({
            "language": {
                "url": "https://cdn.datatables.net/plug-ins/1.12.1/i18n/zh_HANT.json"
            }
        });
    });

    fetch("/html/backendPage.html")
    .then(response => {
        if (response.ok) {
           return response.text();
        }
    }).then(data => {
        document.querySelector('#header').innerHTML = data;
    });

    function redirectToLoginPage() {
        window.location.href = "studentReservationPage/studentReservationAllPage";
    }
</script>
	<script src="/js/backend.js"></script>
</body>
</html>