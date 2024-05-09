package com.softskillz.mall.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.repos.ProductRepository;
import com.softskillz.mall.service.ProductService;

/**
 * 商品服務實現類
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // 儲存商品資訊
    @Override
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    // 刪除指定 ID 的商品
    @Override
    public void deleteProduct(Integer productId) {
        productRepository.deleteById(productId);
    }

    // 修改商品資訊
    @Override
    public Product updateProduct(Product product) {
        return productRepository.save(product);
    }

    // 根據 ID 獲取商品資訊，如果找不到則返回 null
    @Override
    public Product getProductById(Integer productId) {
        return productRepository.findById(productId).orElse(null);
    }

    // 獲取所有商品資訊
    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // 根據商品狀態 ID 獲取商品資訊
    @Override
    public List<Product> getProductsByStatusId(Integer statusId) {
        return productRepository.findByProductStatusProductStatusId(statusId);
    }

    // 根據價格範圍獲取商品資訊
    @Override
    public List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        return productRepository.findByPriceRange(minPrice, maxPrice);
    }

    // 根據條件查詢商品
    @Override
    public Page<Product> findProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

}
