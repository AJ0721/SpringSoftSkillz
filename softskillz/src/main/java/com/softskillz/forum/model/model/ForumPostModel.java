package com.softskillz.forum.model.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.annotations.BatchSize;
import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.forum.model.StatusEnum;

import io.micrometer.common.lang.NonNull;
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
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@NamedEntityGraph(
	    name = "ForumPost.All",
	    attributeNodes = {
	        @NamedAttributeNode("teacherBean"),
	        @NamedAttributeNode(value = "studentBean", subgraph = "studentBean.subgraph"),
	        @NamedAttributeNode("adminBean"),
	        @NamedAttributeNode(value = "forumThreadModel", subgraph = "forumThreadModel.subgraph"),
	        @NamedAttributeNode(value = "forumPostModel", subgraph = "forumPostModel.subgraph")
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
	                @NamedAttributeNode(value = "forumPostModel", subgraph = "forumPostModel.subgraph")
	            }
	        ),
	        @NamedSubgraph(
	            name = "forumPostModel.subgraph",
	            attributeNodes = {
	                @NamedAttributeNode("studentBean"),
	                @NamedAttributeNode("teacherBean"),
	                @NamedAttributeNode("adminBean")
	            }
	        )
	    }
	)
@Getter
@Setter
@NoArgsConstructor
@Component
@BatchSize (size = 20)
@Table(name = "forum_post")
public class ForumPostModel {

	@Id
	@Column(name = "post_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer postId;

	@NonNull
	@Column(name = "post_content")
	private String postContent;

	@Column(name = "post_upvote_count")
	private int postUpvoteCount = 0;

	@Column(name = "post_response_count")
	private int postResponseCount = 0;

	@Column(name = "post_created_time", insertable = false, updatable = false)
	private Date postCreatedTime;

	
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

	
	// update post
	public ForumPostModel(@NonNull String postContent) {
		this.postContent = postContent;
	}

	// update post status
	public ForumPostModel(StatusEnum postStatus) {
		this.postStatus = postStatus;
	}

	// insert post
	public ForumPostModel(Integer postId, @NonNull String postContent) {
		this.postId = postId;
		this.postContent = postContent;
	}
	
	public void setStatusDeleted() {
		this.postStatus= StatusEnum.DELETED;
	}

	
	
}
