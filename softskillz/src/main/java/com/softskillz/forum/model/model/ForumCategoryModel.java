package com.softskillz.forum.model.model;

import java.util.LinkedHashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;


@Component @Entity
@Table(name = "forum_category")
public class ForumCategoryModel  {


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "forum_category_id")
	private Integer forumCategoryId;

	@Column(name = "forum_category_name")
	private String forumCategoryName;

	@Column(name = "forum_category_description")
	private String forumCategoryDescription;

	@OneToMany(mappedBy = "forumCategoryModel")
	private Set<ForumThreadModel> forumThreads = new LinkedHashSet<>();

	public ForumCategoryModel() {

	}



	//for update
	public ForumCategoryModel(Integer forumCategoryId, String forumCategoryName, String forumCategoryDescription) {
		this.forumCategoryId = forumCategoryId;
		this.forumCategoryName = forumCategoryName;
		this.forumCategoryDescription = forumCategoryDescription;
	}

	// for insertion
	public ForumCategoryModel(String forumCategoryName, String forumCategoryDescription) {
		this.forumCategoryName = forumCategoryName;
		this.forumCategoryDescription = forumCategoryDescription;
	}



	public Integer getForumCategoryId() {
		return forumCategoryId;
	}



	public void setForumCategoryId(Integer forumCategoryId) {
		this.forumCategoryId = forumCategoryId;
	}



	public String getForumCategoryName() {
		return forumCategoryName;
	}



	public void setForumCategoryName(String forumCategoryName) {
		this.forumCategoryName = forumCategoryName;
	}



	public String getForumCategoryDescription() {
		return forumCategoryDescription;
	}



	public void setForumCategoryDescription(String forumCategoryDescription) {
		this.forumCategoryDescription = forumCategoryDescription;
	}



	public Set<ForumThreadModel> getForumThreads() {
		return forumThreads;
	}



	public void setForumThreads(Set<ForumThreadModel> forumThreads) {
		this.forumThreads = forumThreads;
	}



	
	

}