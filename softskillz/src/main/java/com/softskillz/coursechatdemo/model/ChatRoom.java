package com.softskillz.coursechatdemo.model;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Component
@Table(name = "coursechatroom")
public class ChatRoom {

	@Id
	@Column(name = "chatroom_id")
	private String chatRoomID;

	@Column(name = "senduser")
	private String user1;

	@Column(name = "receiveuser")
	private String user2;

	@Column(name = "lasttime")
	@JsonFormat(timezone = "GMT+8")
	private Date lastTime;

	public ChatRoom() {
	}

	public ChatRoom(String chatRoomID, String user1, String user2, Date lastTime) {
		super();
		this.chatRoomID = chatRoomID;
		this.user1 = user1;
		this.user2 = user2;
		this.lastTime = lastTime;
	}

	public String getChatRoomID() {
		return chatRoomID;
	}

	public void setChatRoomID(String chatRoomID) {
		this.chatRoomID = chatRoomID;
	}

	public String getUser1() {
		return user1;
	}

	public void setUser1(String user1) {
		this.user1 = user1;
	}

	public String getUser2() {
		return user2;
	}

	public void setUser2(String user2) {
		this.user2 = user2;
	}

	public Date getLastTime() {
		return lastTime;
	}

	public void setLastTime(Date lastTime) {
		this.lastTime = lastTime;
	}

}
