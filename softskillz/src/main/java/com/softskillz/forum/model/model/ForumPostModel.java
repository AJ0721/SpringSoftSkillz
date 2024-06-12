package com.softskillz.forum.model.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.BatchSize;
import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.forum.model.StatusEnum;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedAttributeNode;
import jakarta.persistence.NamedEntityGraph;
import jakarta.persistence.NamedSubgraph;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@NamedEntityGraph(
	    name = "ForumPost.All",
	    attributeNodes = {
	        @NamedAttributeNode("teacherBean"),
	        @NamedAttributeNode(value = "studentBean", subgraph = "studentBean.subgraph"),
	        @NamedAttributeNode("adminBean"),
	        @NamedAttributeNode(value = "forumThreadModel", subgraph = "forumThreadModel.subgraph"),
	        @NamedAttributeNode("forumPostModel") // Self-referencing subgraph
	    },
	    subgraphs = {
	        @NamedSubgraph(
	            name = "studentBean.subgraph",
	            attributeNodes = {
	                @NamedAttributeNode("companionBean")
	            }
	        ),
	        @NamedSubgraph(
	            name = "forumThreadModel.subgraph",
	            attributeNodes = {
	                @NamedAttributeNode("forumCategoryModel"),
	                @NamedAttributeNode("studentBean"),
	                @NamedAttributeNode("teacherBean"),
	                @NamedAttributeNode("adminBean"),
	                @NamedAttributeNode("forumPostModel") // Forum posts in the thread
	            }
	        )
	    }
	)
@Component
@BatchSize (size = 20)
@Table(name = "forum_post")
public class ForumPostModel {

	@Id
	@Column(name = "post_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer postId;

	@Column(name = "post_content")
	private String postContent;

	@Column(name = "post_upvote_count")
	private int postUpvoteCount = 0;

	@Column(name = "post_response_count")
	private int postResponseCount = 0;

	@Column(name = "post_created_time", insertable = false, updatable = false)
	private Timestamp postCreatedTime;

	
	@Column(name = "post_status") @Enumerated(EnumType.STRING)
	private StatusEnum postStatus = StatusEnum.VISIBLE;

	@ManyToOne(optional = true)
	@JoinColumn(name = "post_student_id", referencedColumnName = "student_id", insertable = true, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne(optional = true)
	@JoinColumn(name = "post_teacher_id", referencedColumnName = "teacher_id", insertable = true, updatable = false, nullable = true)
	private TeacherBean teacherBean;
	
	@ManyToOne(optional = true)
	@JoinColumn(name = "post_admin_id", referencedColumnName = "admin_id", insertable = true, updatable = false, nullable = true)
	private AdminBean adminBean;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "thread_id", insertable = true, updatable = false, nullable = false)
	private ForumThreadModel forumThreadModel;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_post_id", insertable = true, updatable = false, nullable = true)
	private ForumPostModel forumPostModel;

	@OneToMany(mappedBy = "forumPostModel", cascade = CascadeType.REMOVE)
	private List<ForumImageModel> forumImageModel = new ArrayList<ForumImageModel>();

	public ForumPostModel() {

	}

	// update post
	public ForumPostModel(String postContent) {
		this.postContent = postContent;
	}

	// update post status
	public ForumPostModel(StatusEnum postStatus) {
		this.postStatus = postStatus;
	}

	// insert post
	public ForumPostModel(Integer postId, String postContent) {
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

	public AdminBean getAdminBean() {
		return adminBean;
	}

	public void setAdminBean(AdminBean adminBean) {
		this.adminBean = adminBean;
	}

	public ForumThreadModel getForumThreadModel() {
		return forumThreadModel;
	}

	public void setForumThreadModel(ForumThreadModel forumThreadModel) {
		this.forumThreadModel = forumThreadModel;
	}

	public ForumPostModel getForumPostModel() {
		return forumPostModel;
	}

	public void setForumPostModel(ForumPostModel forumPostModel) {
		this.forumPostModel = forumPostModel;
	}

	
	public List<ForumImageModel> getForumImageModel() {
		return forumImageModel;
	}

	public void setForumImageModel(List<ForumImageModel> forumImageModel) {
		this.forumImageModel = forumImageModel;
	}

	public void setStatusDeleted() {
		this.postStatus= StatusEnum.DELETED;
	}
	
}
