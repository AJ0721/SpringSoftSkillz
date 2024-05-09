package com.softskillz.mall.repos;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.Coupon;

/**
 * 優惠券數據存取層
 */
@Repository
public interface CouponRepository extends JpaRepository<Coupon, Integer> {

    /**
     * 查詢當前有效的優惠券
     *
     * @param now 當前時間
     * @return 有效的優惠券列表
     */
    @Query("SELECT c FROM Coupon c WHERE c.couponStartDate <= :now AND (c.couponEndDate IS NULL OR c.couponEndDate >= :now)")
    List<Coupon> findActiveCoupons(LocalDateTime now);
}
