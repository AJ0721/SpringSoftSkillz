package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "merchandise")
public class Merchandise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "merchandise_id")
    private Integer merchandiseId;

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "product_id")
    private Product product;

    @Column(name = "merchandise_name")
    private String merchandiseName;

    @Column(name = "merchandise_description")
    private String merchandiseDescription;

    @Column(name = "merchandise_price")
    private Integer merchandisePrice;

    @Column(name = "merchandise_stock_quantity")
    private Integer merchandiseStockQuantity;

    @Column(name = "merchandise_image_url")
    private String merchandiseImageUrl;
    
    // Constructor, getters and setters
    
	public Merchandise() {
	}
	
	public Merchandise(Integer merchandiseId, Product product, String merchandiseName, String merchandiseDescription,
			Integer merchandisePrice, Integer merchandiseStockQuantity, String merchandiseImageUrl) {
		this.merchandiseId = merchandiseId;
		this.product = product;
		this.merchandiseName = merchandiseName;
		this.merchandiseDescription = merchandiseDescription;
		this.merchandisePrice = merchandisePrice;
		this.merchandiseStockQuantity = merchandiseStockQuantity;
		this.merchandiseImageUrl = merchandiseImageUrl;
	}
	
	public Integer getMerchandiseId() {
		return merchandiseId;
	}
	
	public void setMerchandiseId(Integer merchandiseId) {
		this.merchandiseId = merchandiseId;
	}
	
	public Product getProduct() {
		return product;
	}
	
	public void setProduct(Product product) {
		this.product = product;
	}
	
	public String getMerchandiseName() {
		return merchandiseName;
	}
	
	public void setMerchandiseName(String merchandiseName) {
		this.merchandiseName = merchandiseName;
	}
	
	public String getMerchandiseDescription() {
		return merchandiseDescription;
	}
	
	public void setMerchandiseDescription(String merchandiseDescription) {
		this.merchandiseDescription = merchandiseDescription;
	}
	
	public Integer getMerchandisePrice() {
		return merchandisePrice;
	}
	
	public void setMerchandisePrice(Integer merchandisePrice) {
		this.merchandisePrice = merchandisePrice;
	}
	
	public Integer getMerchandiseStockQuantity() {
		return merchandiseStockQuantity;
	}
	
	public void setMerchandiseStockQuantity(Integer merchandiseStockQuantity) {
		this.merchandiseStockQuantity = merchandiseStockQuantity;
	}
	
	public String getMerchandiseImageUrl() {
		return merchandiseImageUrl;
	}
	
	public void setMerchandiseImageUrl(String merchandiseImageUrl) {
		this.merchandiseImageUrl = merchandiseImageUrl;
	}
	
	// toString
	@Override
	public String toString() {
		return "Merchandise [merchandiseId=" + merchandiseId + ", product=" + product + ", merchandiseName="
				+ merchandiseName + ", merchandiseDescription=" + merchandiseDescription + ", merchandisePrice="
				+ merchandisePrice + ", merchandiseStockQuantity=" + merchandiseStockQuantity + ", merchandiseImageUrl="
				+ merchandiseImageUrl + "]";
	}
}
