package com.softskillz.forum.model.model;

import java.sql.Timestamp;

import org.hibernate.annotations.BatchSize;
import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Component
@BatchSize(size = 20)
@Table(name = "forum_image")
public class ForumImageModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "forum_image_id")
	private int forumImageId;

	@ManyToOne
	@JoinColumn(name = "thread_id", referencedColumnName = "thread_id", insertable = true, updatable = false, nullable = true)
	private ForumThreadModel forumThreadModel;

	@ManyToOne
	@JoinColumn(name = "post_id", referencedColumnName = "post_id", insertable = true, updatable = false, nullable = true)
	private ForumPostModel forumPostModel;

	@Column(name = "forum_image_path")
	private String forumImagePath;

	@Column(name = "forum_image_upload_date")
	private Timestamp forumImgUploadDate;

	public int getForumImageId() {
		return forumImageId;
	}

	public void setForumImageId(int forumImageId) {
		this.forumImageId = forumImageId;
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

	public String getForumImagePath() {
		return forumImagePath;
	}

	public void setForumImagePath(String forumImagePath) {
		this.forumImagePath = forumImagePath;
	}

	public Timestamp getForumImgUploadDate() {
		return forumImgUploadDate;
	}

	public void setForumImgUploadDate(Timestamp forumImgUploadDate) {
		this.forumImgUploadDate = forumImgUploadDate;
	}

}
