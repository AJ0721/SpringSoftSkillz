package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * 商品狀態實體類
 */
@Entity
@Table(name = "product_status")
public class ProductStatus {

    @Id
    @Column(name = "product_status_id")
    private Integer productStatusId; // 商品狀態編號

    @Column(name = "product_status_name")
    private String productStatusName; // 商品狀態名稱

    // 無參數建構子
    public ProductStatus() {
    }

    // 帶參數建構子
    public ProductStatus(Integer productStatusId, String productStatusName) {
        this.productStatusId = productStatusId;
        this.productStatusName = productStatusName;
    }

    // Getters、Setters
    public Integer getProductStatusId() {
        return productStatusId;
    }

    public void setProductStatusId(Integer productStatusId) {
        this.productStatusId = productStatusId;
    }

    public String getProductStatusName() {
        return productStatusName;
    }

    public void setProductStatusName(String productStatusName) {
        this.productStatusName = productStatusName;
    }

    // toString方法
    @Override
    public String toString() {
        return "ProductStatus{" +
                "productStatusId=" + productStatusId +
                ", productStatusName='" + productStatusName + '\'' +
                '}';
    }
}
