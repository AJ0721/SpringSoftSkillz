package com.softskillz.coursechatdemo.model;

import java.util.Date;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Component
@Entity
@Table(name = "coursechat")
public class ChatHistory {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "chatroom_id")
	private String chatRoomId;

	@Column(name = "senduser")
	private String sendOutUser;

	@Column(name = "msg")
	private String msg;

	@Column(name = "sendtime")
	@JsonFormat(timezone = "GMT+8")
	private Date sendTime;

	public ChatHistory() {
		super();
	}

	public ChatHistory(String chatRoomId, String sendOutUser, String msg) {
		super();
		this.chatRoomId = chatRoomId;
		this.sendOutUser = sendOutUser;
		this.msg = msg;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	@Override
	public String toString() {
		return "SocketChatRoom [id=" + id + ", chatRoomId=" + chatRoomId + ", sendOutUser=" + sendOutUser + ", msg="
				+ msg + ", sendTime=" + sendTime + "]";
	}

}
