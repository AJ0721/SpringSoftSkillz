package com.softskillz.mall.service;

import com.softskillz.mall.model.Coupon;

import java.util.List;
import java.util.Optional;

/**
 * 優惠券服務接口，定義所有與優惠券相關的業務邏輯操作。
 */
public interface CouponService {

    /**
     * 查詢所有優惠券。
     * @return 所有優惠券的列表。
     */
    List<Coupon> findAllCoupons();

    /**
     * 根據優惠券ID查詢單個優惠券。
     * @param couponId 優惠券的唯一標識符。
     * @return 包含優惠券的 Optional 實例，如果找不到則為空。
     */
    Optional<Coupon> findCouponById(Integer couponId);

    /**
     * 創建一個新的優惠券。
     * @param coupon 優惠券實體。
     * @return 創建後的優惠券實體。
     */
    Coupon createCoupon(Coupon coupon);

    /**
     * 更新現有優惠券的信息。
     * @param coupon 更新後的優惠券實體。
     * @return 更新後的優惠券實體。
     */
    Coupon updateCoupon(Coupon coupon);

    /**
     * 根據優惠券ID刪除優惠券。
     * @param couponId 優惠券的唯一標識符。
     */
    void deleteCoupon(Integer couponId);

    /**
     * 查詢當前有效的優惠券。
     * @return 當前有效的優惠券列表。
     */
    List<Coupon> findActiveCoupons();
}

