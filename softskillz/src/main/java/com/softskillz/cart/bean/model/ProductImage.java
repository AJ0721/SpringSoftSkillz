package com.softskillz.cart.bean.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
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
@Component
@Entity
@Table(name = "image_url")
public class ProductImage {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "image_url_id")
	private Long imgUrlId;
	
	@Column(name = "image_url")
	private String imgUrl;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "product_id", referencedColumnName = "product_id", insertable = true, updatable=false, nullable = false)
	private TestProduct testProduct;

	//insert
	public ProductImage(String imgUrl, TestProduct testProduct) {
		this.imgUrl = imgUrl;
		this.testProduct = testProduct;
	}
	
	
	
	

}
