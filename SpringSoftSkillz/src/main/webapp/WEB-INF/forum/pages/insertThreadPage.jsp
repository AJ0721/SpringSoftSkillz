<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.softskillz.forum.model.ForumThreadBean"%>
<%@ page import="com.softskillz.forum.model.ForumCategoryBean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/basicStyle.css">


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
				action="${pageContext.request.contextPath}/forum.doinsertthread.controller"
				method="post">
				<input type="hidden" name="threadId" value="${editThread.threadId}">
				<div>
					
					<label for="category">分類:</label>
						<select id="category" name="category">
							<option value="">請選擇文章分類</option>
						<c:forEach items="${forumCategoryBeans}" var="category">
							<option value="${category.forumCategoryId}">
							${category.forumCategoryId} ${category.forumCategoryName}
							</option>
					</c:forEach>
					</select>
				</div>
				<div>
					<label for="title">標題:</label> 
					<input type="text" id="title"
						name="title" value="" required>
				</div>
				<div>
					<label for="content">內文:</label>
					<textarea id="content" name="content" required></textarea>
				</div>
		</div>

		<div class="btncontainer">
			<a
				href="${pageContext.request.contextPath}/forum.mythreadspage.controller">
				<button class="opbtn" type="button">取消</button>
			</a>

			<button class="opbtn" type="submit">提交</button>
			</form>


		</div>
	</article>
</body>
</html>
