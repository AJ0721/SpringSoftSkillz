package com.softskillz.forum.model.dto;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.softskillz.forum.model.StatusEnum;

public class ForumPostDto {

	private Integer postId;
	private String postContent;
	private int postUpvoteCount = 0;
	private int postResponseCount = 0;
	private Timestamp postCreatedTime;
	private StatusEnum postStatus = StatusEnum.VISIBLE;
	private StudentDto student;
	private TeacherDto teacher;
	private AdminDto admin;
	private ForumThreadDto thread;
	private ForumPostDto parentPost;
	private List<Integer> postIds = new ArrayList<>();	
	
	
	public ForumPostDto() {
		
	}

	//update post
	public ForumPostDto(String postContent) {
		this.postContent = postContent;
	}
	
	//update post status
	public ForumPostDto(StatusEnum postStatus) {
		this.postStatus = postStatus;
	}
	
	
	//insert post
		public ForumPostDto(Integer postId, String postContent) {
		this.postId = postId;
		this.postContent = postContent;
	}

		public Integer getPostId() {
			return postId;
		}

		public void setPostId(Integer postId) {
			this.postId = postId;
		}

		public String getPostContent() {
			return postContent;
		}

		public void setPostContent(String postContent) {
			this.postContent = postContent;
		}

		public int getPostUpvoteCount() {
			return postUpvoteCount;
		}

		public void setPostUpvoteCount(int postUpvoteCount) {
			this.postUpvoteCount = postUpvoteCount;
		}

		public int getPostResponseCount() {
			return postResponseCount;
		}

		public void setPostResponseCount(int postResponseCount) {
			this.postResponseCount = postResponseCount;
		}

		public Timestamp getPostCreatedTime() {
			return postCreatedTime;
		}

		public void setPostCreatedTime(Timestamp postCreatedTime) {
			this.postCreatedTime = postCreatedTime;
		}

		public StatusEnum getPostStatus() {
			return postStatus;
		}

		public void setPostStatus(StatusEnum postStatus) {
			this.postStatus = postStatus;
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

		public ForumThreadDto getThread() {
			return thread;
		}

		public void setThread(ForumThreadDto thread) {
			this.thread = thread;
		}

		public ForumPostDto getParentPost() {
			return parentPost;
		}

		public void setParentPost(ForumPostDto parentPost) {
			this.parentPost = parentPost;
		}

		public List<Integer> getPostIds() {
			return postIds;
		}

		public void setPostIds(List<Integer> postIds) {
			this.postIds = postIds;
		}

	

}


