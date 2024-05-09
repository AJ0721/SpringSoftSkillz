package com.softskillz.coursechatdemo.model;

public class SocketChatRoom {
	private String chatRoomId;
	/**
	 * 发送者
	 **/
	private String sendOutUser;
	/**
	 * 接受者
	 **/
	private String receiveUser;
	/**
	 * 消息
	 **/
	private String msg;

	public SocketChatRoom() {
		super();
	}

	public String getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(String chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	public String getSendOutUser() {
		return sendOutUser;
	}

	public void setSendOutUser(String sendOutUser) {
		this.sendOutUser = sendOutUser;
	}

	public String getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	@Override
	public String toString() {
		return "SocketChatRoom [chatRoomId=" + chatRoomId + ", sendOutUser=" + sendOutUser + ", receiveUser="
				+ receiveUser + ", msg=" + msg + "]";
	}

}
