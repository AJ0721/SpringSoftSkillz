package com.softskillz.mall.model;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.softskillz.mall.serializer.ProductStockSerializer;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "product")
@Component
public class Product implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_category_id", referencedColumnName = "product_category_id")
    private ProductCategory productCategory;

    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_description")
    private String productDescription;

    @Column(name = "product_price")
    private Integer productPrice;

    @Column(name = "product_stock")
//    @JsonSerialize(using = ProductStockSerializer.class)
    private Integer productStock; // Integer 可以接受 null 值

    @Column(name = "product_target_audience")
    private String productTargetAudience;

    @CreatedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
    @Column(name = "product_create_date")
    private LocalDateTime productCreateDate;

    @LastModifiedDate
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Taipei")
    @Column(name = "product_update_date")
    private LocalDateTime productUpdateDate;

    @Column(name = "product_image_url")
    private String productImageUrl;

 // Constructor, getters and setters
	public Product() {
	}
	
	public Product(Integer productId, ProductCategory productCategory, String productName, String productDescription,
		Integer productPrice, Integer productStock, String productTargetAudience, LocalDateTime productCreateDate,
		LocalDateTime productUpdateDate, String productImageUrl) {
	this.productId = productId;
	this.productCategory = productCategory;
	this.productName = productName;
	this.productDescription = productDescription;
	this.productPrice = productPrice;
	this.productStock = productStock;
	this.productTargetAudience = productTargetAudience;
	this.productCreateDate = productCreateDate;
	this.productUpdateDate = productUpdateDate;
	this.productImageUrl = productImageUrl;
}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public Integer getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Integer productPrice) {
		this.productPrice = productPrice;
	}

	public Integer getProductStock() {
		return productStock;
	}

	public void setProductStock(Integer productStock) {
		this.productStock = productStock;
	}

	public String getProductTargetAudience() {
		return productTargetAudience;
	}

	public void setProductTargetAudience(String productTargetAudience) {
		this.productTargetAudience = productTargetAudience;
	}

	public LocalDateTime getProductCreateDate() {
		return productCreateDate;
	}

	public void setProductCreateDate(LocalDateTime productCreateDate) {
		this.productCreateDate = productCreateDate;
	}

	public LocalDateTime getProductUpdateDate() {
		return productUpdateDate;
	}

	public void setProductUpdateDate(LocalDateTime productUpdateDate) {
		this.productUpdateDate = productUpdateDate;
	}

	public String getProductImageUrl() {
		return productImageUrl;
	}

	public void setProductImageUrl(String productImageUrl) {
		this.productImageUrl = productImageUrl;
	}
	
	
	// toString
	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productCategory=" + productCategory + ", productName="
				+ productName + ", productDescription=" + productDescription + ", productPrice=" + productPrice
				+ ", productStock=" + productStock + ", productTargetAudience=" + productTargetAudience
				+ ", productCreateDate=" + productCreateDate + ", productUpdateDate=" + productUpdateDate
				+ ", productImageUrl=" + productImageUrl + "]";
	}
	
	public String getFormattedProductStock() {
        return productStock == null ? "無限" : productStock.toString();
    }
}
