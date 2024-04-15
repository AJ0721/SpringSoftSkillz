package com.softskillz.forum.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.StudentBean;
import com.softskillz.account.model.TeacherBean;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Component
@Table(name = "forum_thread")
public class ForumThreadBean implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "thread_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int threadId;

	@Column(name = "thread_title")
	private String threadTitle;

	@Column(name = "thread_created_time", insertable = false, updatable = false)
	private Timestamp threadCreatedTime;

	@Column(name = "thread_content")
	private String threadContent;

	@Column(name = "thread_upvote_count")
	private int threadUpvoteCount = 0;

	@Column(name = "thread_response_count")
	private int threadResponseCount = 0;

	@Column(name = "thread_status")
	private String threadStatus = "VISIBLE";

	@ManyToOne
	@JoinColumn(name = "forum_category_id", referencedColumnName = "forum_category_id")
	private ForumCategoryBean forumCategoryBean;

	@OneToMany(mappedBy = "forumThreadBean", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<ForumPostBean> posts = new ArrayList<>();

	@ManyToOne
	@JoinColumn(name = "thread_student_id", referencedColumnName = "student_id", insertable = true, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne
	@JoinColumn(name = "thread_teacher_id", referencedColumnName = "teacher_id", insertable = true, updatable = false, nullable = true)
	private TeacherBean teacherBean;

	public ForumThreadBean() {

	}

	public ForumThreadBean(String threadTitle, String threadContent, ForumCategoryBean forumCategoryBean) {
		;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
		this.forumCategoryBean = forumCategoryBean;
	}

	public int getThreadId() {
		return threadId;
	}

	public void setThreadId(int threadId) {
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

	public ForumCategoryBean getForumCategoryBean() {
		return forumCategoryBean;
	}

	public void setForumCategoryBean(ForumCategoryBean forumCategoryBean) {
		this.forumCategoryBean = forumCategoryBean;
	}

	public List<ForumPostBean> getPosts() {
		return posts;
	}

	public void setPosts(List<ForumPostBean> posts) {
		this.posts = posts;
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

}
