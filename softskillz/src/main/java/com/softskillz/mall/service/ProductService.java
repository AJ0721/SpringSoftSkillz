package com.softskillz.mall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.repos.ProductRepository;

@Service
@Transactional
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    // 查詢所有商品
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // 根據商品 ID 查詢商品
    public Product getProductById(Integer productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "找不到 ID 為 " + productId + " 的產品"));
    }

    // 分頁查詢商品
    public Page<Product> findAllByPage(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    // 新增商品
    public Product addProduct(Product product) {
        return productRepository.save(product);
    }

    // 更新商品
    public Product updateProduct(Integer productId, Product updatedProduct) {
        return productRepository.findById(productId)
                .map(product -> {
                    product.setProductName(updatedProduct.getProductName());
                    product.setProductDescription(updatedProduct.getProductDescription());
                    product.setProductPrice(updatedProduct.getProductPrice());
                    product.setProductStock(updatedProduct.getProductStock());
                    product.setProductTargetAudience(updatedProduct.getProductTargetAudience());
                    product.setProductCreateDate(updatedProduct.getProductCreateDate());
                    product.setProductUpdateDate(updatedProduct.getProductUpdateDate());
                    product.setProductImageUrl(updatedProduct.getProductImageUrl());
                    return productRepository.save(product);
                })
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "找不到 ID 為 " + productId + " 的產品"));
    }

    // 刪除商品
    public void deleteProduct(Integer productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "找不到 ID 為 " + productId + " 的產品"));
        productRepository.delete(product);
    }

}
