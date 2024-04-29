<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/8f15672443.js"
	crossorigin="anonymous"></script>
<script src="/courseorder/js/fetch.js"></script>
<link rel="stylesheet" href="/courseorder/css/reset.css">
<link rel="stylesheet" href="/courseorder/css/bar.css">
<link rel="stylesheet" href="/courseorder/css/tablefotcart.css">

<title>${course.courseName}</title>
</head>
<style>
    .header {
        background-image: url(/img/xxx.jpg);
        max-width: 100%;
        height: 420px;
        background-repeat: no-repeat;
        background-size: cover;
        background-position: center center;

        .text {
            text-align: center;
        }
    }

</style>
<body>
	<div id="fetch"></div>
	<form id="form">
		<table>
			<thead>
				<tr>
					<th>課程ID</th>
					<th>教師名稱</th>
					<th>教師名稱</th>
					<th>課程名稱</th>
					<th>課程說明</th>
					<th>科目</th>
					<th>價格</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="cid">${course.courseID}</td>
					<td><img src="../../${course.teacherPhoto}"></td>
					<td>${course.teacherName}</td>
					<td>${course.courseName}</td>
					<td>${course.courseInfo}</td>
					<td>${course.courseCategory}</td>
					<td><select id="quantity">
							<option value="1">1*NT${course.price}/堂</option>
							<option value="5">5*NT${course.price}/堂</option>
							<option value="10">10*NT${course.price}/堂</option>
							<option value="20">20*NT${course.price}/堂</option>
					</select></td>
				</tr>
			</tbody>
			<tfoot>
				<td colspan="5" align="center"><a href="/courses/course.do"><button
							type="button">返回</button></a></td>
				<td colspan="2" align="center"><button id="send">加入購物車</button></td>
			</tfoot>
		</table>
	</form>


	<script>

			let send = document.querySelector("#send");

			send.addEventListener("click", function (e) {
				let quantity = document.querySelector("#quantity").value;
				let cid = document.querySelector("#cid").textContent;
				e.preventDefault();
				let data = {
					'cid': cid,
					'quantity': quantity
				};

				fetch('/coursecart/addToCart', {
					method: 'post',
					headers: { 'Content-Type': 'application/json' },
					body: JSON.stringify(data)
				}).then(response => {
					if (response.ok) {
						window.location.href = "/coursecart/Cart.do"
					}
				})
			})
fetch("/courseorder/html/testiframe3.html")
    .then(response => {
        if (response.ok) {
            return response.text();
        }
    }).then(data => {
        document.querySelector('#fetch').innerHTML = data;
    })


		</script>

</body>

</html>