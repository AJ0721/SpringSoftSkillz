<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.softskillz.companion.model.CompanionBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>符合配對條件的學伴資料</title>
<style>
#img{
width: 160px;
height: auto;
}
tr{
text-align:center;
}
td{

text-align:center;

}

		button {
			padding: 8px 20px;
			/* 按鈕內邊距 */
			margin: 0px;
			/* 按鈕間距 */
			border: none;
			/* 去除按鈕邊框 */
			border-radius: 4px;
			/* 設置按鈕圓角 */
			background-color: #007bff;
			/* 按鈕背景顏色 */
			color: #fff;
			/* 按鈕文字顏色 */
			cursor: pointer;
			/* 滑鼠懸停樣式 */
		}

		button:hover {
			background-color: #0056b3;
			/* 滑鼠懸停時的背景顏色 */
		}

		.index {
			background-color: #dc3545;
			/* 回首頁按鈕的背景顏色 */
			display: flex;
			align-items: center;
			justify-content: flex-end;
			margin: 10px;
		}

		.index:hover {
			background-color: #c82333;
			/* 滑鼠懸停時的背景顏色 */
		}

		table {
  width: 100%;
  border-collapse: collapse;
  box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);
}

/* 表格標題樣式 */
th {
  background-color: #FFDEDE; /* 背景顏色 */
  color: #333; /* 文字顏色 */
  font-weight: bold; /* 加粗 */
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 表格內容樣式 */
td {
  padding: 8px; /* 內邊距 */
  border: 1px solid #ddd; /* 邊框 */
}

/* 奇數行背景色 */
tr:nth-child(odd) {
  background-color: #FFF2F2;
}

/* 鼠標懸停時的背景色 */
tr:hover {
  background-color: #D2E9FF;
}

html {
  background: #fdf5e6;
  font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
}
/* body { */
/*   margin: 30px auto 0 auto; */
/*   width: 450px; */
/*   font-size: 75%; */
/* } */

h3 {
  margin-top: 30px;
  font-size: 18px;
  color: #555;
}

p { padding-left: 10px; }


/*
 * Basic button style
 */
.btn {
  box-shadow: 1px 1px 0 rgba(255,255,255,0.5) inset;
  border-radius: 3px;
  border: 1px solid;
  display: inline-block;
  height: 32px;
  line-height: 32px;
  padding: 0 8px;
  position: relative;

  font-size: 16px;
  text-decoration: none;
  text-shadow: 0 1px 0 rgba(255,255,255,0.5);
}
/*
 * Counter button style
 */
.btn-counter { margin-right: 39px; }
.btn-counter:after,
.btn-counter:hover:after { text-shadow: none; }
.btn-counter:after {
  border-radius: 3px;
  border: 1px solid #d3d3d3;
  background-color: #eee;
  padding: 0 8px;
  color: #777;
  content: attr(data-count);
  left: 100%;
  margin-left: 8px;
  margin-right: -13px;
  position: absolute;
  top: -1px;
}
.btn-counter:before {
  transform: rotate(45deg);
  filter: progid:DXImageTransform.Microsoft.Matrix(M11=0.7071067811865476, M12=-0.7071067811865475, M21=0.7071067811865475, M22=0.7071067811865476, sizingMethod='auto expand');

  background-color: #eee;
  border: 1px solid #d3d3d3;
  border-right: 0;
  border-top: 0;
  content: '';
  position: absolute;
  right: -13px;
  top: 5px;
  height: 6px;
  width: 6px;
  z-index: 1;
  zoom: 1;
}
/*
 * Custom styles
 */
.btn {
  background-color: #fee6e6;
  border-color: #bbb;
  color: #666;
  font-weight: 600;
}
.btn:hover,
.btn.active {
  text-shadow: 0 1px 0 #b12f27;
  background-color: #f64136;
  border-color: #b12f27;
}
.btn:active { box-shadow: 0 0 5px 3px rgba(0,0,0,0.2) inset; }
.btn span { color: #f64136; }
.btn:hover, .btn:hover span,
.btn.active, .btn.active span { color: #eeeeee; }
.btn:active span {
  color: #b12f27;
  text-shadow: 0 1px 0 rgba(255,255,255,0.3);
}


</style>
</head>
<body style="background-color:#fdf5e6">
<div align="center">
<h2>符合學習興趣的學伴資料</h2>
<%-- <jsp:useBean id="companion" scope="request" class="com.project2.bean.CompanionBean" /> --%>
<!-- <form action="InsertCompanionByInterestDemo" method="post"> -->
<table border="1">
<tr style="background-color:#a8fefa">
<th>學伴編號<th>學生會員編號<th>學伴帳號名稱<th>學伴性別<th>學伴母語<th>學伴會說語言<th>學伴學習興趣<th>學伴學習頻率<th>學伴照片<th>是否配對
<% List<CompanionBean> companions = (ArrayList<CompanionBean>)request.getAttribute("companions");
SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSSSSSS");
SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
for(CompanionBean companion: companions){
	%>
<tr><td><%= companion.getCompanionId()%>
<td><%= companion.getStudentBeanID().getStudentId()%>
<td><%= companion.getStudentBeanID().getStudentNickname()%>
<td><%= companion.getStudentBeanID().getStudentGender()%>
<%-- <td><%= outputFormat.format(inputFormat.parse(companion.getCompanionBirth()))%> --%>
<%-- <td><%= companion.getCompanionBirth()%> --%>
<td><%= companion.getCompanionFirstLanguage()%>
<td><%= companion.getCompanionSpeakingLanguage()%>
<td><%= companion.getCompanionLearningInterest()%>
<td><%= companion.getCompanionLearningFrequency()%>
<td><img id ="img" src= "<%=request.getContextPath()%><%=companion.getStudentBeanID().getStudentPhoto()%>" alt=photo>
<td style="text-align: center;">

<form method="post" action="${pageContext.request.contextPath}/InsertCompanion">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<%-- <input type="hidden" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest"> --%>
<p>
  <button title="like" class="btn" data-count="0" type="submit" name="like_or_dislike" value="like"><span>&#x2764;</span> 申請配對</button>
</p>
<!-- <button name="like_or_dislike" value="like">❤</button> -->
</form>
<form method="post" action="${pageContext.request.contextPath}/InsertCompanion">
<input type="hidden" value="<%= companion.getCompanionId() %>" name="companion_id">
<%-- <input type="hidden" value="<%= companion.getCompanionLearningInterest() %>" name="companion_learning_interest"> --%>
<!-- <button name="like_or_dislike" value="dislike">✖</button> -->
<p>
  <button title="dislike" class="btn" data-count="0" type="submit" name="like_or_dislike" value="dislike"><span>&#128473;</span> 隱藏學伴</button>
</p>
</form>
</td>
<%} %>
</table>
<div><button class="index">回首頁</button></div>
<!-- </form> -->
</div>
<script>
const index = document.querySelector('.index')
index.addEventListener('click', function() {
	location.href = "/companionIndex.html"})
</script>
</body>
</html>