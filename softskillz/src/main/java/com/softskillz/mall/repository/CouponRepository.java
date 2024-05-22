package com.softskillz.mall.repository;

import com.softskillz.mall.model.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 優惠券數據存取層，提供優惠券相關的數據操作方法。
 */
@Repository
public interface CouponRepository extends JpaRepository<Coupon, Integer> {

    /**
     * 查詢當前有效的優惠券。
     * 只返回在當前時間點仍然有效的優惠券，包括那些尚未到達結束日期的優惠券。
     *
     * @param now 當前時間
     * @return 當前有效的優惠券列表
     */
    @Query("SELECT c FROM Coupon c WHERE c.couponStartDate <= :now AND (c.couponEndDate IS NULL OR c.couponEndDate >= :now)")
    List<Coupon> findActiveCoupons(LocalDateTime now);
}
