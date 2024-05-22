let date1 = "";
let date2 = "";
let url = "/adminorder";
let pageNo = "";
let size = "";
window.addEventListener("load",() => {
    const orders = sessionStorage.getItem("allorders");
    if (orders) {
        appendorder(JSON.parse(orders));
    } else {
        allorders();
    }
})

function allorders() {
    date1 = "";
    date2 = "";
    url = "/adminorder?" + "pid=" + pageNo + "&size=" + size;
    sessionStorage.clear();
    fetch(url)
        .then(response => {
            console.log(response);
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let orders = JSON.stringify(data);
            sessionStorage.setItem("allorders", orders)
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
    url = "/adminorder/" + date1 + "/" + date2 + "?pid=" + pageNo + "&size=" + size;
    fetch(url).then(response => {
        if (response.ok) {
            return response.json();
        }
    }).then(data => {
        let orders = JSON.stringify(data);
        sessionStorage.setItem("allorders", orders)
        appendorder(data);
    }).catch(error => {
        console.log(error);
    });
}

function cancel(orderID) {
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

function delOrder(orderID) {
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

function getPageList(pageNo) {
    fetch("/adminorder?" + "pid=" + pageNo)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let orders = JSON.stringify(data);
            sessionStorage.setItem("orders", orders)
            appendorder(data);
        })
}


function appendorder(data) {
    let tbody = document.querySelector("tbody");
    tbody.innerHTML = "";
    let content = data.content;
    for (let key in content) {
        let row = document.createElement("tr");
        let date = new Date(content[key].orderDate);
        let date2 = new Date(content[key].cancelDate);
        row.innerHTML =
            "<td class='text-center orderID'>" + content[key].orderID + "</td>" +
            "<td class='text-center'>" + content[key].studentID + "</td>" +
            "<td class='text-center'>" + date.toLocaleString("sv") + "</td>" +
            "<td class='text-center'>" + date2.toLocaleString('sv') + "</td>" +
            "<td class='text-center'>" + content[key].orderPrice + "</td>" +
            "<td class='text-center'>" + content[key].disNo + "</td>" +
            "<td class='text-center'>" + content[key].disPercent + "</td>" +
            "<td class='text-center'>" + content[key].afterPrice + "</td>" +
            "<td class='text-center'>" + content[key].paymentMethod + "</td>" +
            "<td class='text-center'>" + content[key].orderStatus + "</td>" +
            "<td class='text-center'><button class='btn btn-outline-primary block itembtn' data-bs-toggle='modal' data-bs-target='#border-less' >詳細</button></td>" +
            "<td class='text-center'><button class='btn btn-primary calbtn''>取消</button></td>" +
            "<td class='text-center'><button class='btn btn-primary delbtn'>刪除</button></td>";
        tbody.appendChild(row);
        let item = row.querySelector(".itembtn");
        item.addEventListener("click", getItem);
        let delbtn = row.querySelector(".delbtn");
        delbtn.addEventListener("click", deleteAl);
        let calbtn = row.querySelector(".calbtn");
        calbtn.addEventListener("click", calAl);
    }
    let page = data.totalPages;
    let pagination = document.querySelector(".pagination");
    let pageNumber = data.pageable.pageNumber;
    console.log("pageNumber" + pageNumber);

    pagination.innerHTML = "";
    let previousLi = document.createElement("li");
    previousLi.className = "page-item";
    previousLi.innerHTML = `<a class="page-link" href="#" aria-label="Previous" id="previous"><span aria-hidden="true">&laquo;</span></a>`
    pagination.appendChild(previousLi);
    let previous = document.querySelector("#previous");
    previous.addEventListener("click", (e) => {
        console.log(pageNumber);
        e.preventDefault();
        if (pageNumber > 0) {
            pageNo = pageNumber;
            choose();
        }
    });
    for (let i = 0; i < page; i++) {
        let li = document.createElement("li");
        li.className = "page-item";
        let a = document.createElement("a");
        if (pageNumber == i) {
            a.className = "page-link active";
        } else {
            a.className = "page-link";
        }

        a.href = "#";
        a.textContent = i + 1;
        a.addEventListener("click", (e) => {
            e.preventDefault();
            pageNo = parseInt(e.target.textContent, 10);
            choose();
        })
        li.appendChild(a);
        pagination.append(li);
    }
    let NextLi = document.createElement("li");
    NextLi.className = "page-item";
    NextLi.innerHTML = `<a class="page-link" href="#" aria-label="Next" id="next"><span aria-hidden="true" >&raquo;</span></a>`
    pagination.appendChild(NextLi);

    let next = document.querySelector("#next");
    next.addEventListener("click", (e) => {
        console.log(123);
        e.preventDefault();
        if (pageNumber + 1 < page) {
            pageNo = pageNumber + 2
            console.log("123+" + date1);
            console.log(date1 == "");
            choose();
        }
    });
}


pagesize = document.querySelector("#pagesize");
pagesize.addEventListener("change", (e) => {
    size = e.target.value;
    console.log(size);
    pageNo = "";
    choose();
})



const dateRangeInput = document.querySelector('.flatpickr-range');
const flatpickrInstance = flatpickr(dateRangeInput, {
    mode: 'range', // 設定為範圍選擇
    onChange: (selectedDates, dateStr, instance) => {
        getSelectedDateRange();
    },
});

// 取得所選的日期區間
function getSelectedDateRange() {
    if (flatpickrInstance.selectedDates.length === 2) {
        let startDate = flatpickrInstance.selectedDates[0];
        let endDate = flatpickrInstance.selectedDates[1];
        console.log((startDate.getMonth() + 1) < 10 ? "0" + (startDate.getMonth() + 1) : (startDate.getMonth() + 1));
        console.log(endDate);
        date1 = dateFormat(startDate);
        console.log(date1);
        date2 = dateFormat(endDate);
        console.log(date2);
        pageNo = "";
        getOrderByDate();

    } else {
        console.log('Please select a date range');
    }
};

// 示例如何使用
// 在初始化後立即獲取所選區間


function choose() {
    if (date1 && date2) {
        console.log("d1=" + date1, "d2=" + date2)
        getOrderByDate();
    } else {
        allorders();
    }
}

let allord = document.querySelector("#allord");
allord.addEventListener("click", () => {
        pageNo = ""
        allorders();
    
})

function getItem(e) {
    let tr = e.target.closest("tr");
    console.log(tr);
    let id = tr.querySelector(".orderID").innerText;
    let title = document.querySelector(".modal-title");
    title.innerHTML = "訂單編號:" + id;
    fetch("/adminorder/" + id)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let orderitem = document.querySelector("#orderitem");
            orderitem.innerHTML = "";
            for (let key in data) {
                let row = document.createElement("tr");
                row.innerHTML =
                    "<td class='text-center'>" + data[key].teacherName + "</td>" +
                    "<td class='text-center'>" + data[key].courseName + "</td>" +
                    "<td class='text-center'>" + data[key].courseCategory + "</td>" +
                    "<td class='text-center'>" + data[key].coursePrice + "</td>" +
                    "<td class='text-center'>" + data[key].qty + "</td>" +
                    "<td class='text-center'>" + data[key].disPercent + "</td>" +
                    "<td class='text-center'>" + data[key].disPrice + "</td>" +
                    "<td class='text-center'>" + data[key].subtotal + "</td>" +
                    "<td class='text-center'>" + data[key].status + "</td>";
                orderitem.appendChild(row);
            }
        })
}



function deleteAl() {
    Swal2.fire({
        title: "您確定要刪除嗎？",
        text: "此操作無法撤銷！",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "是的，刪除",
        cancelButtonText: "取消",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // 刪除的行為
            Toast.fire({
                icon: 'success',
                title: '項目已被刪除'
            });
            // 在此處執行您的刪除邏輯
        } else {
            Swal2.fire("取消", "項目未被刪除。", "info");
        }
    })
};
const Swal2 = Swal.mixin({
    customClass: {
        input: 'form-control'
    }
});

const Toast = Swal.mixin({
    toast: true,
    position: 'top-end',
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

function deleteAl(e) {
    console.log(123);
    let tr = e.target.closest("tr");
    console.log(tr);
    let id = tr.querySelector(".orderID").innerText;
    Swal2.fire({
        title: "您確定要刪除嗎？",
        text: "此操作無法撤銷！",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "是的，刪除",
        cancelButtonText: "放棄",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // 刪除的行為
            delOrder(id);
            Toast.fire({
                icon: 'success',
                title: '已刪除'
            });
            // 在此處執行您的刪除邏輯
        } else {
            Swal2.fire("取消", "項目未被刪除。", "info");
        }
    })
};

function calAl(e) {
    console.log(123);
    let tr = e.target.closest("tr");
    console.log(tr);
    let id = tr.querySelector(".orderID").innerText;
    Swal2.fire({
        title: "您確定要取消嗎？",
        text: "此操作無法撤銷！",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "是的，取消",
        cancelButtonText: "放棄",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // 刪除的行為
            cancel(id);
            Toast.fire({
                icon: 'success',
                title: '項目已被取消'
            });
            // 在此處執行您的刪除邏輯
        } else {
            Swal2.fire("放棄", "項目未被刪除。", "info");
        }
    })
};


function dateFormat(date) {
    let year = date.getFullYear()
    let mon = (date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1);
    let day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

    return year + "-" + mon + "-" + day;
}

let pending = document.querySelector("#pending");
pending.addEventListener("click",getPendingOrder)

function getPendingOrder(){
    date1 = "";
    date2 = "";
    let status = "處理中";
    url = "/adminorder/pending?" + "pid=" + pageNo + "&size=" + size+"&status="+status;
    sessionStorage.clear();
    fetch(url)
        .then(response => {
            console.log(response);
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let orders = JSON.stringify(data);
            sessionStorage.setItem("allorders", orders)
            appendorder(data);
        })
}