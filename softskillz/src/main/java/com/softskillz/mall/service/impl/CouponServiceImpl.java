package com.softskillz.mall.service.impl;

import com.softskillz.mall.model.Coupon;
import com.softskillz.mall.repos.CouponRepository;
import com.softskillz.mall.service.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * 優惠券服務實現類，實現了 CouponService 介面中定義的所有方法。
 * 主要負責優惠券的 CRUD 操作及有效優惠券的查詢。
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class CouponServiceImpl implements CouponService {

    @Autowired
    private CouponRepository couponRepository;

    @Override
    public List<Coupon> findAllCoupons() {
        return couponRepository.findAll();
    }

    @Override
    public Optional<Coupon> findCouponById(Integer couponId) {
        return couponRepository.findById(couponId);
    }

    @Override
    public Coupon createCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    @Override
    public Coupon updateCoupon(Coupon coupon) {
        return couponRepository.save(coupon);
    }

    @Override
    public void deleteCoupon(Integer couponId) {
        couponRepository.deleteById(couponId);
    }

    /**
     * 查詢當前有效的優惠券。
     * 優惠券的有效性是基於其開始和結束日期來確定的。
     *
     * @return 返回當前時間點有效的優惠券列表。
     */
    @Override
    public List<Coupon> findActiveCoupons() {
        return couponRepository.findActiveCoupons(LocalDateTime.now());
    }
}
