package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * 商品類型實體類
 */
@Entity
@Table(name = "product_type")
public class ProductType {

    @Id
    @Column(name = "product_type_id")
    private Integer productTypeId; // 商品類型編號

    @Column(name = "product_type_name")
    private String productTypeName; // 商品類型名稱

    @Column(name = "product_type_description")
    private String productTypeDescription; // 商品類型描述

    // 無參數建構子
    public ProductType() {
    }

    // 帶參數建構子
    public ProductType(Integer productTypeId, String productTypeName, String productTypeDescription) {
        this.productTypeId = productTypeId;
        this.productTypeName = productTypeName;
        this.productTypeDescription = productTypeDescription;
    }

    // Getters、Setters
    public Integer getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(Integer productTypeId) {
        this.productTypeId = productTypeId;
    }

    public String getProductTypeName() {
        return productTypeName;
    }

    public void setProductTypeName(String productTypeName) {
        this.productTypeName = productTypeName;
    }

    public String getProductTypeDescription() {
        return productTypeDescription;
    }

    public void setProductTypeDescription(String productTypeDescription) {
        this.productTypeDescription = productTypeDescription;
    }

    // toString方法
    @Override
    public String toString() {
        return "ProductType{" +
                "productTypeId=" + productTypeId +
                ", productTypeName='" + productTypeName + '\'' +
                ", productTypeDescription='" + productTypeDescription + '\'' +
                '}';
    }
}
