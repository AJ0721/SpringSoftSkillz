package com.softskillz.mall.repos;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.Product;

/**
 * 商品數據存取層
 */
@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {

	/**
	 * 根據商品狀態ID查詢商品
	 *
	 * @param statusId 商品狀態ID
	 * @return 商品列表
	 */
	List<Product> findByProductStatusProductStatusId(Integer statusId);

	/**
	 * 根據價格範圍查詢商品
	 *
	 * @param minPrice 最低價格
	 * @param maxPrice 最高價格
	 * @return 商品列表
	 */
	@Query("SELECT p FROM Product p WHERE p.productPrice BETWEEN :minPrice AND :maxPrice")
	List<Product> findByPriceRange(@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice);

}
