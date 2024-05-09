package com.softskillz.coursechatdemo.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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

}
