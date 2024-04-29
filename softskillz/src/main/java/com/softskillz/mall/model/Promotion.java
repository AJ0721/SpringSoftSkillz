package com.softskillz.mall.model;

import java.time.LocalDateTime;

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
@Table(name = "promotion")
public class Promotion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "promotion_id")
    private Integer promotionId;

    @ManyToOne
    @JoinColumn(name = "promotion_product_category", referencedColumnName = "product_category_id")
    private ProductCategory promotionProductCategory;

    @Column(name = "promotion_name")
    private String promotionName;

    @Column(name = "promotion_description")
    private String promotionDescription;

    @Column(name = "promotion_discount")
    private Double promotionDiscount;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
    @Column(name = "promotion_start_date")
    private LocalDateTime promotionStartDate;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
    @Column(name = "promotion_end_date")
    private LocalDateTime promotionEndDate;
    
    // Constructor, getters and setters
	public Promotion() {
	}
	
	public Promotion(Integer promotionId, ProductCategory promotionProductCategory, String promotionName,
			String promotionDescription, Double promotionDiscount, LocalDateTime promotionStartDate,
			LocalDateTime promotionEndDate) {
		this.promotionId = promotionId;
		this.promotionProductCategory = promotionProductCategory;
		this.promotionName = promotionName;
		this.promotionDescription = promotionDescription;
		this.promotionDiscount = promotionDiscount;
		this.promotionStartDate = promotionStartDate;
		this.promotionEndDate = promotionEndDate;
	}
	
	public Integer getPromotionId() {
		return promotionId;
	}
	
	public void setPromotionId(Integer promotionId) {
		this.promotionId = promotionId;
	}
	
	public ProductCategory getPromotionProductCategory() {
		return promotionProductCategory;
	}
	
	public void setPromotionProductCategory(ProductCategory promotionProductCategory) {
		this.promotionProductCategory = promotionProductCategory;
	}
	
	public String getPromotionName() {
		return promotionName;
	}
	
	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}
	
	public String getPromotionDescription() {
		return promotionDescription;
	}
	
	public void setPromotionDescription(String promotionDescription) {
		this.promotionDescription = promotionDescription;
	}
	
	public Double getPromotionDiscount() {
		return promotionDiscount;
	}
	
	public void setPromotionDiscount(Double promotionDiscount) {
		this.promotionDiscount = promotionDiscount;
	}
	
	public LocalDateTime getPromotionStartDate() {
		return promotionStartDate;
	}
	
	public void setPromotionStartDate(LocalDateTime promotionStartDate) {
		this.promotionStartDate = promotionStartDate;
	}
	
	public LocalDateTime getPromotionEndDate() {
		return promotionEndDate;
	}
	
	public void setPromotionEndDate(LocalDateTime promotionEndDate) {
		this.promotionEndDate = promotionEndDate;
	}

	// toString
	@Override
	public String toString() {
		return "Promotion [promotionId=" + promotionId + ", promotionProductCategory=" + promotionProductCategory
				+ ", promotionName=" + promotionName + ", promotionDescription=" + promotionDescription
				+ ", promotionDiscount=" + promotionDiscount + ", promotionStartDate=" + promotionStartDate
				+ ", promotionEndDate=" + promotionEndDate + "]";
	}
	
	
}