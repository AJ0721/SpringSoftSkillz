<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.softskillz.forum.model.ForumThreadBean"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/forum/css/basicStyle.css">

<article>

	<title>搜尋結果</title>
</head>
<body>
	<div class="opbtn">
		<a href="${pageContext.request.contextPath}/forumhome.controller"><button>論壇首頁</button></a>
	</div>
	<h2 class="title">搜尋結果</h2>


	<table>
		<tr>
			<th class="tlength">文章標題</th>
			<th>內文</th>
		</tr>
		<c:choose>
			<c:when test="${not empty threads}">

				<c:forEach items="${threads}" var="thread">
					<tr>
						<td><a
							href="${pageContext.request.contextPath}/forum/${thread.forumCategoryBean.forumCategoryName}/thread/${thread.threadId}">${thread.threadTitle}</a></td>
						<td>${thread.threadContent}</td>
					</tr>

				</c:forEach>
			</c:when>

			<c:otherwise>
				<tr>
					<td colspan="2">查無相關結果。</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>

</body>
</article>
</html>
