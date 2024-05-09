package com.softskillz.mall.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.CouponType;

/**
 * 優惠券類型數據存取層
 */
@Repository
public interface CouponTypeRepository extends JpaRepository<CouponType, Integer> {
}
