package com.softskillz.mall.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * 優惠券類型實體類
 */
@Entity
@Table(name = "coupon_type")
public class CouponType {

    @Id
    @Column(name = "coupon_type_id")
    private Integer couponTypeId; // 優惠券類型編號

    @Column(name = "coupon_type_name")
    private String couponTypeName; // 優惠券類型名稱

    // 無參數建構子
    public CouponType() {
    }

    // 帶參數建構子
    public CouponType(Integer couponTypeId, String couponTypeName) {
        this.couponTypeId = couponTypeId;
        this.couponTypeName = couponTypeName;
    }

    // Getters、Setters
    public Integer getCouponTypeId() {
        return couponTypeId;
    }

    public void setCouponTypeId(Integer couponTypeId) {
        this.couponTypeId = couponTypeId;
    }

    public String getCouponTypeName() {
        return couponTypeName;
    }

    public void setCouponTypeName(String couponTypeName) {
        this.couponTypeName = couponTypeName;
    }

    // toString方法
    @Override
    public String toString() {
        return "CouponType{" +
                "couponTypeId=" + couponTypeId +
                ", couponTypeName='" + couponTypeName + '\'' +
                '}';
    }
}
