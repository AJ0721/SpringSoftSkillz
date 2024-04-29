package com.softskillz.forum.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;

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
public class ForumThreadModel{


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
	private ForumCategoryModel forumCategoryModel;
	

	@OneToMany(mappedBy = "forumThreadModel", cascade = CascadeType.REMOVE, orphanRemoval = true)
	private List<ForumPostModel> forumPostModel = new ArrayList<>();

	@ManyToOne(optional = true) 
	@JoinColumn(name = "thread_student_id", referencedColumnName = "student_id", insertable = true, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne(optional = true)
	@JoinColumn(name = "thread_teacher_id", referencedColumnName = "teacher_id", insertable = true, updatable = false, nullable = true)
	private TeacherBean teacherBean;
	
	@ManyToOne(optional = true)
	@JoinColumn(name = "thread_admin_id", referencedColumnName = "admin_id", insertable = true, updatable = false, nullable = true)
	private AdminBean adminBean;
	

	@OneToMany(mappedBy = "forumThreadModel", cascade = CascadeType.REMOVE)
	private List<ForumImageModel> forumImageModel = new ArrayList<ForumImageModel>();

	
	
	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;
		ForumThreadModel that = (ForumThreadModel) o;
		return Objects.equals(threadContent, that.threadContent);
	}

	//any two objects considered equal according to equals() will have the same hash code
	@Override
	public int hashCode() {
		return Objects.hash(threadContent);
	}

	public ForumThreadModel() {

	}

	// for new thread insertion
	public ForumThreadModel(ForumCategoryModel forumCategoryModel,String threadTitle, String threadContent ) {
		this.forumCategoryModel = forumCategoryModel;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
		
	}
	

//for existing thread update
	public ForumThreadModel(int threadId, String threadTitle, String threadContent) {
		this.threadId = threadId;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
	}
	
	


	public AdminBean getAdminBean() {
		return adminBean;
	}

	public void setAdminBean(AdminBean adminBean) {
		this.adminBean = adminBean;
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

	public ForumCategoryModel getForumCategoryModel() {
		return forumCategoryModel;
	}

	public void setForumCategoryModel(ForumCategoryModel forumCategoryModel) {
		this.forumCategoryModel = forumCategoryModel;
	}


	public List<ForumPostModel> getForumPostModel() {
		return forumPostModel;
	}

	public void setForumPostModel(List<ForumPostModel> forumPostModel) {
		this.forumPostModel = forumPostModel;
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

	public List<ForumImageModel> getForumImageModel() {
		return forumImageModel;
	}

	public void setForumImageModel(List<ForumImageModel> forumImageModel) {
		this.forumImageModel = forumImageModel;
	}

	
}
