package com.softskillz.coursechatdemo.model;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ChatRoomService {

	ChatRoom insertChatRoom(ChatRoom chatRoom);
	List<ChatRoom> chatRoomList (String userID);
	Page<ChatRoom> chatRoomListPage(Pageable pageable);
}
