package com.softskillz.forum.model.model;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.annotations.BatchSize;
import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.AdminBean;
import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.account.model.bean.TeacherBean;
import com.softskillz.forum.model.StatusEnum;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
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

	

}
