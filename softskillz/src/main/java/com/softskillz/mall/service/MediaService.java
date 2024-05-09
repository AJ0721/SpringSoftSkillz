package com.softskillz.mall.service;

import java.util.List;

import com.softskillz.mall.model.ProductImage;
import com.softskillz.mall.model.ProductVideo;

/**
 * 媒體服務介面
 */
public interface MediaService {

    /**
     * 保存商品圖片
     *
     * @param productImage 商品圖片實體
     * @return 保存成功的商品圖片實體
     */
    ProductImage saveProductImage(ProductImage productImage);

    /**
     * 根據商品ID獲取相關圖片
     *
     * @param productId 商品ID
     * @return 商品圖片列表
     */
    List<ProductImage> getProductImagesByProductId(Integer productId);

    /**
     * 保存商品影片
     *
     * @param productVideo 商品影片實體
     * @return 保存成功的商品影片實體
     */
    ProductVideo saveProductVideo(ProductVideo productVideo);

    /**
     * 根據商品ID獲取相關影片
     *
     * @param productId 商品ID
     * @return 商品影片列表
     */
    List<ProductVideo> getProductVideosByProductId(Integer productId);
}
