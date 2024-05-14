package com.softskillz.mall.controller;

import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;
import com.softskillz.mall.specifications.ProductSpecifications;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商品控制器，負責處理商品相關的 HTTP 請求
 */
@RestController
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 獲取全部商品列表
    @GetMapping
    public List<Product> getAllProducts() {
        return productService.findAllProducts();
    }

    // 根據商品 ID 獲取商品
    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable Integer id) {
        return productService.findProductById(id)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    // 新增商品
    @PostMapping
    public Product createProduct(@RequestBody Product product) {
        return productService.createProduct(product);
    }

    // 更新商品
    @PutMapping("/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Integer id, @RequestBody Product product) {
        try {
            Product updatedProduct = productService.updateProduct(id, product);
            return ResponseEntity.ok(updatedProduct);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // 刪除商品
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Integer id) {
        productService.deleteProduct(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/list")
    public ResponseEntity<Page<Product>> listProducts(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "productId", required = false) Integer productId,
            @RequestParam(value = "typeId", required = false) Integer typeId,
            @RequestParam(value = "statusId", required = false) Integer statusId,
            @RequestParam(value = "minPrice", required = false) BigDecimal minPrice,
            @RequestParam(value = "maxPrice", required = false) BigDecimal maxPrice,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "sort", defaultValue = "productId") String sort,
            @RequestParam(value = "direction", defaultValue = "ASC") Sort.Direction direction
    ) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sort));
        Page<Product> products = productService.findProducts(
                ProductSpecifications.withDynamicQuery(name, productId, typeId, statusId, minPrice, maxPrice),
                pageable
        );
        return ResponseEntity.ok(products);
    }
}

