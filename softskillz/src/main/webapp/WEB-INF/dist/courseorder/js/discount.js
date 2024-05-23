let action = "";
window.onload = () => {
    const discount = sessionStorage.getItem("discount");
    if (discount) {
        appendDiscount(JSON.parse(discount));
    } else {
        allDisscount();
    }
}

function allDisscount() {
    fetch("/coursediscount")
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let discount = JSON.stringify(data);
            sessionStorage.setItem("discount", discount)
            appendDiscount(data);
        })
}

function appendDiscount(data) {
    let tbody = document.querySelector("tbody");
    tbody.innerHTML = "";
    let content = data.content;
    console.log(content);
    for (let key in content) {
        let tr = document.createElement("tr");
        let startDate = new Date(content[key].startDate)
        let endDate = new Date(content[key].endDate)
        tr.innerHTML =
            "<td class='text-center disID'>" + content[key].disID + "</td>" +
            "<td class='text-center'>" + content[key].disInfo + "</td>" +
            "<td class='text-center'>" + content[key].disPercent + "</td>" +
            "<td class='text-center'>" + dateFormat(startDate) + "</td>" +
            "<td class='text-center'>" + dateFormat(endDate) + "</td>" +
            "<td class='text-center'><button class='btn btn-primary block update'  data-bs-toggle='modal' data-bs-target='#border-less' >修改</button></td>" +
            "<td class='text-center'><button class='btn btn-primary delete' >刪除</button></td>";
        tbody.appendChild(tr);
        let deleteBtn = tr.querySelector('.delete');
        deleteBtn.addEventListener('click', deleteDisAL);

        let updateBtn = tr.querySelector('.update');
        updateBtn.addEventListener('click', updateDialog);
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
            allDisscount();
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
            allDisscount();
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
            allDisscount();
        }
    });

}

pagesize = document.querySelector("#pagesize");
pagesize.addEventListener("change", (e) => {
    size = e.target.value;
    console.log(size);
    pageNo = "";
    allDisscount();
})

let addBtn = document.querySelector(".insert");
addBtn.addEventListener("click", () => {
    action = "";
    console.log(123);
    let title = document.querySelector(".modal-title");
    title.innerHTML = "新增折扣"

    let discount = document.querySelector("#discount");
    discount.innerHTML = "";
    let row = document.createElement("tr");
    row.innerHTML = "";

    row.innerHTML =
        "<td class='text-center'>" + "<input type='text' class='disID w-75' />" + "</td>" +
        "<td class='text-center'>" + "<input type='text' class='disInfo w-75'/>" + "</td > " +
        "<td class='text-center'>" + "<input type='text' class='disPercent w-75' '/>" + "</td>" +
        "<td class='text-center'>" + "<input type='datetime-local' class='startDate ' '/>" + "</td>" +
        "<td class='text-center'>" + "<input type='datetime-local' class='endDate ' '/>" + "</td>";
    discount.appendChild(row);

});



function insertDis(data) {
    Swal2.fire({
        title: "您確定要新增嗎？",
        text: "此操作無法撤銷！",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "是的",
        cancelButtonText: "放棄",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("/coursediscount", {
                method: "post",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            }).then(response => {
                if (response.ok) {
                    allDisscount();
                }
            }).catch(error => {
                console.log("????");
            });
            Toast.fire({
                icon: 'success',
                title: '以新增'
            });
            // 在此處執行您的刪除邏輯
        } else {
            Swal2.fire("取消", "項目未被新增。", "info");
        }
    })

}



function updateDialog(e) {
    let tr = e.target.closest("tr");
    let disID = tr.querySelector(".disID").textContent;
    let title = document.querySelector(".modal-title");
    title.innerHTML = "編號:" + disID;
    fetch("/coursediscount/" + disID)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let discount = document.querySelector("#discount");
            discount.innerHTML = "";
            console.log(data);
            let row = document.createElement("tr");
            row.innerHTML = "";
            let startDate = new Date(data.startDate)
            let endDate = new Date(data.endDate)
            row.innerHTML =
                "<td class='text-center '>" + data.disID + "<input type='hidden' class='disID w-75' value='" + data.disID + "'/>" + "</td>" +
                "<td class='text-center'>" + "<input type='text' class='disInfo w-75' value='" + data.disInfo + "'/>" + "</td > " +
                "<td class='text-center'>" + "<input type='text' class='disPercent w-75' value='" + data.disPercent + "'/>" + "</td>" +
                "<td class='text-center'>" + "<input type='datetime-local' class='startDate w-75' value='" + dateFormat(startDate) + "'/>" + "</td>" +
                "<td class='text-center'>" + "<input type='datetime-local' class='endDate w-75' value='" + dateFormat(endDate) + "'/>" + "</td>";
            discount.appendChild(row);
            action = "update";
        })
}

function updateDis(data) {
    Swal2.fire({
        title: "您確定要修改嗎？",
        text: "此操作無法撤銷！",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "是的",
        cancelButtonText: "放棄",
        reverseButtons: true
    }).then((result) => {
        if (result.isConfirmed) {
            // 刪除的行為
            fetch("/coursediscount", {
                method: "put",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            }).then(response => {
                if (response.ok) {
                    allDisscount();
                }
            }); Toast.fire({
                icon: 'success',
                title: '已修改'
            });
            // 在此處執行您的刪除邏輯
        } else {
            Swal2.fire("取消", "項目未被修改。", "info");
        }
    })

}





function dateFormat(date) {
    let year = date.getFullYear()
    let mon = (date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1);
    let day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

    return year + "-" + mon + "-" + day;
}


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

function deleteDisAL(e) {
    console.log(123);
    let tr = e.target.closest("tr");
    console.log(tr);
    let id = tr.querySelector(".disID").innerText;
    console.log(id);
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
            deleteDis(id);
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

function deleteDis(id) {
    fetch("/coursediscount/" + id, {
        method: "delete"
    }).then(response => {
        if (response.ok) {
            allDisscount();
        }
    })
}



function dateFormat(date) {
    let year = date.getFullYear()
    let mon = (date.getMonth() + 1) < 10 ? "0" + (date.getMonth() + 1) : (date.getMonth() + 1);
    let day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();

    return year + "-" + mon + "-" + day;
}

let confirnBtn = document.querySelector(".confirn")
confirnBtn.addEventListener("click", function () {
    let data = getData();
    if (action == "") {
        insertDis(data)
    } else {
        updateDis(data)
    }
    action = "";
})

function getData() {
    let discount = document.querySelector("#discount");
    let disID = discount.querySelector(".disID").value;
    let disInfo = discount.querySelector(".disInfo").value;
    let disPercent = discount.querySelector(".disPercent").value;
    let startDate = discount.querySelector(".startDate").value;
    let endDate = discount.querySelector(".endDate").value;
    let data = {
        "disID": disID,
        "disInfo": disInfo,
        "disPercent": disPercent,
        "startDate": startDate,
        "endDate": endDate
    }
    console.log(data);
    return data;
}

let allDis = document.querySelector("#allDis");
allDis.addEventListener("click", () => {
    allDisscount();
})