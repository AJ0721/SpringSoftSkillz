let total = 0;
    let coupon = document.querySelector("#coupon");
    let orderID = "";
    window.addEventListener("load",() => {
      const queryString = window.location.search;
      const urlParams = new URLSearchParams(queryString);
      orderID = urlParams.get("orderID");
      console.log(orderID);
      let details = document.querySelector("#details");
      details.innerHTML = "";
      fetch("/courseorder/payitem/" + orderID)
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
            console.error("Failed to remove item from cart. Status:", response.status);
          }
        }).then(data => {
          console.log(data[0]);
          document.querySelector("#orderID").innerHTML = "訂單編號 : " + orderID;
          for (let key in data) {
            let div = document.createElement("div");
            div.className = "row";
            div.innerHTML =
              ` <div class="col-md-8 col-lg-9">
                  <p class="mb-0">${data[key].courseName}</p>
                </div>
                <div class="col-md-4 col-lg-3">
                  <p class="mb-0">${data[key].qty} x NT$${data[key].disPrice} = NT$${data[key].disPrice * data[key].qty}</p>`
            details.appendChild(div);
            total += data[key].disPrice * data[key].qty;
          }
          document.querySelector("#total").innerHTML = "NT$ " + total;

        }).catch(error => {
          console.log(error);
        });

      getDiscount()
    })

    function toPay() {
      let coupon = document.querySelector("#coupon");
      let dis = "";
      if (coupon.selectedIndex != 0) {
        let disText = coupon.options[coupon.selectedIndex].innerHTML.split(":");
        dis = disText[0].trim()
      }
      console.log(orderID);
      let url = "/LinePayReqAfter/" + orderID + "?dis=" + dis;
      fetch(url, {
        method: "post",
        headers: { "Content-Type": "application/json" },
      }).then((response) => {
        if (response.ok) {
          console.log(response)
          return response.json()
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

    document.querySelector("#pay").addEventListener("click", toPay)

    function getDiscount() {
      fetch("/coursediscount")
        .then(response => {
          if (response.ok) {
            return response.json();
          }
        }).then(data => {
          console.log(data.content)
          coupon.innerHTML = "";
          let content = data.content;
          let op1 = document.createElement("option");
          op1.value = 100;
          op1.innerHTML = "請選擇";
          op1.hidden = true;
          coupon.appendChild(op1);
          if (content) {
            for (let key in content) {
              let op = document.createElement("option");
              op.innerHTML = content[key].disID + ":" + content[key].disInfo;
              op.value = content[key].disPercent;
              coupon.appendChild(op)
            }
          }
        })
    }

    coupon.addEventListener("change", (e) => {
      console.log(e.target.value);
      let discount = parseFloat(e.target.value);
      let totalText = document.querySelector("#total");
      console.log(total);
      let newTotal = Math.ceil((total * discount) / 100)
      console.log(newTotal);
      totalText.innerHTML = "NT$ " + newTotal;
    })
