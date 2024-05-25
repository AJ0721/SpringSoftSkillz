var websocket = null;
var chatPopup = null;
var sendOutUser = null;
let userID = null;
window.addEventListener("load",()=>{
    getUser();
})

function getUser() {
    fetch("/chat/getUser")
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            console.log(data);
            sendOutUser = data.userID;
            console.log(sendOutUser);
            getChatlist(data.userID);
            connectWebSocket(data.userID);
        }).catch(error => {
            console.error('沒登入', error);
        })
}


function connectWebSocket(userID) {
    //    sendOutUser = document.getElementById("sendOutUser").value;

    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://localhost:8080/web-socket/" + userID);
    } else {
        alert("88");
        return;
    }

    websocket.onerror = function () {
        alert("BIG");
    };

    websocket.onopen = function () {
        console.log("連線:" + userID);

    };

    websocket.onclose = function () {
    };

    websocket.onmessage = function (event) {
        getChatlist(sendOutUser);
        let photourl = null;
        console.log("photo=" + photourl);
        console.log(JSON.parse(event.data));
        let socketdata = JSON.parse(event.data)
        let chatPopup = document.querySelector(".chat-popup");
        if (!chatPopup) {
            console.log("123");
            fetch("/chat/teachercr/" + socketdata.sendOutUser)
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    }
                }).then(data => {
                    console.log(data);
                    photourl = data.userPhoto;
                    console.log("photo=" + photourl);
                    chatroom(data.userID, data.userName, photourl);
                    // addMessageToChatWindow("接收到", socketdata.msg);
                })
        } else {
            console.log("2");
            let suer = document.querySelector(".userNameElement").textContent;
            console.log("破:" + typeof (suer))
            console.log(typeof (sendOutUser))

            if (suer == socketdata.sendOutUser) {
                addMessageToChatWindow("接收到", socketdata.msg);
                console.log("啟動")
            }
        }
    };
}

function closeWebSocket() {
    if (websocket) {
        websocket.close();
    }
}


function send(msg) {
    // var sendOutUser = document.getElementById("sendOutUser").value;
    // var msg = document.getElementById("msg").value;
    let ele = document.querySelector(".userNameElement");
    let receiveUser = ele.getAttribute("data-id")
    console.log("id"+receiveUser);
    console.log(sendOutUser);
    if (msg === "") {
        return;
    }

    var chatRoomId = generateChatRoomId(sendOutUser, receiveUser);
    console.log(chatRoomId);
    let sendTime = new Date();
    var message = {
        chatRoomId: chatRoomId,
        sendOutUser: sendOutUser,
        // receiveUser: receiveUser,
        msg: msg,
        sendTime: sendTime
    };

    websocket.send(JSON.stringify(message)); // 发送消息
}






function generateChatRoomId(user1, user2) {
    if (user1 === "system") {
        return "system_" + user2;
    } else if (user2 === "system") {
        return "system_" + user1;
    } else if (user1 < user2) {
        return user1 + "_" + user2;
    } else {
        return user2 + "_" + user1;
    }
}





function chatroom(userID, userName, userPhotoURL) {
    let chatPopup = document.querySelector(".chat-popup");
    console.log("123"+userPhotoURL);
    // 如果已有弹出框，先移除以确保不会有多余的绑定
    if (!chatPopup) {

        chatPopup = document.createElement("div");
        chatPopup.className = "chat-popup";

        // 创建顶部栏
        var chatHeader = document.createElement("div");
        chatHeader.className = "chat-header";

        // 用户头像
        var userPhotoElement = document.createElement("img");
        userPhotoElement.className = "userPhotoElement"
        userPhotoElement.src = userPhotoURL; // 用户头像链接


        // 用户名称
        var userNameElement = document.createElement("span"); // 用于显示用户名
        userNameElement.className = "userNameElement";
        userNameElement.textContent = userName;
        userNameElement.setAttribute("data-id",userID)
        // 关闭按钮
        var closeButton = document.createElement("button");
        closeButton.className = "closeButton";
        closeButton.textContent = "×";

        closeButton.addEventListener("click", function () {
            chatPopup.remove();
        });

        // 创建一个容器来放置头像和用户名
        var userContainer = document.createElement("div");
        userContainer.style.display = "flex";
        userContainer.style.alignItems = "center"; // 保持头像和用户名在一条线上
        userContainer.appendChild(userPhotoElement);
        userContainer.appendChild(userNameElement);

        // 将用户信息和关闭按钮添加到顶部栏
        chatHeader.appendChild(userContainer);
        chatHeader.appendChild(closeButton);

        // 创建聊天窗口
        chatWindow = document.createElement("div");
        chatWindow.className = "chat-window";

        // 聊天输入区域
        var chatInputContainer = document.createElement("div");
        chatInputContainer.className = "chat-input";

        var chatInput = document.createElement("input");
        chatInput.id = "popup-chat-input";

        var sendButton = document.createElement("button");
        sendButton.style.marginLeft = "1px";
        sendButton.textContent = "送出";

        sendButton.addEventListener("click", function () {
            var message = chatInput.value.trim();
            if (message) {
                var messageElement = document.createElement("div");
                messageElement.className = "message message-sent";
                messageElement.innerHTML = detectAndConvertURLs(message);
                chatWindow.appendChild(messageElement);
                chatInput.value = '';
                chatWindow.scrollTop = chatWindow.scrollHeight
                send(message);
            }
        });


        chatInput.addEventListener("keypress", function (e) {
            if (e.key === 'Enter') {
                sendButton.click();
            }
        });

        chatInputContainer.appendChild(chatInput);
        chatInputContainer.appendChild(sendButton);

        // 将顶部栏、聊天窗口和聊天输入区域添加到聊天框
        chatPopup.appendChild(chatHeader); // 顶部栏
        chatPopup.appendChild(chatWindow); // 聊天窗口
        chatPopup.appendChild(chatInputContainer); // 聊天输入区域

        document.body.appendChild(chatPopup); // 将聊天框添加到页面

        let chatroomid = generateChatRoomId(sendOutUser, userID);
        history(chatroomid);

        chatPopup.style.display = 'flex'; // 显示聊天框
    }
}





function addMessageToChatWindow(sender, message) {
    var messageDiv = document.createElement("div"); // 创建新消息元素

    messageDiv.className = "message message-received"; // 设置样式
    messageDiv.innerHTML = detectAndConvertURLs(message); // 设置消息内容

    chatWindow.appendChild(messageDiv); // 将消息添加到聊天窗口
    chatWindow.scrollTop = chatWindow.scrollHeight; // 滚动到最底部
}

function getChatlist(userID) {
    fetch("/chat/teacherList/" + userID)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let chatlist = document.querySelector("#chatlist");
            chatlist.innerHTML = "";
            console.log(data);
            appendUl(data);
        })
}

function appendUl(data) {
    const dropdownMenu = document.querySelector("#chatlist");

    // 設定下拉菜單的寬度
    dropdownMenu.style.width = "250px"; // 根據需要調整寬度

    data.forEach((chat) => {
        const newAnchor = document.createElement("a");
        newAnchor.href = "#";
        newAnchor.classList.add("dropdown-item");

        const container = document.createElement("div");
        container.classList.add("d-flex", "align-items-center"); // 使用 Bootstrap 彈性布局

        const img = document.createElement("img");
        img.src = chat.userPhoto;
        img.alt = chat.userID;
        img.classList.add("rounded-circle"); // 使用 Bootstrap 圓角類
        img.style.width = "40px"; // 設置圖片寬度
        img.style.height = "40px"; // 設置圖片高度
        img.style.marginRight = "10px"; // 增加圖片和文字之間的間距

        const text = document.createElement("span");
        text.textContent = chat.userName;
        text.classList.add("text-md", "fs-5"); // 設置文字大小為中等
        text.style.marginLeft = "10px"; // 增加左邊距離以進一步增加間距

        container.appendChild(img);
        container.appendChild(text);

        newAnchor.appendChild(container);

        newAnchor.addEventListener("click", () => {
            let chatPopup = document.querySelector(".chat-popup");
            if (!chatPopup) {
                console.log(1123);
                chatroom(chat.userID, chat.userName, chat.userPhoto);
            } else {
                chatPopup.remove();
                chatroom(chat.userID, chat.userName, chat.userPhoto);
            }
        });

        dropdownMenu.appendChild(newAnchor);
    });
}


function history(chatroomID) {
    fetch("/chat/" + chatroomID)
        .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            content = data.content.reverse();
            for (let key in content) {
                let messageElement = document.createElement("div");
                if (content[key].sendOutUser == sendOutUser) {
                    messageElement.className = "message message-sent";
                } else {
                    messageElement.className = "message message-received";
                }
                messageElement.innerHTML = detectAndConvertURLs(content[key].msg);
                chatWindow.appendChild(messageElement);
                chatWindow.scrollTop = chatWindow.scrollHeight
            }
        })
}

function detectAndConvertURLs(message) {
    var urlRegex = /(https?:\/\/[^\s]+)/g;
    var hasURL = false; // 用于标记消息中是否存在 URL
    var convertedMessage = message.replace(urlRegex, function (url) {
        hasURL = true; // 设置标记为 true，表示消息中包含 URL
        return '<a href="' + url + '" target="_blank">' + url + '</a>';
    });
    // 如果消息中没有 URL，则返回原始文本
    return hasURL ? convertedMessage : message;
}
