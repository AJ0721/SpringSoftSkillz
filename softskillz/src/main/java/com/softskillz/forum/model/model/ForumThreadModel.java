package com.softskillz.forum.model.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

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
	    name = "ForumThread.All",
	    attributeNodes = {
	        @NamedAttributeNode("teacherBean"),
	        @NamedAttributeNode(value = "studentBean", subgraph = "studentBean.subgraph"),
	        @NamedAttributeNode("forumCategoryModel"),
	        @NamedAttributeNode("adminBean")
	    },
	    subgraphs = {
	        @NamedSubgraph(
	            name = "studentBean.subgraph",
	            attributeNodes = {
	                @NamedAttributeNode("companionBean")
	            }
	        )
	    }
	)

@Getter
@Setter
@NoArgsConstructor
@Component
@BatchSize (size = 20)
@Table(name = "forum_thread")
public class ForumThreadModel {

	@Id
	@Column(name = "thread_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer threadId;

	@Column(name = "thread_title")
	private String threadTitle;

	@Column(name = "thread_created_time", insertable = false, updatable = false)
	private Date threadCreatedTime;

	@NonNull
	@Column(name = "thread_content")
	private String threadContent;

	@Column(name = "thread_upvote_count")
	private int threadUpvoteCount = 0;

	@Column(name = "thread_response_count")
	private int threadResponseCount = 0;

	@Enumerated(EnumType.STRING)
	@Column(name = "thread_status")
	private StatusEnum threadStatus = StatusEnum.VISIBLE;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "forum_category_id", referencedColumnName = "forum_category_id")
	private ForumCategoryModel forumCategoryModel;

	@OneToMany(mappedBy = "forumThreadModel", cascade = CascadeType.REMOVE, orphanRemoval = true)
	private List<ForumPostModel> forumPostModel = new ArrayList<>();

	@ManyToOne(optional = true, fetch = FetchType.LAZY)
	@JoinColumn(name = "thread_student_id", referencedColumnName = "student_id", insertable = true, updatable = false, nullable = true)
	private StudentBean studentBean;

	@ManyToOne(optional = true, fetch = FetchType.LAZY)
	@JoinColumn(name = "thread_teacher_id", referencedColumnName = "teacher_id", insertable = true, updatable = false, nullable = true)
	private TeacherBean teacherBean;

	@ManyToOne(optional = true, fetch = FetchType.LAZY)
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

	// any two objects considered equal according to equals() will have the same
	// hash code
	@Override
	public int hashCode() {
		return Objects.hash(threadContent);
	}

	

	// for new thread insertion
	public ForumThreadModel(ForumCategoryModel forumCategoryModel, String threadTitle, String threadContent) {
		this.forumCategoryModel = forumCategoryModel;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;

	}

	// for existing thread update
	public ForumThreadModel(Integer threadId, String threadTitle, String threadContent) {
		this.threadId = threadId;
		this.threadTitle = threadTitle;
		this.threadContent = threadContent;
	}

	// for existing thread status update
	public ForumThreadModel(StatusEnum threadStatus) {
		this.threadStatus = threadStatus;
	}


	public void setStatusDeleted() {
		this.threadStatus = StatusEnum.DELETED;
	}

}
