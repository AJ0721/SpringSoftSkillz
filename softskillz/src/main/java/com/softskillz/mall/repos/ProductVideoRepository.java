package com.softskillz.mall.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.ProductVideo;

/**
 * 商品影片數據存取層
 */
@Repository
public interface ProductVideoRepository extends JpaRepository<ProductVideo, Integer> {

    /**
     * 根據商品ID查詢相關影片
     *
     * @param productId 商品ID
     * @return 商品影片列表
     */
    @Query("SELECT pv FROM ProductVideo pv WHERE pv.product.productId = :productId")
    List<ProductVideo> findByProductProductId(Integer productId);
}