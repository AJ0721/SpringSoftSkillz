package com.softskillz.coursechatdemo.model;

public class ChatRoomUser {

	private String userID;

	private String userPhoto;

	public ChatRoomUser() {
	}

	public ChatRoomUser(String userID, String userPhoto) {
		super();
		this.userID = userID;
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

	@Override
	public String toString() {
		return "ChatRoomUser [userID=" + userID + ", userPhoto=" + userPhoto + "]";
	}

}
