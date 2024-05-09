package com.softskillz.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.mall.model.ProductImage;
import com.softskillz.mall.model.ProductVideo;
import com.softskillz.mall.repos.ProductImageRepository;
import com.softskillz.mall.repos.ProductVideoRepository;
import com.softskillz.mall.service.MediaService;

/**
 * 媒體服務實現類
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
     * 儲存商品圖片
     * @param productImage 商品圖片
     * @return 儲存後的商品圖片
     */
    @Override
    public ProductImage saveProductImage(ProductImage productImage) {
        return productImageRepository.save(productImage);
    }

    /**
     * 根據商品ID獲取商品圖片
     * @param productId 商品ID
     * @return 商品ID對應的商品圖片列表
     */
    @Override
    public List<ProductImage> getProductImagesByProductId(Integer productId) {
        return productImageRepository.findByProductProductId(productId);
    }


    /**
     * 儲存商品影片
     * @param productVideo 商品影片
     * @return 儲存後的商品影片
     */
    @Override
    public ProductVideo saveProductVideo(ProductVideo productVideo) {
        return productVideoRepository.save(productVideo);
    }

    /**
     * 根據商品ID獲取商品影片
     * @param productId 商品ID
     * @return 商品ID對應的商品影片列表
     */
    @Override
    public List<ProductVideo> getProductVideosByProductId(Integer productId) {
        return productVideoRepository.findByProductProductId(productId);
    }
}
