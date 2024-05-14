package com.softskillz.mall.repos;

import com.softskillz.mall.model.ProductVideo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品影片數據存取層，處理商品影片的數據查詢和操作。
 */
@Repository
public interface ProductVideoRepository extends JpaRepository<ProductVideo, Integer> {

    /**
     * 根據商品ID查詢相關影片。
     * 用於獲取與特定商品關聯的所有影片資料。
     *
     * @param productId 商品ID
     * @return 商品影片列表
     */
    @Query("SELECT pv FROM ProductVideo pv WHERE pv.product.productId = :productId")
    List<ProductVideo> findByProductProductId(Integer productId);
}
