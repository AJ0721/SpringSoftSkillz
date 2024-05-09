package com.softskillz.mall.controller;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.softskillz.mall.specifications.ProductSpecifications;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;

/**
 * 商品管理控制器
 */
@RestController
@RequestMapping("/products")
public class ProductController {

    private final ProductService productService;

    @Autowired
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    /**
     * 新增商品
     *
     * @param product 商品實體
     * @return 新增成功的商品實體
     */
    @PostMapping
    public ResponseEntity<Product> createProduct(@RequestBody Product product) {
        Product savedProduct = productService.saveProduct(product);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedProduct);
    }

    /**
     * 根據商品ID獲取商品
     *
     * @param id 商品ID
     * @return 商品實體
     */
    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable Integer id) {
        Product product = productService.getProductById(id);
        if (product == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found");
        }
        return ResponseEntity.ok(product);
    }

    /**
     * 獲取所有商品
     *
     * @return 所有商品列表
     */
    @GetMapping
    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return ResponseEntity.ok(products);
    }

    /**
     * 更新商品
     *
     * @param id      商品ID
     * @param product 商品實體
     * @return 更新成功的商品實體
     */
    @PutMapping("/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Integer id, @RequestBody Product product) {
        product.setProductId(id);
        Product updatedProduct = productService.updateProduct(product);
        return ResponseEntity.ok(updatedProduct);
    }

    /**
     * 刪除商品
     *
     * @param id 商品ID
     * @return 空響應體
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Integer id) {
        productService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }

    /**
     * 根據商品狀態獲取商品列表
     *
     * @param statusId 商品狀態ID
     * @return 指定狀態的商品列表
     */
    @GetMapping("/byStatus/{statusId}")
    public ResponseEntity<List<Product>> getProductsByStatus(@PathVariable Integer statusId) {
        List<Product> products = productService.getProductsByStatusId(statusId);
        return ResponseEntity.ok(products);
    }

    /**
     * 根據價格範圍獲取商品列表
     *
     * @param minPrice 最低價格
     * @param maxPrice 最高價格
     * @return 指定價格範圍內的商品列表
     */
    @GetMapping("/byPriceRange")
    public ResponseEntity<List<Product>> getProductsByPriceRange(@RequestParam BigDecimal minPrice,
            @RequestParam BigDecimal maxPrice) {
        List<Product> products = productService.getProductsByPriceRange(minPrice, maxPrice);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/list")
    public ResponseEntity<Page<Product>> listProducts(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "sort", defaultValue = "productName") String sort,
            @RequestParam(value = "direction", defaultValue = "ASC") Sort.Direction direction) {
        // 根據傳入的分頁大小建立分頁請求
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sort));
        // 調用服務層方法獲取分頁數據
        Page<Product> products = productService.findProducts(pageable);
        // 返回分頁數據
        return ResponseEntity.ok(products);
    }

}
