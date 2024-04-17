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
textarea {
	height: 80%;
	display: flex;
	justify-content: left;
	width: 100%;
	margin: auto;
	padding: 10px;
	margin-bottom: 10px;
}
</style>
<title>編輯文章</title>
</head>
<body>
	<article>


		<h2 class="title">編輯文章</h2>

		<div class="threadContainer">
			<form
				action="${pageContext.request.contextPath}/forum.updatethread.controller"
				method="post">
				<input type="hidden" name="threadId" value="${editThread.threadId}">
				<div>
					<label for="category">分類:</label> <span id="category"
						name="category" value="${editThread.forumCategoryBean.forumCategoryName }" readonly>
						${editThread.forumCategoryBean.forumCategoryName } </span>
				</div>
				<div>
					<label for="title">標題:</label> <input type="text" id="title"
						name="title" value="${editThread.threadTitle}" required>
				</div>
				<div>
					<label for="content">內文:</label>
					<textarea id="content" name="content" required>${editThread.threadContent}</textarea>
				</div>
		</div>

		<div class="btncontainer">
			<a href="${pageContext.request.contextPath}/forum/mythreads/${username}">
				<button class="opbtn" type="button">取消</button>
			</a>

			<button class="opbtn" type="submit">提交</button>
			</form>


		</div>
	</article>
</body>
</html>
