package com.softskillz.mall.repos;

import com.softskillz.mall.model.ProductStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * 商品狀態數據存取層，提供商品狀態相關的數據操作方法。
 */
@Repository
public interface ProductStatusRepository extends JpaRepository<ProductStatus, Integer> {
}
