fetch('/html/backtest.html')
	.then(response => response.text())
	.then(data => {
		document.querySelector('#header').innerHTML = data;
	})
	.catch(error => console.error('頁首內容加載錯誤:', error));



function cancel(button) {
	let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
	let data = {
		orderID: orderID
	}
	fetch("/adminorder/" + orderID, {
		method: "put",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then(response => {
		if (response.ok) {
			window.location.href = "/adminorder/adorder.do"
		}
	})
		.catch(error => {
			console.log(error);
		});
}
function delOrder(button) {
	let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
	let data = {
		orderID: orderID
	}
	fetch("/adminorder/" + orderID, {
		method: "delete",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then(response => {
		if (response.ok) {
			window.location.href = "/adminorder/adorder.do"
		}
	})
		.catch(error => {
			console.log(error);
		});
}
function selectAll() {
	fetch("/adminorder/clearDate", {
		method: "get",
		headers: { "Content-Type": "application/json" },
	}).then(response => {
		if (response.ok) {
			window.location.href = "/adminorder/adorder.do";
		}
	})
		.catch(error => {
			console.log(error);
		});
}

function getDate1() {
	let date1 = document.querySelector("#date1").value;
	let date2 = document.querySelector("#date2").value;
	console.log(date2)

	let data = {
		date1: date1,
		date2: date2
	}
	fetch("/adminorder/date", {
		method: "post",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then(response => {
		if (response.ok) {
			return response.json();
		}
	}).then(data => {
		appendorder(data);
	})
		.catch(error => {
			console.log(error);
		});
}

function goBack() {
	window.history.back();
}

function appendorder(data) {
	let tbody = document.querySelector("tbody");
	tbody.innerHTML = "";
	for (let key in data) {
		let row = document.createElement("tr");
		let date = new Date(data[key].orderDate);
		row.innerHTML =
			"<td class='orderID'>" + data[key].orderID + "</td>" +
			"<td>" + data[key].studentID + "</td>" +
			"<td>" + data[key].orderPrice + "</td>" +
			"<td>" + date.toLocaleString("sv") + "</td>" +
			"<td>" + data[key].paymentMethod + "</td>" +
			"<td>" + data[key].orderStatus + "</td>" +
			"<td><a href='/adminorder/" + data[key].orderID + "'><button class='custom-button'>詳細</button></a></td>" +
			"<td><button class='custom-button cancel' onclick='cancel(this)'>取消</button></td>" +
			"<td><button class='custom-button cancel' onclick='delOrder(this)'>刪除</button></td>";

		tbody.appendChild(row);
	}
}


function allorders() {
	fetch("/adminorder")
		.then(response => {
			console.log(response);
			if (response.ok) {
				return response.json();
			}
		}).then(data => {
			console.log(data);
			let orders = JSON.stringify(data);
			sessionStorage.setItem("orders", orders)
			appendorder(data);
		})
	window.onload = () => {
		const orders = sessionStorage.getItem("orders");
		if (orders) {
			appendorder(JSON.parse(orders));
		} else {
			allorders();
		}
	}
}


