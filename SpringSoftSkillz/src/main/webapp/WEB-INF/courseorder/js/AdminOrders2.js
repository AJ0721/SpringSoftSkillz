function cancel(button) {
		let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
		let data = {
			orderID: orderID
		}
		fetch("cancelORD", {
			method: "post",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(data)
		}).then(response => {
			if (response.ok) {
				window.location.href = "Order.admin"
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
		fetch("deleteORD", {
			method: "post",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(data)
		}).then(response => {
			if (response.ok) {
				window.location.href = "Order.admin"
			}
		})
			.catch(error => {
				console.log(error);
			});
	}



	function tbodyApend(data) {
		let tbody = document.querySelector("tbody");
		tbody.innerHTML = "";
		console.log(data[0])
		for (var key in data) {
			console.log("Key: " + key + ", Value: " + data[key].orderID);
			let row = document.createElement("tr");
			let date = new Date(data[key].orderDate);
			row.innerHTML = "<td>" + data[key].orderID + "</td>"
				+ "<td>" + data[key].studentID + "</td>"
				+ "<td>" + data[key].orderPrice + "</td>"
				+ "<td>" + date.toLocaleString('sv') + "</td>"
				+ "<td>" + data[key].paymentMethod + "</td>"
				+ "<td>" + data[key].orderStatus + "</td>"
				+ "<td><a href='../../CourseDetail?courseid="
				+ data[key].orderID + "'>詳細</a></td>";
			tbody.appendChild(row);
		}
	}



	function goBack() {
		window.history.back();
	}

	function getDate1() {
			let date1 = document.querySelector("#date1").value;
			let date2 = document.querySelector("#date2").value;
			console.log(date2)

			let data = {
				date1: date1,
				date2: date2
			}

			fetch("dateSelectOrder", {
				method: "post",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(data)
			}).then(response => {
				if (response.ok) {
					window.location.href="Order.admin";
				}
			})
				.catch(error => {
					console.log(error);
				});
		}
	function selectAll(){
		fetch("clearDate", {
			method: "get",
			headers: { "Content-Type": "application/json" },
		}).then(response => {
			if (response.ok) {
				window.location.href="Order.admin";
			}
		})
			.catch(error => {
				console.log(error);
			});
	}/**
 * 
 */