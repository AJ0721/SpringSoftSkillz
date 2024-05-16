package com.softskillz.coursechatdemo.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ChatRoomServiceImpl implements ChatRoomService {

	@Autowired
	private ChatRoomRepository chatRoomRepo;

	@Override
	public ChatRoom insertChatRoom(ChatRoom chatRoom) {

		return chatRoomRepo.save(chatRoom);
	}

	@Override
	public List<ChatRoom> chatRoomList(String userID) {
		return chatRoomRepo.chatRoomList(userID);
	}

	@Override
	public Page<ChatRoom> chatRoomListPage(Pageable pageable) {
		Page<ChatRoom> page = chatRoomRepo.findAll(pageable);
		return page;
	}

}
