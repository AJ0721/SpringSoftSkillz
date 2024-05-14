package com.softskillz.mall.repos;

import com.softskillz.mall.model.ProductType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * 商品類型數據存取層，提供商品類型相關的數據操作方法。
 */
@Repository
public interface ProductTypeRepository extends JpaRepository<ProductType, Integer> {
}
