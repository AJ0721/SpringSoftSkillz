<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.softskillz.forum.model.ForumThreadBean"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/forum/css/basicStyle.css">


<title>我的文章</title>
<style>
</style>
</head>
<body>
	<article>
		<div class="opbtn">
			<a href="${pageContext.request.contextPath}/forumhome.controller"><button type="button">論壇首頁</button></a>
		</div>
		<h2 class="title">我的文章</h2>


		<c:choose>
			<c:when test="${empty threads}">
				<p>您目前沒有文章。</p>
			</c:when>
			<c:otherwise>
			
		<c:if test="${not empty success}">
			<div class="alert">${success}</div>
		</c:if>
		<c:if test="${not empty updateFailed}">
			<div class="alert">${updateFailed}</div>
		</c:if>
		<c:if test="${not empty threadNotFound}">
			<div class="alert">${threadNotFound}</div>
		</c:if>
		

				<table>
					<tr>
						<th>標題</th>
						<th>編輯</th>
						<th>刪除</th>
					</tr>

					<c:forEach items="${threads}" var="thread">

						<tr>
							<td><a
								href="${ pageContext.request.contextPath}/forum/${thread.forumCategoryBean.forumCategoryName}/thread/${thread.threadId}">
								${thread.threadTitle}
								</a></td>
							<td><a
								href="${pageContext.request.contextPath}/forum/updatethread/${thread.threadId}">
									<button type="button">編輯</button>
							</a></td>
							<td>
								<form
									action="${pageContext.request.contextPath}/forum.deletethread.controller?threadId=${thread.threadId}"
									method="post">
									<input type="hidden" name="threadId" value="${thread.threadId}">
									<button type="submit">刪除</button>
								</form>

							</td>
						</tr>
					</c:forEach>

				</table>
			</c:otherwise>
		</c:choose>

	</article>
</body>


</html>


