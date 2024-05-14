package com.softskillz.mall.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.softskillz.mall.serializer.ProductStockSerializer;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Set;


/**
 * 商品實體類
 */
@Entity
@Table(name = "product")
@JsonIgnoreProperties(value = { "handler", "hibernateLazyInitializer" })
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId; // 商品編號

    @Column(name = "product_name")
    private String productName; // 商品名稱

    @Column(name = "product_description")
    private String productDescription; // 商品描述

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_type_id")
    private ProductType productType; // 關聯的商品類型

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_status_id")
    private ProductStatus productStatus; // 關聯的商品狀態

    @Column(name = "product_price")
    private BigDecimal productPrice; // 商品價格

    @Column(name = "product_stock")
    @JsonSerialize(using = ProductStockSerializer.class)
    private Integer productStock; // 商品庫存

    @Column(name = "product_target_audience")
    private String productTargetAudience; // 目標客群

    @Column(name = "product_author_name")
    private String productAuthorName; // 作者名稱

    @Column(name = "product_isbn")
    private String productISBN; // ISBN編號

    @Column(name = "product_publication_date")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate productPublicationDate; // 出版日期

    @Column(name = "product_create_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime productCreateDate; // 商品創建日期

    @Column(name = "product_update_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime productUpdateDate; // 商品更新日期

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_id")
    private Coupon coupon; // 關聯的優惠券

    // 關聯操作(當一個 Product 被刪除時，其相關的所有 ProductImage 實體也會被自動刪除。)
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ProductImage> images;

    // 關聯操作(當一個 Product 被刪除時，其相關的所有 ProductVideo 實體也會被自動刪除。)
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<ProductVideo> videos;

    // 無參數建構子
    public Product() {
    }

    // 帶參數建構子
    public Product(Integer productId, String productName, String productDescription, ProductType productType, ProductStatus productStatus, BigDecimal productPrice, Integer productStock, String productTargetAudience, String productAuthorName, String productISBN, LocalDate productPublicationDate, LocalDateTime productCreateDate, LocalDateTime productUpdateDate, Coupon coupon) {
        this.productId = productId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.productType = productType;
        this.productStatus = productStatus;
        this.productPrice = productPrice;
        this.productStock = productStock;
        this.productTargetAudience = productTargetAudience;
        this.productAuthorName = productAuthorName;
        this.productISBN = productISBN;
        this.productPublicationDate = productPublicationDate;
        this.productCreateDate = productCreateDate;
        this.productUpdateDate = productUpdateDate;
        this.coupon = coupon;
    }

    // Getters、Setters
    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
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

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    public ProductStatus getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(ProductStatus productStatus) {
        this.productStatus = productStatus;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
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

    public String getProductAuthorName() {
        return productAuthorName;
    }

    public void setProductAuthorName(String productAuthorName) {
        this.productAuthorName = productAuthorName;
    }

    public String getProductISBN() {
        return productISBN;
    }

    public void setProductISBN(String productISBN) {
        this.productISBN = productISBN;
    }

    public LocalDate getProductPublicationDate() {
        return productPublicationDate;
    }

    public void setProductPublicationDate(LocalDate productPublicationDate) {
        this.productPublicationDate = productPublicationDate;
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

    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }

    // toString方法
    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productDescription='" + productDescription + '\'' +
                ", productType=" + productType +
                ", productStatus=" + productStatus +
                ", productPrice=" + productPrice +
                ", productStock=" + productStock +
                ", productTargetAudience='" + productTargetAudience + '\'' +
                ", productAuthorName='" + productAuthorName + '\'' +
                ", productISBN='" + productISBN + '\'' +
                ", productPublicationDate=" + productPublicationDate +
                ", productCreateDate=" + productCreateDate +
                ", productUpdateDate=" + productUpdateDate +
                ", coupon=" + coupon +
                '}';
    }
}
