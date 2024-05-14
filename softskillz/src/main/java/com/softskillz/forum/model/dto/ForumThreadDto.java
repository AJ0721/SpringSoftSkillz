package com.softskillz.forum.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.softskillz.forum.model.StatusEnum;

public class ForumThreadDto {

	private Integer threadId;
	private String threadTitle;
	private Timestamp threadCreatedTime;
	private String threadContent;
	private int threadUpvoteCount = 0;
	private int threadResponseCount = 0;
	private StatusEnum threadStatus = StatusEnum.VISIBLE;
	private ForumCategoryDto forumCategory;
	private StudentDto student;
	private TeacherDto teacher;
	private AdminDto admin;
	private List<Integer> threadIds = new ArrayList<>();


	public ForumThreadDto() {
	}

	// update thread
	public ForumThreadDto(Integer threadId, String threadTitle, String threadContent) {
		this.threadId = threadId;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
	}

	// update status
	public ForumThreadDto(StatusEnum threadStatus) {
		this.threadStatus = threadStatus;
	}

	// insert new thread

	public ForumThreadDto(String threadTitle, String threadContent, ForumCategoryDto categoryDto) {
		super();
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
		this.forumCategory = forumCategory;
	}

	public List<Integer> getThreadIds() {
		return threadIds;
	}

	public void setThreadIds(List<Integer> threadIds) {
		this.threadIds = threadIds;
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

	public StatusEnum getThreadStatus() {
		return threadStatus;
	}

	public void setThreadStatus(StatusEnum threadStatus) {
		this.threadStatus = threadStatus;
	}


	public ForumCategoryDto getForumCategory() {
		return forumCategory;
	}

	public void setForumCategory(ForumCategoryDto forumCategory) {
		this.forumCategory = forumCategory;
	}

	public StudentDto getStudent() {
		return student;
	}

	public void setStudent(StudentDto student) {
		this.student = student;
	}

	public TeacherDto getTeacher() {
		return teacher;
	}

	public void setTeacher(TeacherDto teacher) {
		this.teacher = teacher;
	}

	public AdminDto getAdmin() {
		return admin;
	}

	public void setAdmin(AdminDto admin) {
		this.admin = admin;
	}

	

}