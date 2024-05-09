package com.softskillz.mall.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.ProductStatus;

/**
 * 商品狀態數據存取層
 */
@Repository
public interface ProductStatusRepository extends JpaRepository<ProductStatus, Integer> {
}
