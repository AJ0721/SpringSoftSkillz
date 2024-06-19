package com.softskillz.forum.model.model;

import java.util.LinkedHashSet;
import java.util.Set;

import org.hibernate.annotations.BatchSize;
import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Component
@Entity
@BatchSize(size = 20)
@Table(name = "forum_category")
public class ForumCategoryModel {

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

	

	// for update
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



}