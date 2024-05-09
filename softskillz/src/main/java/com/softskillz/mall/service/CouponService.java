package com.softskillz.mall.service;

import java.util.List;

import com.softskillz.mall.model.Coupon;

/**
 * 優惠券服務介面
 */
public interface CouponService {

    /**
     * 創建優惠券
     *
     * @param coupon 優惠券實體
     * @return 創建成功的優惠券實體
     */
    Coupon createCoupon(Coupon coupon);

    /**
     * 根據ID刪除優惠券
     *
     * @param couponId 優惠券ID
     */
    void deleteCoupon(Integer couponId);

    /**
     * 更新優惠券
     *
     * @param coupon 優惠券實體
     * @return 更新成功的優惠券實體
     */
    Coupon updateCoupon(Coupon coupon);

    /**
     * 根據ID獲取優惠券
     *
     * @param couponId 優惠券ID
     * @return 優惠券實體,若不存在則返回null
     */
    Coupon getCouponById(Integer couponId);

    /**
     * 獲取所有優惠券
     *
     * @return 所有優惠券列表
     */
    List<Coupon> getAllCoupons();

    /**
     * 獲取當前有效的優惠券
     *
     * @return 有效的優惠券列表
     */
    List<Coupon> getActiveCoupons();
}
