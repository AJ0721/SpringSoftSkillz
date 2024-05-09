package com.softskillz.mall.model;

import java.io.Serializable;
import java.util.Objects;

/**
 * 優惠券與商品類型關聯複合主鍵類
 */

public class CouponTypeRelationsId implements Serializable {

    private Integer couponId; // 優惠券編號

    private Integer productTypeId; // 商品類型編號

    // 無參數建構子
    public CouponTypeRelationsId() {
    }

    // 帶參數建構子
    public CouponTypeRelationsId(Integer couponId, Integer productTypeId) {
        this.couponId = couponId;
        this.productTypeId = productTypeId;
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

    // equals方法
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CouponTypeRelationsId that = (CouponTypeRelationsId) o;
        return Objects.equals(couponId, that.couponId) && Objects.equals(productTypeId, that.productTypeId);
    }

    // hashCode方法
    @Override
    public int hashCode() {
        return Objects.hash(couponId, productTypeId);
    }

    // toString方法
    @Override
    public String toString() {
        return "CouponTypeRelationsId{" +
                "couponId=" + couponId +
                ", productTypeId=" + productTypeId +
                '}';
    }
}
