package com.softskillz.mall.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.ProductType;

/**
 * 商品類型數據存取層
 */
@Repository
public interface ProductTypeRepository extends JpaRepository<ProductType, Integer> {
}
