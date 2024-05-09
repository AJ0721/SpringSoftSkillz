package com.softskillz.mall.repos;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.softskillz.mall.model.ProductImage;

/**
 * 商品圖片數據存取層
 */
@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {

    /**
     * 根據商品ID查詢相關圖片
     *
     * @param productId 商品ID
     * @return 商品圖片列表
     */
    List<ProductImage> findByProductProductId(Integer productId);
}
