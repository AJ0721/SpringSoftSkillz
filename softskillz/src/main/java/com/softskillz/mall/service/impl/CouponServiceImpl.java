package com.softskillz.mall.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.mall.model.Coupon;
import com.softskillz.mall.repos.CouponRepository;
import com.softskillz.mall.service.CouponService;

/**
 * 這個類別提供了CouponService介面的實現。
 * 它使用CouponRepository來對Coupon模型進行CRUD操作。
 * 所有的方法都是交易性的，意味著它們是單一資料庫交易的一部分。
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class CouponServiceImpl implements CouponService {

    private final CouponRepository couponRepository;

    @Autowired
    public CouponServiceImpl(CouponRepository couponRepository) {
        this.couponRepository = couponRepository;
    }

    /**
     * 創建一個新的優惠券。
     * @param coupon 要創建的優惠券。
     * @return 創建的優惠券。
     */
    @Override
    public Coupon createCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    /**
     * 通過其ID刪除優惠券。
     * @param couponId 要刪除的優惠券的ID。
     */
    @Override
    public void deleteCoupon(Integer couponId) {
        couponRepository.deleteById(couponId);
    }

    /**
     * 更新優惠券。
     * @param coupon 帶有更新信息的優惠券。
     * @return 更新的優惠券。
     */
    @Override
    public Coupon updateCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    /**
     * 通過其ID獲取優惠券。
     * @param couponId 要獲取的優惠券的ID。
     * @return 獲取的優惠券，如果不存在具有給定ID的優惠券，則返回null。
     */
    @Override
    public Coupon getCouponById(Integer couponId) {
        return couponRepository.findById(couponId).orElse(null);
    }

    /**
     * 獲取所有優惠券。
     * @return 所有優惠券的列表。
     */
    @Override
    public List<Coupon> getAllCoupons() {
        return couponRepository.findAll();
    }

    /**
     * 獲取所有可用優惠券。
     * @return 所有可用優惠券的列表。
     */
    @Override
    public List<Coupon> getActiveCoupons() {
        return couponRepository.findActiveCoupons(LocalDateTime.now());
    }
}
