package com.softskillz.coursechatdemo.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ChatHistoryServiceImpl implements ChatHistoryService {

	@Autowired
	private ChatHistoryRepository chatRoomRepo;

	@Override
	public ChatHistory insertChat(ChatHistory socketChatRoom) {
		return chatRoomRepo.save(socketChatRoom);
	}

	@Override
	public Page<ChatHistory> getHistory(Pageable pageable,String chatRoomId) {
		Page<ChatHistory> page = chatRoomRepo.findByChatRoomId(pageable,chatRoomId);
		return page;
	}

}
