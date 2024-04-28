package com.softskillz.forum.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Component
@Table(name = "forum_post")
public class ForumPostModel{
	

	@Id
	@Column(name = "post_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int postId;

	@Column(name = "post_content")
	private String postContent;

	@Column(name = "post_upvote_count")
	private int postUpvoteCount = 0;

	@Column(name = "post_response_count")
	private int postResponseCount = 0;

	@Column(name = "post_created_time", insertable = false, updatable = false)
	private Timestamp postCreatedTime;

	@Column(name = "post_status")
	private String postStatus = "VISIBLE";

	@ManyToOne
	@JoinColumn(name = "post_student_id", referencedColumnName = "student_id", insertable = false, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne
	@JoinColumn(name = "post_teacher_id", referencedColumnName = "teacher_id", insertable = false, updatable = false, nullable = true)
	private TeacherBean teacherBean;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "thread_id")
	private ForumThreadModel forumThreadModel;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_post_id")
	private ForumPostModel forumPostModel;

	@OneToMany(mappedBy = "forumPostModel")
	private List<ForumPostModel> childPost = new ArrayList<>();

	@OneToMany(mappedBy = "forumPostModel")
	private List<ForumImageModel> forumImageModels = new ArrayList<ForumImageModel>();

	public ForumPostModel() {

	}

	// for new post insertion
	public ForumPostModel(String postContent) {
		this.postContent = postContent;
	}

	// for existing post update
	public ForumPostModel(int postId, String postContent) {
		super();
		this.postId = postId;
		this.postContent = postContent;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
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

	public String getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(String postStatus) {
		this.postStatus = postStatus;
	}

	public StudentBean getStudentBean() {
		return studentBean;
	}

	public void setStudentBean(StudentBean studentBean) {
		this.studentBean = studentBean;
	}

	public TeacherBean getTeacherBean() {
		return teacherBean;
	}

	public void setTeacherBean(TeacherBean teacherBean) {
		this.teacherBean = teacherBean;
	}

	public ForumThreadModel getForumThreadId() {
		return forumThreadModel;
	}

	public void setForumThreadId(ForumThreadModel forumThreadId) {
		this.forumThreadModel = forumThreadId;
	}

	public ForumPostModel getParentPostId() {
		return forumPostModel;
	}

	public void setParentPostId(ForumPostModel forumPostModel) {
		this.forumPostModel = forumPostModel;
	}

	public List<ForumPostModel> getChildPost() {
		return childPost;
	}

	public void setChildPost(List<ForumPostModel> childPost) {
		this.childPost = childPost;
	}

	public ForumThreadModel getForumThreadModel() {
		return forumThreadModel;
	}

	public void setForumThreadBean(ForumThreadModel forumThreadModel) {
		this.forumThreadModel = forumThreadModel;
	}

	public ForumPostModel getForumPostBean() {
		return forumPostModel;
	}

	public void setForumPostBean(ForumPostModel forumPostModel) {
		this.forumPostModel = forumPostModel;
	}

	public List<ForumImageModel> getForumImageModels() {
		return forumImageModels;
	}

	public void setForumImageModels(List<ForumImageModel> forumImageModels) {
		this.forumImageModels = forumImageModels;
	}

}
