package com.softskillz.coursechatdemo.model;

import java.io.Serializable;

public class ChatRoomUser implements Serializable {

	private static final long serialVersionUID = 1L;

	private String userID;

	private String userName;

	private String userPhoto;

	public ChatRoomUser() {
	}

	public ChatRoomUser(String userID, String userPhoto) {
		super();
		this.userID = userID;
		this.userPhoto = userPhoto;
	}

	public ChatRoomUser(String userID, String userName, String userPhoto) {
		super();
		this.userID = userID;
		this.userName = userName;
		this.userPhoto = userPhoto;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "ChatRoomUser [userID=" + userID + ", userName=" + userName + ", userPhoto=" + userPhoto + "]";
	}

}
