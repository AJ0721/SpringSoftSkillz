<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>學伴資料</title>
            
            <style>
#img {
	width: 160px;
	height: auto;
}

tr {
	text-align: center;
}

button {
	padding: 8px 20px;
	/* 按鈕內邊距 */
	margin-left: 0px;
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

.right {
	display: flex;
	align-items: center;
	/* 	justify-content: flex-end; */
	margin-left: 1190px;
}

.add {
	background-color: #dc3545;
	/* 回首頁按鈕的背景顏色 */
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

.add:hover {
	background-color: #c82333;
	/* 滑鼠懸停時的背景顏色 */
}

/* 表格整體風格 */
table {
	width: 100%;
	border-collapse: collapse;
	box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.2);
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
</style>
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<!--             使用 moment.js 在前端進行日期格式化 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
            
            <script>
                var indexPage = 1;

                $(document).ready(function() {
                    loadPage(indexPage);
                });

                function change(page) {
                    indexPage = page;
                    loadPage(indexPage);
                }
                
                function loadPage(indexPage) {
                	console.log("loadPage");
                    $.ajax({
                        type: 'get',
                        url: '/queryByPage/' + indexPage,
                        contentType: 'application/json',
                        success: function (data) {
                        	console.log("data : " + data);
                        	
                            $('#showproduct').empty("");

                            if (data == null) {
                                $('table').prepend('<tr><td>no result</td></tr>');
                            } else {
                                var table = $('#showproduct');
                                table.append("<tr id='ptitle'>" + "<th>學伴編號</th><th>學生會員編號</th><th>學伴帳號名稱</th><th>學伴性別</th><th>學伴生日</th><th>學伴母語</th><th>學伴會說語言</th><th>學伴學習興趣</th><th>學伴學習頻率</th><th>學伴照片</th>");

                                $.each(data, function (i, n) {
                                	<!--             使用 moment.js 在前端進行日期格式化 -->
                                	var birthDate = moment(n.studentBeanID.studentBirth, "YYYY-MM-DD HH:mm:ss.SSSSSSS");
                                    var formattedBirthDate = birthDate.format("YYYY-MM-DD");
                                    var tr = "<tr><td>" + n.companionId + "</td><td>" + n.studentBeanID.studentId + "</td><td>" + n.studentBeanID.studentNickname + "</td><td>" + n.studentBeanID.studentGender + "</td><td>" + formattedBirthDate + "</td><td>"+ n.companionFirstLanguage + "</td><td>"+ n.companionSpeakingLanguage + "</td><td>"+ n.companionLearningInterest + "</td><td>"+ n.companionLearningFrequency + "</td><td><img id='img' src="+ n.studentBeanID.studentPhoto + "></td></tr>";
                                    table.append(tr);
                                });
                            }
                        }
                    });
                }
            </script>
        </head>

        <body>
            <div id="productListTitle" align="center"><h2>學伴資料</h2></div>
            <table id="showproduct" border="1"></table>
            <table id="showpage">
                <tr>
                    <td>Total Pages: ${totalPages} totalRecords: ${totalElements}</td>
                    <td colspan="2" align="right">Previous
                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                            <button id="myPage" type="button" onclick="change(${i})">${i}</button>
                        </c:forEach>Next
                    </td>
                </tr>
            </table>
	<div align="center" style="margin:30px">
		<form method="get" action="../GetAllCompanions">
			<button class="selectAll" type="submit">顯示全部資料</button>
		</form>
	<div><a href="/companionIndex.html" style="text-decoration: none;"><button class="index">回首頁</button></a></div>
	</div>

        </body>

        </html>