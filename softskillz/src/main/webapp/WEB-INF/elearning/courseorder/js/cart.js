window.addEventListener("load",() => {
    getCartItem();
  })

  function getCartItem() {
    fetch("/coursecart")
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      }).then(data => {
        console.log(data);
        appendCart(data);
        updateTotal();

      })
  }

  function appendCart(data) {
    let cartitem = document.querySelector("#cartitem");
    cartitem.innerHTML = "";
    for (let key in data) {
      let row = document.createElement("tr");
      let selectedOption1 = data[key].quantity == 1 ? 'selected' : '';
      let selectedOption5 = data[key].quantity == 5 ? 'selected' : '';
      let selectedOption10 = data[key].quantity == 10 ? 'selected' : '';
      let selectedOption20 = data[key].quantity == 20 ? 'selected' : '';
      row.innerHTML =
        "<td class='text-center align-middle'><img class='img-fluid' src='/teacher/images/" + data[key].course.teacherPhoto + "'></td>" +
        "<td class='text-center align-middle'>" + data[key].course.teacherName + "</td>" +
        "<td class='text-center align-middle'>" + data[key].course.courseName + "</td>" +
        "<td class='text-center align-middle'>" + data[key].course.courseInfo + "</td>" +
        "<td class='text-center align-middle'>" + data[key].course.courseCategory + "</td>" +
        "<td class='text-center align-middle' style='display: none;'><input type='hidden' class='cartitemid' value='" + key + "'>" +
        "<td style='display: none;''><input type='hidden' class='cartitemid' value='" + key + "'>" +
        "<td class='text-center align-middle'><select name='quantity' class='quantity form-select'  >" +
        "<option value='" + 1 * data[key].course.price + "' " + selectedOption1 + ">1*NT" + data[key].course.price + "/堂</option>" +
        "<option value='" + 5 * Math.ceil(data[key].course.price * 95 / 100) + "' " + selectedOption5 + ">5*NT" + Math.ceil(data[key].course.price * 95 / 100) + "/堂</option>" +
        "<option value='" + 10 * Math.ceil(data[key].course.price * 90 / 100) + "' " + selectedOption10 + ">10*NT" + Math.ceil(data[key].course.price * 90 / 100) + "/堂</option>" +
        "<option value='" + 20 * Math.ceil(data[key].course.price * 85 / 100) + "' " + selectedOption20 + ">20*NT" + Math.ceil(data[key].course.price * 85 / 100) + "/堂</option>" +
        "</select></td>" +
        "<td class='subtotal text-center align-middle'>NT$" + getSubtotal(data[key].course.price, data[key].quantity) + "</td>" +
        "<td class='delBtn text-center align-middle'><span><i class='fa-solid fa-xmark'></i></span></td>";

      cartitem.appendChild(row);

      let select = row.querySelector(".quantity");
      select.addEventListener("change", change);
      let delBtn = document.querySelector(".delBtn")
      delBtn.addEventListener("click", remove)
    }
  }

  function getSubtotal(pricePerUnit, quantity) {
    let price1 = 1 * pricePerUnit;
    let price5 = 5 * Math.ceil(pricePerUnit * 95 / 100);
    let price10 = 10 * Math.ceil(pricePerUnit * 90 / 100);
    let price20 = 20 * Math.ceil(pricePerUnit * 85 / 100);

    let selectedPrice;
    if (quantity == 1) selectedPrice = price1;
    if (quantity == 5) selectedPrice = price5;
    if (quantity == 10) selectedPrice = price10;
    if (quantity == 20) selectedPrice = price20;

    return selectedPrice;
  }

  function change(e) {
    let select = e.target;
    let row = select.closest("tr");
    let subtotal = row.querySelector(".subtotal");
    subtotal.innerText = "NT$" + select.value;

    let cartItemId = row.querySelector(".cartitemid").value;
    let qtyText = select.options[select.selectedIndex].innerHTML.split("*");
    let quantity = qtyText[0].trim();
    fetch("/coursecart/" + cartItemId + "/" + quantity, {
      method: "put",
      headers: { "Content-Type": "application/json" },
    }).catch(error => {
      console.error("Error updating cart:", error);
    });

    updateTotal();
  }


  function updateTotal() {
    let total = 0;
    let selects = document.querySelectorAll(".quantity");
    let tot = document.querySelector(".total")
    selects.forEach(function (select) {
      total += parseFloat(select.value);
    });

    tot.innerHTML = 'NT$' + total;
  };


  function remove(e) {
    let row = e.target.closest("tr");
    let cartItemId = row.querySelector(".cartitemid").value;
    console.log(cartItemId)
    let data = {
      cartItemId: cartItemId,
    };
    console.log(cartItemId)
    fetch("/coursecart/" + cartItemId, {
      method: "delete",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data)
    }).then((respone) => {
      if (respone.ok) {
        getCartItem();
      } else {
        console.error("Failed to remove item from cart. Status:", response.status);
      }
    })
      .catch(error => {
        console.error("Error removing item from cart:", error);
      });
  }


  function toOrder2() {
    updateTotal();
    let totalText = document.querySelector(".total").textContent;
    console.log(totalText);
    let total = totalText.slice(3);

    console.log(total);
    fetch("/courseorder/" + total, {
      method: "post",
      headers: { "Content-Type": "application/json" },
    }).then((respone) => {
      if (respone.ok) {
        return respone.text();
      } else {
        console.error("Failed to remove item from cart. Status:", response.status);
      }
    }).then(data => {
      console.log(data);
      window.location.href = "/courseorder/orderdetail?orderID=" + data;
    })
      .catch(error => {
        console.error("Error removing item from cart:", error);
      });

  }

  let checkout = document.querySelector("#checkout");
  checkout.addEventListener("click", toOrder2)