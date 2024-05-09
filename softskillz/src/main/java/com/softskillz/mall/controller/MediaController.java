package com.softskillz.mall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.mall.model.ProductImage;
import com.softskillz.mall.model.ProductVideo;
import com.softskillz.mall.service.MediaService;

/**
 * 媒體控制器
 */
@RestController
@RequestMapping("/media")
public class MediaController {

    private final MediaService mediaService;

    @Autowired
    public MediaController(MediaService mediaService) {
        this.mediaService = mediaService;
    }

    /**
     * 添加商品圖片
     *
     * @param productImage 商品圖片實體
     * @return 添加成功的商品圖片實體
     */
    @PostMapping("/images")
    public ResponseEntity<ProductImage> addProductImage(@RequestBody ProductImage productImage) {
        ProductImage savedImage = mediaService.saveProductImage(productImage);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedImage);
    }

    /**
     * 根據商品ID獲取相關圖片
     *
     * @param productId 商品ID
     * @return 商品圖片列表
     */
    @GetMapping("/images/{productId}")
    public ResponseEntity<List<ProductImage>> getProductImages(@PathVariable Integer productId) {
        List<ProductImage> productImages = mediaService.getProductImagesByProductId(productId);
        return ResponseEntity.ok(productImages);
    }

    /**
     * 添加商品影片
     *
     * @param productVideo 商品影片實體
     * @return 添加成功的商品影片實體
     */
    @PostMapping("/videos")
    public ResponseEntity<ProductVideo> addProductVideo(@RequestBody ProductVideo productVideo) {
        ProductVideo savedVideo = mediaService.saveProductVideo(productVideo);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedVideo);
    }

    /**
     * 根據商品ID獲取相關影片
     *
     * @param productId 商品ID
     * @return 商品影片列表
     */
    @GetMapping("/videos/{productId}")
    public ResponseEntity<List<ProductVideo>> getProductVideos(@PathVariable Integer productId) {
        List<ProductVideo> productVideos = mediaService.getProductVideosByProductId(productId);
        return ResponseEntity.ok(productVideos);
    }
}
