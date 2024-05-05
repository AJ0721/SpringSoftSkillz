package com.softskillz.forum.model.dto;

import java.sql.Timestamp;
import java.util.List;

public class ForumThreadDto {

    private Integer threadId;
    private String threadTitle;
    private Timestamp threadCreatedTime;
    private String threadContent;
    private int threadUpvoteCount=0;
    private int threadResponseCount=0;
    private String threadStatus = "VISIBLE";
    private int forumCategoryId; 
    private Integer studentId;    
    private Integer teacherId;  
    private Integer adminId;    
    private List<Integer> threadIds;
    
    
    

    public ForumThreadDto() {
    }
    

    //update thread
	public ForumThreadDto(Integer threadId, String threadTitle, String threadContent) {
		super();
		this.threadId = threadId;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
	}

	//insert new thread
	public ForumThreadDto(String threadTitle, String threadContent, int forumCategoryId) {
		super();
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
		this.forumCategoryId = forumCategoryId;
	}
	
	
	




	public List<Integer> getThreadIds() {
		return threadIds;
	}


	public void setThreadIds(List<Integer> threadIds) {
		this.threadIds = threadIds;
	}



	


	public Integer getAdminId() {
		return adminId;
	}


	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}



	public Integer getThreadId() {
		return threadId;
	}

	public void setThreadId(Integer threadId) {
		this.threadId = threadId;
	}

	public String getThreadTitle() {
		return threadTitle;
	}

	public void setThreadTitle(String threadTitle) {
		this.threadTitle = threadTitle;
	}

	public Timestamp getThreadCreatedTime() {
		return threadCreatedTime;
	}

	public void setThreadCreatedTime(Timestamp threadCreatedTime) {
		this.threadCreatedTime = threadCreatedTime;
	}

	public String getThreadContent() {
		return threadContent;
	}

	public void setThreadContent(String threadContent) {
		this.threadContent = threadContent;
	}

	public int getThreadUpvoteCount() {
		return threadUpvoteCount;
	}

	public void setThreadUpvoteCount(int threadUpvoteCount) {
		this.threadUpvoteCount = threadUpvoteCount;
	}

	public int getThreadResponseCount() {
		return threadResponseCount;
	}

	public void setThreadResponseCount(int threadResponseCount) {
		this.threadResponseCount = threadResponseCount;
	}

	public String getThreadStatus() {
		return threadStatus;
	}

	public void setThreadStatus(String threadStatus) {
		this.threadStatus = threadStatus;
	}

	public int getForumCategoryId() {
		return forumCategoryId;
	}

	public void setForumCategoryId(int forumCategoryId) {
		this.forumCategoryId = forumCategoryId;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}
    
    
}