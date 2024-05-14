package com.softskillz.mall.repos;

import com.softskillz.mall.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

/**
 * 商品數據存取層，提供商品相關的數據操作方法。
 * 支援動態查詢機制。
 */
@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {
}
