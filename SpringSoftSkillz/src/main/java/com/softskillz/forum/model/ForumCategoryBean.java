package com.softskillz.forum.model;

import java.io.Serializable;
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


@Component 
@Entity @Table(name = "forum_category")
public class ForumCategoryBean implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "forum_category_id")
	private int forumCategoryId;
	
	@Column(name = "forum_category_name")
	private String forumCategoryName;
	
	 @OneToMany(mappedBy = "forumCategoryBean")
	    private Set<ForumThreadBean> forumThreads = new LinkedHashSet<>();
	
	 
	 
	public ForumCategoryBean() {
		
	}
	public Set<ForumThreadBean> getForumThreads() {
		return forumThreads;
	}
	public void setForumThreads(Set<ForumThreadBean> forumThreads) {
		this.forumThreads = forumThreads;
	}
	public int getForumCategoryId() {
		return forumCategoryId;
	}
	public void setForumCategoryId(int forumCategoryId) {
		this.forumCategoryId = forumCategoryId;
	}
	public String getForumCategoryName() {
		return forumCategoryName;
	}
	public void setForumCategoryName(String forumCategoryName) {
		this.forumCategoryName = forumCategoryName;
	}

	
	
	
	
	

	
}