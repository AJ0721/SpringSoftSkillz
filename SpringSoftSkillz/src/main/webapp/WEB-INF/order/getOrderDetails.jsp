<%@page import="com.softskillz.order.model.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查詢結果</title>
</head>
<body>
<jsp:useBean id="order" scope="request" class="com.softskillz.order.model.OrderBean" />
<p>訂單編號: <%= order.getOrderId() %></p>
<p>學生編號: <%= order.getStudentId() %></p>
<p>訂單時間: <%= order.getOrderDate() %></p>
<p>訂單金額: <%= order.getTotalAmount() %></p>
<p>訂單狀態: <%= order.getOrderStatus() %></p>
<p>收貨地址: <%= order.getShippingAddress() %></p>

</body>
     <div class="button-group">
        <a href="${pageContext.request.contextPath}/showOrder/getOrder">返回訂單管理</a>
    	</div> 
</html>