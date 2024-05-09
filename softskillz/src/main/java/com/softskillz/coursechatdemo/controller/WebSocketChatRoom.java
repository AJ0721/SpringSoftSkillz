package com.softskillz.coursechatdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.softskillz.coursechatdemo.model.ChatHistory;
import com.softskillz.coursechatdemo.model.ChatHistoryServiceImpl;
import com.softskillz.coursechatdemo.model.ChatRoom;
import com.softskillz.coursechatdemo.model.ChatRoomServiceImpl;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;

@Component
@ServerEndpoint("/web-socket/{userName}")
public class WebSocketChatRoom {

	private static ChatHistoryServiceImpl chatHistoryService;
	private static ChatRoomServiceImpl chatRoomService;

	@Autowired
	private void setService(ChatHistoryServiceImpl chatHistoryService, ChatRoomServiceImpl chatRoomService) {
		WebSocketChatRoom.chatHistoryService = chatHistoryService;
		WebSocketChatRoom.chatRoomService = chatRoomService;
	}

	private String userName;
	private Session session;
	private static final String USER_NAME_PREFIX = "user_name_";
	private static CopyOnWriteArraySet<WebSocketChatRoom> webSocketSet = new CopyOnWriteArraySet<>();
	private static ConcurrentHashMap<String, Session> sessionMap = new ConcurrentHashMap<>();

	@OnOpen
	public void onOpen(Session session, @PathParam("userName") String userName) {
		this.userName = userName;
		this.session = session;
		System.out.println(userName);
		sessionMap.put(USER_NAME_PREFIX + userName, session);
		webSocketSet.add(this);
	}

	@OnMessage
	public void onMessage(String message) {
		try {
			// 打印接收到的原始消息
			System.out.println("Json接收到的消息：" + message);

			ObjectMapper om1 = new ObjectMapper();
			ChatHistory socketChatRoom = om1.readValue(message, ChatHistory.class);
			String[] data = socketChatRoom.getChatRoomId().split("_");
			
			// 确认已成功解析
			System.out.println("解析后的对象：" + socketChatRoom);
			String receiveUser = (socketChatRoom.getSendOutUser().equals(data[0]) ? data[1] : data[0]);
			// 進資料庫socketChatRoom
			ChatRoom chatRoom = new ChatRoom(socketChatRoom.getChatRoomId(),socketChatRoom.getSendOutUser(),receiveUser,socketChatRoom.getSendTime());
			chatRoomService.insertChatRoom(chatRoom);
			chatHistoryService.insertChat(socketChatRoom);
			// 确认接收者的 Session
			String receiveUserKey = USER_NAME_PREFIX
					+ (socketChatRoom.getSendOutUser().equals(data[0]) ? data[1] : data[0]);

			Session receiveSession = sessionMap.get(receiveUserKey);

			if (receiveSession != null) {
				receiveSession.getAsyncRemote().sendText(message);
			} else {
				session.getAsyncRemote().sendText("系统消息：對方不在線上，消息已保存");
			}
		} catch (JsonProcessingException e) {
			System.out.println("JSON 解析错误：" + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("处理消息时发生错误：" + e.getMessage());
			e.printStackTrace();
		}
	}

	@OnClose
	public void onClose() {
		if (sessionMap.containsKey(USER_NAME_PREFIX + userName)) {
			sessionMap.remove(USER_NAME_PREFIX + userName);
			webSocketSet.remove(this);
		}
	}

	@OnError
	public void onError(Throwable error) {
		error.printStackTrace();
	}

	public static String generateChatRoomId(String user1, String user2) {
		if (user1.compareTo(user2) < 0) {
			return user1 + "_" + user2;
		} else {
			return user2 + "_" + user1;
		}
	}
}
