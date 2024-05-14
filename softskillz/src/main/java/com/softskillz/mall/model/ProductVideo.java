package com.softskillz.mall.model;

import jakarta.persistence.*;

import java.util.Objects;

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

    // equals方法
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductVideo that = (ProductVideo) o;
        return Objects.equals(productVideoId, that.productVideoId);
    }

    // hashCode方法
    @Override
    public int hashCode() {
        return Objects.hash(productVideoId);
    }
}
