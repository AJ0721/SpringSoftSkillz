package com.softskillz.coursechatdemo.model;

import java.util.List;

public interface ChatRoomService {

	ChatRoom insertChatRoom(ChatRoom chatRoom);
	List<ChatRoom> chatRoomList (String userID);
}
