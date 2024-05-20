package com.softskillz.zoom.model;

//用來在網頁顯示網址彈窗
public class ZoomMeetingResponse {

	private String meetingUrl;
	private String startTime;
	private String meetingName;

	public ZoomMeetingResponse() {
	}

	public String getMeetingUrl() {
		return meetingUrl;
	}

	public void setMeetingUrl(String meetingUrl) {
		this.meetingUrl = meetingUrl;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getMeetingName() {
		return meetingName;
	}

	public void setMeetingName(String meetingName) {
		this.meetingName = meetingName;
	}

}
