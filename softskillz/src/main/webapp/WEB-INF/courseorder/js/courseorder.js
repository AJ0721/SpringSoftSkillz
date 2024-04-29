window.onload = () => {
    // const orders = sessionStorage.getItem("orders");
    const orders = "";
    if (orders) {
        appendorder(JSON.parse(orders));
    } else {
        getAllOrders();
    }
}

function getAllOrders() {
    fetch("/courseorder")
        .then(response => {
            console.log(response);
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let orders = JSON.stringify(data);
            sessionStorage.setItem("orders", orders)
            appendorder(data);
        })
}



function cancel(button) {
    let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
    let data = {
        orderID: orderID
    }
    fetch("/courseorder/" + orderID, {
        method: "put",
        headers: { "Content-Type": "application/json" },
    }).then(response => {
        if (response.ok) {
            getAllOrders();

        }
    })
        .catch(error => {
            console.log(error);
        });
};

function appendorder(data) {
    let tbody = document.querySelector("tbody");
    tbody.innerHTML = "";
    console.log(data);
    for (let key in data) {
        let row = document.createElement("tr");
        let date = new Date(data[key].orderDate);
        let date2 = new Date(data[key].cancelDate);
        let isPaid = data[key].orderStatus !== '未付款';

        row.innerHTML = "<td class='orderID'>" + data[key].orderID + "</td>"
            + "<td>" + data[key].orderPrice + "</td>"
            + "<td>" + date.toLocaleString('sv') + "</td>"
            + "<td>" + date2.toLocaleString('sv') + "</td>"
            + "<td>" + data[key].paymentMethod + "</td>"
            + "<td>" + data[key].orderStatus + "</td>"
            + "<td><a href='/courseorder/" + data[key].orderID + "'>詳細</a></td>"
            + "<td><button class='cancel' onclick='cancel(this)'>取消</button></td>"
            + "<td><button class='pay' onclick='toPayPage(this)' " + (isPaid ? "hidden " : "") + ">付款</button></td>";
        tbody.appendChild(row);
    }
}






function toPayPage(button) {
    let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;
    window.location.href = "/courseorder/pay?orderID=" + orderID;
}

function toPay(button) {
    let orderID = button.parentNode.parentNode.querySelector(".orderID").textContent;

    fetch("/LinePayReqAfter/" + orderID, {
        method: "post",
        headers: { "Content-Type": "application/json" },
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