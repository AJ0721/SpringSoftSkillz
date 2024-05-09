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
 * 商品影片實體類
 */
@Entity
@Table(name = "product_video")
public class ProductVideo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_video_id")
    private Integer productVideoId; // 商品影片編號

    @Column(name = "product_video_url")
    private String productVideoUrl; // 商品影片URL

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product; // 關聯的商品

    // 無參數建構子
    public ProductVideo() {
    }

    // 帶參數建構子
    public ProductVideo(Integer productVideoId, String productVideoUrl, Product product) {
        this.productVideoId = productVideoId;
        this.productVideoUrl = productVideoUrl;
        this.product = product;
    }

    // Getters、Setters
    public Integer getProductVideoId() {
        return productVideoId;
    }

    public void setProductVideoId(Integer productVideoId) {
        this.productVideoId = productVideoId;
    }

    public String getProductVideoUrl() {
        return productVideoUrl;
    }

    public void setProductVideoUrl(String productVideoUrl) {
        this.productVideoUrl = productVideoUrl;
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
        return "ProductVideo{" +
                "productVideoId=" + productVideoId +
                ", productVideoUrl='" + productVideoUrl + '\'' +
                ", product=" + product +
                '}';
    }
}
