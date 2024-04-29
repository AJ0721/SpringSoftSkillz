document.addEventListener("DOMContentLoaded", function () {
	let selects = document.querySelectorAll(".quantity");
	selects.forEach(function (select) {
		let subtotal = select.parentNode.parentNode
			.querySelector(".subtotal");
		subtotal.textContent = "NT$" + select.value;
		updateTotal();
	});
});


function change(select) {
	let subtotal = select.parentNode.parentNode
		.querySelector(".subtotal");
	subtotal.textContent = "NT$" + select.value;
	updateTotal();
	let cartItemId = select.parentNode.parentNode.querySelector(".cartitemid").value;
	let quantity = select.value;
	let data = {
		cartItemId: cartItemId,
		quantity: quantity
	};
	fetch("/coursecart/updateCart", {
		method: "post",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).catch(error => {
		console.error("Error updating cart:", error);
	});
}

function updateTotal() {
	let total = 0;
	let selects = document.querySelectorAll(".quantity");
	let tot = document.querySelector(".total")
	selects.forEach(function (select) {
		total += parseFloat(select.value);
	});

	tot.innerHTML = "總金額:" + total;
};


function remove(button) {
	let cartItemId = button.parentNode.parentNode.querySelector(".cartitemid").value;
	console.log(cartItemId)
	let data = {
		cartItemId: cartItemId,
	};
	console.log(cartItemId)
	fetch("/coursecart/removeCart", {
		method: "post",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then((respone) => {
		if (respone.ok) {
			window.location.href = "Cart.do"
		} else {
			console.error("Failed to remove item from cart. Status:", response.status);
		}
	})
		.catch(error => {
			console.error("Error removing item from cart:", error);
		});
}

function toOrder(button) {
	updateTotal();
	let totalText = document.querySelector(".total").textContent;
	let total = totalText.split(':')[1].trim();
	let data = {
		total: total,
	};
	console.log(total);
	fetch("/LinePayReq", {
		method: "post",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then((respone) => {
		if (respone.ok) {
			console.log(respone)
			return respone.json()
		} else {
			console.error("Failed to remove item from cart. Status:", response.status);
		}
	}).then(data => {
		window.location.href = data;
	})
		.catch(error => {
			console.error("Error removing item from cart:", error);
		});
}

function toOrder2(button) {
	updateTotal();
	let totalText = document.querySelector(".total").textContent;
	let total = totalText.split(':')[1].trim();
	let data = {
		total: total,
	};
	console.log(total);
	fetch("/courseorder", {
		method: "post",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(data)
	}).then((respone) => {
		if (respone.ok) {
			return respone.text();
		} else {
			console.error("Failed to remove item from cart. Status:", response.status);
		}
	}).then(data => {
		console.log(data);
		window.location.href = "/courseorder/pay?orderID=" + data;
	})
		.catch(error => {
			console.error("Error removing item from cart:", error);
		});

}