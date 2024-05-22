package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

/**
 * 優惠券與商品類型關聯實體類
 */
@Entity
@Table(name = "coupon_type_relations")
@IdClass(CouponTypeRelationsId.class)
public class CouponTypeRelations {

    @Id
    @Column(name = "coupon_id")
    private Integer couponId; // 優惠券編號

    @Id
    @Column(name = "product_type_id")
    private Integer productTypeId; // 商品類型編號

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_id")
    private Coupon coupon; // 關聯的優惠券

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_type_id")
    private ProductType productType; // 關聯的商品類型

    // 無參數建構子
    public CouponTypeRelations() {
    }

    // 帶參數建構子
    public CouponTypeRelations(Integer couponId, Integer productTypeId, Coupon coupon, ProductType productType) {
        this.couponId = couponId;
        this.productTypeId = productTypeId;
        this.coupon = coupon;
        this.productType = productType;
    }

    // Getters、Setters
    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public Integer getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(Integer productTypeId) {
        this.productTypeId = productTypeId;
    }

    public Coupon getCoupon() {
        return coupon;
    }

    public void setCoupon(Coupon coupon) {
        this.coupon = coupon;
    }

    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    // toString方法
    @Override
    public String toString() {
        return "CouponTypeRelations{" +
                "couponId=" + couponId +
                ", productTypeId=" + productTypeId +
                ", coupon=" + coupon +
                ", productType=" + productType +
                '}';
    }
}
