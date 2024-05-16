package com.softskillz.companionchat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

    @Autowired
    private MyWebSocketHandler webSocketHandler;

    // 接收客戶端發送的訊息，並轉發到指定的目標
    @MessageMapping("/send-message")
    @SendTo("/topic/receive-message")
    public String sendMessage(String message) {
        return "收到訊息：" + message;
    }

    // 假設你有一個頁面需要推送訊息給客戶端，可以在需要的地方調用 WebSocketHandler 的方法
    public void pushMessageToClients(String message) {
        webSocketHandler.sendMessageToAllClients(message);
    }
    
    // 接收來自客戶端的訊息，並將其轉發到所有客戶端
    @MessageMapping("/forward-message")
    public void forwardMessage(String message) {
        pushMessageToClients(message);
    }
    // 接收來自 client1 的訊息，並轉發給 client2
    @MessageMapping("/forward-to-client2")
    public void forwardMessageToClient2(String message) {
        webSocketHandler.sendMessageToAllClients(message);
    }
}

