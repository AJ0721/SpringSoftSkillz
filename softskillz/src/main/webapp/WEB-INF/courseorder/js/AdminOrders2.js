let date1 = "";
let date2 = "";
let url = "/adminorder";
window.onload = () => {
	const orders = sessionStorage.getItem("orders");
	console.log(orders);
	if (orders) {
		appendorder(JSON.parse(orders));
	} else {
		allorders();
	}
}

function allorders() {
	date1 = "";
	date2 = "";
	url = "/adminorder";
	sessionStorage.clear();
	fetch(url)
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
}

function getDate1() {

	date1 = document.querySelector("#date1").value.replace(/-/g, "");
	date2 = document.querySelector("#date2").value.replace(/-/g, "");
	sessionStorage.setItem("date1", date1);
	sessionStorage.setItem("date2", date2);
	url = "/adminorder" + "/" + date1 + "/" + date2;
	sessionStorage.setItem
	getOrderByDate();
}

function getOrderByDate() {
	fetch(url).then(response => {
		if (response.ok) {
			return response.json();
		}
	}).then(data => {
		let orders = JSON.stringify(data);
		sessionStorage.setItem("orders", orders)
		appendorder(data);
	}).catch(error => {
		console.log(error);
	});
}

function cancel(button) {
	let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
	fetch("/adminorder/" + orderID, {
		method: "put",
		headers: { "Content-Type": "application/json" },
	}).then(response => {
		if (response.ok) {
			date1 = sessionStorage.getItem("date1");
			date2 = sessionStorage.getItem("date2");
			if (date1 && date2) {
				console.log("d1=" + date1, "d2=" + date2)
				getOrderByDate();
			} else {
				allorders();
			}
		}
	})
		.catch(error => {
			console.log(error);
		});
}

function delOrder(button) {
	let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
	fetch("/adminorder/" + orderID, {
		method: "delete",
		headers: { "Content-Type": "application/json" },
	}).then(response => {
		if (response.ok) {
			if (date1 && date2) {
				console.log("d1=" + date1, "d2=" + date2)
				getOrderByDate();
			} else {
				allorders();
			}
		}
	}).catch(error => {
		console.log(error);
	});
}

function appendorder(data) {
	let tbody = document.querySelector("tbody");
	tbody.innerHTML = "";
	for (let key in data) {
		let row = document.createElement("tr");
		let date = new Date(data[key].orderDate);
		let date2 = new Date(data[key].cancelDate);
		row.innerHTML =
			"<td class='orderID'>" + data[key].orderID + "</td>" +
			"<td>" + data[key].studentID + "</td>" +
			"<td>" + data[key].orderPrice + "</td>" +
			"<td>" + date.toLocaleString("sv") + "</td>" +
			"<td>" + date2.toLocaleString('sv') + "</td>" +
			"<td>" + data[key].paymentMethod + "</td>" +
			"<td>" + data[key].orderStatus + "</td>" +
			"<td><a href='/adminorder/" + data[key].orderID + "'><button class='custom-button'>詳細</button></a></td>" +
			"<td><button class='custom-button cancel' onclick='cancel(this)'>取消</button></td>" +
			"<td><button class='custom-button cancel' onclick='delOrder(this)'>刪除</button></td>";

		tbody.appendChild(row);
	}
}

function selectAll() {
	fetch("/adminorder/clearDate", {
		method: "get",
		headers: { "Content-Type": "application/json" },
	}).then(response => {
		if (response.ok) {
			window.location.href = "/adminorder/adorder.do";
		}
	}).catch(error => {
		console.log(error);
	});
}




fetch('/html/backtest.html')
	.then(response => response.text())
	.then(data => {
		document.querySelector('#header').innerHTML = data;
	})
	.catch(error => console.error('頁首內容加載錯誤:', error));


function goBack() {
	window.history.back();
}

