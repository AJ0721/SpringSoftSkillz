package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

/**
 * 商品圖片實體類
 */
@Entity
@Table(name = "product_image")
public class ProductImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_image_id")
    private Integer productImageId; // 商品圖片編號

    @Column(name = "product_image_url")
    private String productImageUrl; // 商品圖片URL

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product; // 關聯的商品

    // 無參數建構子
    public ProductImage() {
    }

    // 帶參數建構子
    public ProductImage(Integer productImageId, String productImageUrl, Product product) {
        this.productImageId = productImageId;
        this.productImageUrl = productImageUrl;
        this.product = product;
    }

    // Getters、Setters
    public Integer getProductImageId() {
        return productImageId;
    }

    public void setProductImageId(Integer productImageId) {
        this.productImageId = productImageId;
    }

    public String getProductImageUrl() {
        return productImageUrl;
    }

    public void setProductImageUrl(String productImageUrl) {
        this.productImageUrl = productImageUrl;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    // toString方法
    @Override
    public String toString() {
        return "ProductImage{" +
                "productImageId=" + productImageId +
                ", productImageUrl='" + productImageUrl + '\'' +
                ", product=" + product +
                '}';
    }
}
