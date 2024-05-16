package com.softskillz.coursechatdemo.model;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ChatHistoryService {
	
	ChatHistory insertChat(ChatHistory socketChatRoom);
	
	Page<ChatHistory> getHistory(Pageable pageable,String chatRoomId);
}
