package com.softskillz.mall.model;

import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "tutorialvideo")
public class TutorialVideo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "video_id")
	private Integer videoId;

	@ManyToOne
	@JoinColumn(name = "product_id", referencedColumnName = "product_id")
	private Product product;

	@Column(name = "video_title")
	private String videoTitle;

	@Column(name = "video_description")
	private String videoDescription;

	@Column(name = "video_url")
	private String videoUrl;

	@CreatedDate
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
	@Column(name = "video_upload_date")
	private LocalDateTime videoUploadDate;

	@Column(name = "video_thumbnail_url")
	private String videoThumbnailUrl;

	// Constructor, getters and setters
	public TutorialVideo() {
	}

	public TutorialVideo(Integer videoId, Product product, String videoTitle, String videoDescription, String videoUrl,
			LocalDateTime videoUploadDate, String videoThumbnailUrl) {
		this.videoId = videoId;
		this.product = product;
		this.videoTitle = videoTitle;
		this.videoDescription = videoDescription;
		this.videoUrl = videoUrl;
		this.videoUploadDate = videoUploadDate;
		this.videoThumbnailUrl = videoThumbnailUrl;
	}

	public Integer getVideoId() {
		return videoId;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getVideoTitle() {
		return videoTitle;
	}

	public void setVideoTitle(String videoTitle) {
		this.videoTitle = videoTitle;
	}

	public String getVideoDescription() {
		return videoDescription;
	}

	public void setVideoDescription(String videoDescription) {
		this.videoDescription = videoDescription;
	}

	public String getVideoUrl() {
		return videoUrl;
	}

	public void setVideoUrl(String videoUrl) {
		this.videoUrl = videoUrl;
	}

	public LocalDateTime getVideoUploadDate() {
		return videoUploadDate;
	}

	public void setVideoUploadDate(LocalDateTime videoUploadDate) {
		this.videoUploadDate = videoUploadDate;
	}

	public String getVideoThumbnailUrl() {
		return videoThumbnailUrl;
	}

	public void setVideoThumbnailUrl(String videoThumbnailUrl) {
		this.videoThumbnailUrl = videoThumbnailUrl;
	}

	public void setVideoId(Integer videoId) {
		this.videoId = videoId;
	}

	// toString
	@Override
	public String toString() {
		return "TutorialVideo [videoId=" + videoId + ", product=" + product + ", videoTitle=" + videoTitle
				+ ", videoDescription=" + videoDescription + ", videoUrl=" + videoUrl + ", videoUploadDate="
				+ videoUploadDate + ", videoThumbnailUrl=" + videoThumbnailUrl + "]";
	}
}
