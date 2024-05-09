<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>管理員帳號管理</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
.bottom-link {
	margin-top: 20px;
	display: block;
	text-decoration: none;
	color: #4285f4;
	font-size: 16px;
}

/* 調整表格邊框和間隙 */
table {
	border: #000;
	/* 讓表格的邊框合併為單一邊框 */
	margin: auto;
	/* 讓表格在頁面中水平居中 */
	padding: 10px 25px;
	/* 上下為10px，左右為20px */
	text-align: center;
	/* 讓文字在欄位中居中顯示 */
}

.crud-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.1);
	width: 80%;
	max-width: 1000px;
	margin: 40px auto;
	/*    margin-left: 300px; */
	text-align: center;
}

th {
	padding: 5px 20px;
	background-color: #606a92;
	color: #ffffff;
	width: 150px;
	white-space: nowrap /* 上下為10px，左右為20px */
}

td {
	padding: 5px;
	/* 上下為10px，左右為20px */
}
</style>
<script>
				//這裡的indexPage全域變數
                //var indexPage = 1;
				//html讀取頁面
                $(function () {
                	//這裡的indexPage區域變數
                    loadPage(1);
                }); 
				
                function change(page) {
                    //indexPage = page;
                    loadPage(page);
                }

                function loadPage(inputPage) {
                    $.ajax({
                        type: 'get',
                        url: '/admin/AdminQueryByPage/' + inputPage,
                        contentType: 'application/json',
                        success: function (data) {
                        	console.log(data)
                            $('#showAdmin').empty("");

                            if (data == null) {
                                $('showAdmin').prepend('<tr><td>沒有資料</td></tr>');
                            } else {
                                var table = $('#showAdmin');
                                table.append("<tr id='adminHead'>" + "<th>管理員ID</th><th>管理員帳號</th><th>管理員密碼</th><th>管理員層級</th><th>修改</th><th>刪除</th>");

                                $.each(data, function (i, n) {
                                    var tr = "<tr><td>" + n.adminId + "</td><td>" + n.adminAccount + "</td><td>" + n.adminPassword + "</td><td>" + n.adminLevel + "</td>"+
        							"<td>"+
    								'<form action="/admin/AdminUpdate" method="post">'+
    									'<input type="hidden" name="_method" value="put">'+ 
    									'<input type="hidden" name="adminId" value="'+n.adminId + '" />'+
    									'<select name="adminLevel">'+
    										'<option value="1">Level 1</option>'+
    										'<option value="2">Level 2</option>'+
    										'<option value="4">Level 4</option>'+
    										'<option value="3" selected>Level 3</option>'+
    										'<option value="5">Level 5</option>'+
    										'<option value="6">Level 6</option>'+
    										'<option value="7">Level 7</option>'+
    										<!-- 添加更多層級選項 -->
    									'</select> <input type="submit" value="修改層級" />'+
    								'</form>'+ 
    								'</td>'+
    								'<td>'+
    								'<form action="/admin/AdminDelete" method="post">'+
    									'<input type="hidden" name="_method" value="delete">'+ 
    								'<input type="hidden" name="adminId" value="'+n.adminId+'" />'+
    									'<button type="submit">刪除</button>'+
    								'</form>'+
    							'</td>'+
    								'</tr>';
                                    table.append(tr);
                                });
                            }
                        }
                    });
                }
            </script>
</head>

<body style='background-color: #919fc6'>
	<jsp:include page="/WEB-INF/account/homepage/BackendPage.jsp" />
	<div id="header"></div>
	<section style="padding: 20px; text-align: center; margin-left: 170px;">
		<div class="crud-container" align="center">
			<h2>管理員帳號管理</h2>
			<table>
				<tr>
					<td>
						<form method="get" action="/admin/AdminSelectOne">
							管理員ID搜尋：<input type="text" name="admin_id"></input>&nbsp;&nbsp; <input
								type="submit" value="搜尋"></input>
						</form>
					</td>
					<td>
						<form method="get" action="/admin/AdminSelectAll">
							<input type="submit" value="搜尋全部"></input>
						</form>
					</td>
				</tr>
			</table>
			<table id="showAdmin" border="1"></table>
			<table id="showpage">
				<tr>
					<td>Total Pages: ${totalPages} totalRecords: ${totalElements}</td>
					<td colspan="3" align="right">Previous <c:forEach var="i"
							begin="1" end="${totalPages}" step="1">
							<button id="myPage" type="button" onclick="change(${i})">${i}</button>
						</c:forEach>Next
					</td>
				</tr>
			</table>
	</section>
</body>