package com.softskillz.forum.model;

import java.io.Serializable;
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
public class ForumPostBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "post_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int postId;

	@Column(name = "post_content")
	private String postContent;

	@Column(name = "post_upvote_count")
	private int postUpvoteCount;

	@Column(name = "post_response_count")
	private int postResponseCount;

	@Column(name = "post_created_time")
	private Timestamp postCreatedTime;

	@Column(name = "post_status")
	private String postStatus;

	@ManyToOne
	@JoinColumn(name = "post_student_id", referencedColumnName = "student_id", insertable = false, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne
	@JoinColumn(name = "post_teacher_id", referencedColumnName = "teacher_id", insertable = false, updatable = false, nullable = true)
	private TeacherBean teacherBean;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "thread_id")
	private ForumThreadBean forumThreadBean;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_post_id")
	private ForumPostBean forumPostBean;

	@OneToMany(mappedBy = "forumPostBean")
	private List<ForumPostBean> childPost = new ArrayList<>();

	public ForumPostBean() {

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

	public ForumThreadBean getForumThreadId() {
		return forumThreadBean;
	}

	public void setForumThreadId(ForumThreadBean forumThreadId) {
		this.forumThreadBean = forumThreadId;
	}

	public ForumPostBean getParentPostId() {
		return forumPostBean;
	}

	public void setParentPostId(ForumPostBean forumPostBean) {
		this.forumPostBean = forumPostBean;
	}

	public List<ForumPostBean> getChildPost() {
		return childPost;
	}

	public void setChildPost(List<ForumPostBean> childPost) {
		this.childPost = childPost;
	}

	public TeacherBean getTeacher() {
		return teacherBean;
	}

	public void setTeacher(TeacherBean teacherBean) {
		this.teacherBean = teacherBean;
	}

}
