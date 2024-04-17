<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.softskillz.forum.model.ForumThreadBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/forum/css/basicStyle.css">
<style>
.thread {
	background-color: #fff;
	border-radius: 15px;
	padding: 15px;
	margin-top: 15px;
}

.threadTitle {
	margin: 20px 0 20px 0;
	border-radius: 15px;
	font-size: large;
	font-weight: bold;
}

.tcontent {
	margin: 20px 0 10px 0;
}
</style>
<title>${thread.threadTitle}</title>
</head>
<body>
	<article>

		<div class="opbtn">
			<a href="${pageContext.request.contextPath}/forumhome.controller"><button>論壇首頁</button></a>
		</div>


		<a
			href="${pageContext.request.contextPath}/forum/mythreads/${username}"><button
				class="opbtn" type="button">我的文章</button></a>



		<div class="thread">
			<h1>${threadNotFound}</h1>
			<h1 class="threadTitle">${thread.threadTitle}</h1>

			<p class="tcontent">${thread.threadContent}</p>

		</div>


	</article>
</body>

</html>
