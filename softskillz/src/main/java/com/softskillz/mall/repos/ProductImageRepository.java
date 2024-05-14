package com.softskillz.mall.repos;

import com.softskillz.mall.model.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品圖片數據存取層，提供商品圖片的數據操作方法。
 */
@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {

    /**
     * 根據商品ID查詢相關圖片。
     * 此方法用於獲取某一商品的所有圖片。
     *
     * @param productId 商品ID
     * @return 商品圖片列表
     */
    List<ProductImage> findByProductProductId(Integer productId);
}
