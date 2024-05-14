package com.softskillz.mall.repos;

import com.softskillz.mall.model.CouponType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * 優惠券類型數據存取層，提供優惠券類型相關的數據操作方法。
 */
@Repository
public interface CouponTypeRepository extends JpaRepository<CouponType, Integer> {
    // 根據類型名稱查詢優惠券類型(還沒寫相關方法)
    //CouponType findByTypeName(String typeName);

}
