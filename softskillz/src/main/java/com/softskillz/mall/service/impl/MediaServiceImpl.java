package com.softskillz.mall.service.impl;

import com.softskillz.mall.model.ProductImage;
import com.softskillz.mall.model.ProductVideo;
import com.softskillz.mall.repos.ProductImageRepository;
import com.softskillz.mall.repos.ProductVideoRepository;
import com.softskillz.mall.service.MediaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 媒體服務實現類，提供商品圖片和影片的管理功能。
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class MediaServiceImpl implements MediaService {

    private final ProductImageRepository productImageRepository;

    private final ProductVideoRepository productVideoRepository;

    @Autowired
    public MediaServiceImpl(ProductImageRepository productImageRepository,
            ProductVideoRepository productVideoRepository) {
        this.productImageRepository = productImageRepository;
        this.productVideoRepository = productVideoRepository;
    }

    /**
     * 儲存商品圖片。
     * @param productImage 商品圖片實體
     * @return 儲存後的商品圖片實體
     */
    @Override
    public ProductImage saveProductImage(ProductImage productImage) {
        return productImageRepository.save(productImage);
    }

    /**
     * 根據商品ID獲取所有相關圖片。
     * @param productId 商品ID
     * @return 商品相關的圖片列表
     */
    @Override
    public List<ProductImage> findProductImagesByProductId(Integer productId) {
        return productImageRepository.findByProductProductId(productId);
    }

    /**
     * 儲存商品影片。
     * @param productVideo 商品影片實體
     * @return 儲存後的商品影片實體
     */
    @Override
    public ProductVideo saveProductVideo(ProductVideo productVideo) {
        return productVideoRepository.save(productVideo);
    }

    /**
     * 根據商品ID獲取所有相關影片。
     * @param productId 商品ID
     * @return 商品相關的影片列表
     */
    @Override
    public List<ProductVideo> findProductVideosByProductId(Integer productId) {
        return productVideoRepository.findByProductProductId(productId);
    }
}
