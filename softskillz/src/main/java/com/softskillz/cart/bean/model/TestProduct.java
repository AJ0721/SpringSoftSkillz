package com.softskillz.cart.bean.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import com.softskillz.cart.enums.ProductStatusEnum;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Component
@Table(name = "test_product")
public class TestProduct {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_id")
	private Long productId;
	
	@Column(name = "product_name")
	private String productName;
	
	@Column(name = "price")
	private BigDecimal productPrice;
	
	@Column(name = "description_text")
	private String productDescription;
	
	@Column(name = "stock")
	private Integer productStock;
	
	@Column(name = "product_status")
	private ProductStatusEnum productStatus = ProductStatusEnum.VISIBLE;
	
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@Column(name = "create_at", updatable = false)
	private LocalDateTime createAt;
	
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@Column(name = "update_at", insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	@OneToMany(mappedBy = "testProduct", cascade=CascadeType.REMOVE, orphanRemoval = true)
	private List<ProductImage> productImgs = new ArrayList<>();

	@OneToMany(mappedBy = "testProduct", orphanRemoval = true)
	private List<TestOrderItem> orderItems=new ArrayList<>();
	
	@ManyToOne(fetch = FetchType.LAZY, optional = false )
	@JoinColumn(name = "product_category_id", referencedColumnName = "product_category_id", nullable = false, unique = true)
	private ProductCategory productCategory;


	// insert
	public TestProduct(String productName, BigDecimal productPrice, String productDescription, Integer productStock,
			ProductStatusEnum productStatus, List<ProductImage> productImgs, ProductCategory productCategory) {
		this.productName = productName;
		this.productPrice = productPrice;
		this.productDescription = productDescription;
		this.productStock = productStock;
		this.productStatus = productStatus;
		this.productImgs = productImgs;
		this.productCategory = productCategory;
	}

	// update
	public TestProduct(Long productId, String productName, BigDecimal productPrice, String productDescription,
			Integer productStock, ProductStatusEnum productStatus, List<ProductImage> productImgs,
			ProductCategory productCategory) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productDescription = productDescription;
		this.productStock = productStock;
		this.productStatus = productStatus;
		this.productImgs = productImgs;
		this.productCategory = productCategory;
	}

	// set product status 
	public void updateProductStatus(ProductStatusEnum newStatus) {
		this.productStatus = newStatus;
	}

}
