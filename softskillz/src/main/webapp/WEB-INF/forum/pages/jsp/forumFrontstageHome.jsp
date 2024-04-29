<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.softskillz.forum.model.ForumThreadModel"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/forum/css/basicStyle.css">


<style>
.welcome {
	text-align: right;
	margin-right: 10px;
}

.search {
	padding: 5px;
	font-size: 16px;
	margin: auto;
	width: 85%;
	border-radius: 16px;
	border: #f3e7ca;
	display: flex;
}

.searchbar {
	margin-top: 10px;
}
</style>
<title>論壇首頁</title>
</head>
<body class="pageBgColor">


	<article>
		<h5 class="welcome">
			歡迎,

			<c:choose>
				<c:when test="${student != null }">					
					${student.studentUsername }
				</c:when>
				<c:when test="${teacher != null }">
					${teacher.teacherUserName }
				</c:when>
				<c:otherwise>
					${"訪客"}
				</c:otherwise>
			</c:choose>

		</h5>

		<div class="searchbar">
			<form
				action="/forum.searchkeyword.controller"
				method="get" class="search">
				<label for="search"></label> <input class="search" type="text"
					name="search" id="search" placeholder="請輸入關鍵字">
				<button type="submit" style="margin-left: 2px;">搜尋</button>
			</form>
		</div>
		<h2 class="title">論壇</h2>

		<div class="btncontainer">
			<a href="${pageContext.request.contextPath}/forum/newthread/${username}">
				<button class="opbtn">我要發文</button>
			</a>
		</div>

		<div class="btncontainer">
			<a
				href="${pageContext.request.contextPath}/forum/mythreads/${username}"><button
					class="opbtn" type="button">我的文章</button></a>
		</div>
	</article>
</body>
</html>
