package com.softskillz.mall.service;

import com.softskillz.mall.model.ProductImage;
import com.softskillz.mall.model.ProductVideo;

import java.util.List;

/**
 * 提供商品媒體檔（圖片與影片）的業務處理介面。
 */
public interface MediaService {

    /**
     * 根據商品ID獲取所有相關的商品圖片。
     * @param productId 商品的唯一標識符
     * @return 該商品的所有圖片列表
     */
    List<ProductImage> findProductImagesByProductId(Integer productId);

    /**
     * 根據商品ID獲取所有相關的商品影片。
     * @param productId 商品的唯一標識符
     * @return 該商品的所有影片列表
     */
    List<ProductVideo> findProductVideosByProductId(Integer productId);

    /**
     * 儲存商品圖片資訊。
     * @param productImage 商品圖片實體對象
     * @return 儲存後的商品圖片實體，包括資料庫生成的ID
     */
    ProductImage saveProductImage(ProductImage productImage);

    /**
     * 儲存商品影片資訊。
     * @param productVideo 商品影片實體對象
     * @return 儲存後的商品影片實體，包括資料庫生成的ID
     */
    ProductVideo saveProductVideo(ProductVideo productVideo);
}
