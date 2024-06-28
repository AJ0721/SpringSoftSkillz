package com.softskillz.cart.bean.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Component
@Table(name = "product_category")
public class ProductCategory {

	@Id
	@Column(name = "product_category_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long productCategoryId;

	@Column(name = "product_category_name")
	private String productCategoryName;

	
	
	// update product category
	public ProductCategory(String productCategoryName) {
		this.productCategoryName = productCategoryName;
	}

}
