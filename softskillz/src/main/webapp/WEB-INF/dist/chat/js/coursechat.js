let pageNo = "";
    let size = "";
    let sort = "" ;
    window.addEventListener("load" ,() => {
      const chatroom = sessionStorage.getItem("chatroom");
      if (chatroom) {
        appendChat(JSON.parse(chatroom));
      } else {
        getAllChatRoom();
      }
    })

    function getAllChatRoom() {
      fetch("/chat?" + "pid=" + pageNo)
        .then(response => {
          if (response.ok) {
            return response.json();
          }
        }).then(data => {
          console.log(data);
          let chatroom = JSON.stringify(data);
          sessionStorage.setItem("chatroom", chatroom)
          appendChat(data);
        })
    }

    function appendChat(data) {
      let tbody = document.querySelector("tbody");
      tbody.innerHTML = "";
      let content = data.content;
      console.log(content);
      for (let key in content) {
        let tr = document.createElement("tr");
        let lastTime = new Date(content[key].lastTime)
        tr.innerHTML =
          "<td class='text-center chatRoomID'>" + content[key].chatRoomID + "</td>" +
          "<td class='text-center'>" + content[key].user1 + "</td>" +
          "<td class='text-center'>" + content[key].user2 + "</td>" +
          "<td class='text-center'>" + lastTime.toLocaleString('sv') + "</td>" +
          "<td class='text-center'><button class='btn btn-primary block chathistory'  data-bs-toggle='modal' data-bs-target='#border-less' >詳細</button></td>";
        tbody.appendChild(tr);

        let chathistory = tr.querySelector('.chathistory');
        chathistory.addEventListener('click', getHistory);
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
          getAllChatRoom();
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
          getAllChatRoom();
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
          getAllChatRoom();
        }
      });

    }

    pagesize = document.querySelector("#pagesize");
    pagesize.addEventListener("change", (e) => {
      size = e.target.value;
      console.log(size);
      pageNo = "";
      getAllChatRoom();
    })
    let id = "";
    function getHistory(e) {
      let tr = e.target.closest("tr");
      id = tr.querySelector(".chatRoomID").textContent;
      console.log(id);
      let title = document.querySelector(".modal-title");
      title.innerHTML = "聊天室編號:" + id;
      history(id);
    }

    function history(id) {
      
      fetch("/chat/" + id + "?pid=" + pageNo)
        .then(response => {
          if (response.ok) {
            return response.json();
          }
        }).then(data => {
          showHistory(data);
        })
    }

    function showHistory(data) {
      let tbody = document.querySelector("#chathistory");
      tbody.innerHTML = "";
      let content = data.content;
      console.log(content);
      for (let key in content) {
        let tr = document.createElement("tr");
        let sendTime = new Date(content[key].sendTime)
        tr.innerHTML =
          // "<td class='text-center '>" + content[key].id + "</td>" +
          "<td class='text-center chatRoomID'>" + content[key].chatRoomId + "</td>" +
          "<td class='text-center'>" + content[key].sendOutUser + "</td>" +
          "<td class='text-center'>" + content[key].msg + "</td>" +
          "<td class='text-center'>" + sendTime.toLocaleString('sv') + "</td>";
        tbody.appendChild(tr);
      }
      let page = data.totalPages;
      let hispagination = document.querySelector("#hispagination");
      let pageNumber = data.pageable.pageNumber;
      console.log("pageNumber" + pageNumber);

      hispagination.innerHTML = "";
      let previousLi = document.createElement("li");
      previousLi.className = "page-item";
      previousLi.innerHTML = `<a class="page-link" href="#" aria-label="Previous" id="previoushis"><span aria-hidden="true">&laquo;</span></a>`
      hispagination.appendChild(previousLi);
      let previous = document.querySelector("#previoushis");
      previous.addEventListener("click", (e) => {
        console.log(pageNumber);
        e.preventDefault();
        if (pageNumber > 0) {
          pageNo = pageNumber;
          history(id);
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
          history(id);
        })
        li.appendChild(a);
        hispagination.append(li);
      }
      let NextLi = document.createElement("li");
      NextLi.className = "page-item";
      NextLi.innerHTML = `<a class="page-link" href="#" aria-label="Next" id="nexthis"><span aria-hidden="true" >&raquo;</span></a>`
      hispagination.appendChild(NextLi);

      let next = document.querySelector("#nexthis");
      next.addEventListener("click", (e) => {
        console.log(123);
        e.preventDefault();
        if (pageNumber + 1 < page) {
          pageNo = pageNumber + 2
          history(id);
        }
      });

    }
