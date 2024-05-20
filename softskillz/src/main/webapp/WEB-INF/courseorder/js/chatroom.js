var websocket = null;
var chatPopup = null;
var sendOutUser = null;
let userID = null;
window.onload = () => {

    getUser();
}

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
        })
}
function getTeacherPhoto(sendOutUser) {


}

function connectWebSocket(userID) {
    //    sendOutUser = document.getElementById("sendOutUser").value;

    if (sendOutUser === "") {
        alert("请输入用户名");
        return;
    }

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
        //        document.getElementById("sendOutUser").style.backgroundColor = '#ddd';
        //        addMessage("", "WebSocket 连接已建立", true);
    };

    websocket.onclose = function () {
        // addMessage("", "WebSocket 连接已关闭", true);
    };

    websocket.onmessage = function (event) {
        getChatlist(sendOutUser);
        let photourl = null;
        console.log("photo=" + photourl);
        console.log(JSON.parse(event.data));
        let socketdata = JSON.parse(event.data)
        if (!chatPopup) {
            fetch("/chat/teachercr/" + socketdata.sendOutUser)
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    }
                }).then(data => {
                    console.log(data);
                    photourl = data.userPhoto;
                    chatroom(socketdata.sendOutUser, photourl);
                    addMessageToChatWindow("接收到", socketdata.msg);

                })
        } else {

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
    let receiveUser = document.querySelector(".userNameElement").textContent;
    console.log(sendOutUser);
    if (msg === "") {
        alert("请输入消息");
        return;
    }

    var chatRoomId = generateChatRoomId(sendOutUser, receiveUser);
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
    return user1 < user2 ? user1 + "_" + user2 : user2 + "_" + user1;
}





function chatroom(userName, userPhotoURL) {
    let chatPopup = document.querySelector(".chat-popup");

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
        chatInput.placeholder = "输入消息...";
        chatInput.id = "popup-chat-input";

        var sendButton = document.createElement("button");
        sendButton.style.marginLeft="1px";
        sendButton.textContent = "送出";

        sendButton.addEventListener("click", function () {
            var message = chatInput.value.trim();
            if (message) {
                var messageElement = document.createElement("div");
                messageElement.className = "message message-sent";
                messageElement.textContent = message;
                chatWindow.appendChild(messageElement);

                chatInput.value = '';
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


        chatPopup.style.display = 'flex'; // 显示聊天框
    }
}





function addMessageToChatWindow(sender, message) {
    var messageDiv = document.createElement("div"); // 创建新消息元素

    messageDiv.className = "message message-received"; // 设置样式
    messageDiv.textContent = sender + ": " + message; // 设置消息内容

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
    data.forEach((chat) => {
        const li = document.createElement("li"); // 每个数据项一个 `li`

        // 创建一个 flex 容器，确保图片和文本水平对齐
        const container = document.createElement("div");


        // 创建头像
        const img = document.createElement("img");
        let url = "/" + chat.userPhoto;
        img.src = url // 图片来源
        img.alt = chat.userID; // 备用文本

        // 创建用户ID的文本
        const text = document.createElement("span");
        text.textContent = chat.userID; // 设置用户ID

        // 将图片和文本添加到 flex 容器
        container.appendChild(img); // 图片在左侧
        container.appendChild(text); // 文本在右侧

        // 将 flex 容器添加到 `li`

        li.appendChild(container);
        li.addEventListener("click", () => {
            let chatPopup = document.querySelector(".chat-popup");
            if (!chatPopup) {
                console.log(1123);
                chatroom(chat.userID, url); // 确保事件处理函数没有修改 DOM 结构
            } else {
                chatPopup.remove();
                chatroom(chat.userID, url);
            }
        });
        chatlist.appendChild(li); // 添加到列表
    });

    function appendUl(data) {
    const dropdownMenu = document.getElementById("chatlist"); // 获取目标 dropdown-menu

    data.forEach((chat) => {
        // 创建一个新的<a>元素
        const newAnchor = document.createElement("a");
        newAnchor.href = "#";
        newAnchor.classList.add("dropdown-item");

        // 创建一个包含照片和姓名的容器
        const container = document.createElement("div");

        // 创建头像
        const img = document.createElement("img");
        img.src = "/" + chat.userPhoto;
        img.alt = chat.userID;

        // 创建用户ID的文本
        const text = document.createElement("span");
        text.textContent = chat.userID;

        // 将头像和文本添加到容器中
        container.appendChild(img);
        container.appendChild(text);

        // 将容器添加到<a>元素中
        newAnchor.appendChild(container);

        // 为每个创建的<a>元素添加点击事件
        newAnchor.addEventListener("click", () => {
            let chatPopup = document.querySelector(".chat-popup");
            if (!chatPopup) {
                console.log(1123);
                chatroom(chat.userID, "/" + chat.userPhoto); // 确保事件处理函数没有修改 DOM 结构
            } else {
                chatPopup.remove();
                chatroom(chat.userID, "/" + chat.userPhoto);
            }
        });

        // 将新的<a>元素添加到dropdown-menu中
        dropdownMenu.appendChild(newAnchor);
    });
}
    
}

