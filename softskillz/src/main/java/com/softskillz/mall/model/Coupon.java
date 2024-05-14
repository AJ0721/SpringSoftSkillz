package com.softskillz.mall.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

/**
 * 優惠券實體類
 */
@Entity
@Table(name = "coupon")
public class Coupon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "coupon_id")
    private Integer couponId; // 優惠券編號

    @Column(name = "coupon_code")
    private String couponCode; // 優惠券代碼

    @Column(name = "coupon_name")
    private String couponName; // 優惠券名稱

    @Column(name = "coupon_description")
    private String couponDescription; // 優惠券描述

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coupon_type_id")
    private CouponType couponType; // 關聯的優惠券類型

    @Column(name = "coupon_amount")
    private BigDecimal couponAmount; // 優惠金額

    @Column(name = "coupon_rate")
    private BigDecimal couponRate; // 優惠折扣率

    @Column(name = "coupon_buy_quantity")
    private Integer couponBuyQuantity; // 購買數量條件

    @Column(name = "coupon_get_quantity")
    private Integer couponGetQuantity; // 贈送數量條件

    @Column(name = "coupon_start_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime couponStartDate; // 優惠券開始日期

    @Column(name = "coupon_end_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime couponEndDate; // 優惠券結束日期

    // 關聯操作(當一個 Coupon 被刪除時，其相關的所有 CouponTypeRelations 實體也會被自動刪除。)
    @OneToMany(mappedBy = "coupon", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<CouponTypeRelations> couponTypeRelations;

    // 無參數建構子
    public Coupon() {
    }

    // 帶參數建構子
    public Coupon(Integer couponId, String couponCode, String couponName, String couponDescription, CouponType couponType, BigDecimal couponAmount, BigDecimal couponRate, Integer couponBuyQuantity, Integer couponGetQuantity, LocalDateTime couponStartDate, LocalDateTime couponEndDate) {
        this.couponId = couponId;
        this.couponCode = couponCode;
        this.couponName = couponName;
        this.couponDescription = couponDescription;
        this.couponType = couponType;
        this.couponAmount = couponAmount;
        this.couponRate = couponRate;
        this.couponBuyQuantity = couponBuyQuantity;
        this.couponGetQuantity = couponGetQuantity;
        this.couponStartDate = couponStartDate;
        this.couponEndDate = couponEndDate;
    }

    // Getters、Setters
    public Integer getCouponId() {
        return couponId;
    }

    public void setCouponId(Integer couponId) {
        this.couponId = couponId;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponDescription() {
        return couponDescription;
    }

    public void setCouponDescription(String couponDescription) {
        this.couponDescription = couponDescription;
    }

    public CouponType getCouponType() {
        return couponType;
    }

    public void setCouponType(CouponType couponType) {
        this.couponType = couponType;
    }

    public BigDecimal getCouponAmount() {
        return couponAmount;
    }

    public void setCouponAmount(BigDecimal couponAmount) {
        this.couponAmount = couponAmount;
    }

    public BigDecimal getCouponRate() {
        return couponRate;
    }

    public void setCouponRate(BigDecimal couponRate) {
        this.couponRate = couponRate;
    }

    public Integer getCouponBuyQuantity() {
        return couponBuyQuantity;
    }

    public void setCouponBuyQuantity(Integer couponBuyQuantity) {
        this.couponBuyQuantity = couponBuyQuantity;
    }

    public Integer getCouponGetQuantity() {
        return couponGetQuantity;
    }

    public void setCouponGetQuantity(Integer couponGetQuantity) {
        this.couponGetQuantity = couponGetQuantity;
    }

    public LocalDateTime getCouponStartDate() {
        return couponStartDate;
    }

    public void setCouponStartDate(LocalDateTime couponStartDate) {
        this.couponStartDate = couponStartDate;
    }

    public LocalDateTime getCouponEndDate() {
        return couponEndDate;
    }

    public void setCouponEndDate(LocalDateTime couponEndDate) {
        this.couponEndDate = couponEndDate;
    }

    // toString方法
    @Override
    public String toString() {
        return "Coupon{" +
                "couponId=" + couponId +
                ", couponCode='" + couponCode + '\'' +
                ", couponName='" + couponName + '\'' +
                ", couponDescription='" + couponDescription + '\'' +
                ", couponType=" + couponType +
                ", couponAmount=" + couponAmount +
                ", couponRate=" + couponRate +
                ", couponBuyQuantity=" + couponBuyQuantity +
                ", couponGetQuantity=" + couponGetQuantity +
                ", couponStartDate=" + couponStartDate +
                ", couponEndDate=" + couponEndDate +
                '}';
    }
}
