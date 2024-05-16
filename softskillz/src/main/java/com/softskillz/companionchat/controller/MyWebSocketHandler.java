package com.softskillz.companionchat.controller;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.ArrayList;
import java.util.List;

public class MyWebSocketHandler implements WebSocketHandler {

    private List<WebSocketSession> sessions = new ArrayList<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String endpoint = session.getUri().getPath();
        if ("/companionChat.html".equals(endpoint)) {
            // 初始化 /companionChat.html 端點的數據
        	System.out.println("WebSocket 連接已建立");
        	sessions.add(session);
        } else if ("/companionChat2.html".equals(endpoint)) {
            // 初始化 /companionChat2.html 端點的數據
        	System.out.println("WebSocket 連接已建立");
        	sessions.add(session);
        }
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        System.out.println("收到來自客戶端的訊息：" + message.getPayload());
        session.sendMessage(new TextMessage("收到訊息：" + message.getPayload()));
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        System.out.println("WebSocket 連接出現錯誤");
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        System.out.println("WebSocket 連接已關閉");
        sessions.remove(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    // 向所有客戶端發送訊息
    public void sendMessageToAllClients(String message) {
        for (WebSocketSession session : sessions) {
            try {
                session.sendMessage(new TextMessage(message));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
