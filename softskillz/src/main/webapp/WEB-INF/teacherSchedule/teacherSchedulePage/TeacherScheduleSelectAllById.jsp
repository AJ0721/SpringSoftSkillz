<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page
 import="com.softskillz.teacherschedule.model.TeacherScheduleBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
 href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="/css/teacherScheduleSelectAll.css" />
<title>單一教師行事曆查詢結果</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
 src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
</head>
<body>
 <div id="header"></div>
 <div class="info">
  <h2>所有行事曆</h2>
  <table id="scheduleTable">
   <thead>
    <tr>
     <th>行事曆編號</th>
     <th>教師編號</th>
     <th>教師帳號</th>
     <th>課程日期</th>
     <th>可預約時段</th>
     <th>已被預約時段</th>
     <th>操作</th>
    </tr>
   </thead>
   <tbody>
    <%
    List<TeacherScheduleBean> teacherSchedules = (List<TeacherScheduleBean>) request.getAttribute("teacherSchedules");
    for (TeacherScheduleBean schedule : teacherSchedules) {
    %>
    <tr>
     <td><%=schedule.getTeacherScheduleID()%></td>
     <td><%=schedule.getTeacherID()%></td>
     <td><%=schedule.getTeacherBean().getTeacherUserName()%></td>
     <td><%=schedule.getCourseDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))%></td>
     <td>
      <%
      String timeSlots = schedule.getTeacherTimeSlots();
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
     <td><%=reservedSlots.toString()%></td>
     <td>
      <form
       action="${pageContext.request.contextPath}/teacherSchedule/deleted"
       method="post">
       <input type="hidden" name="teacherScheduleID"
        value="<%=schedule.getTeacherScheduleID()%>" />
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
   $('#scheduleTable').DataTable({
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
   window.location.href = "teacherSchedulePage/teacherScheduleAllPage";
  }
 </script>
</body>
</html>
