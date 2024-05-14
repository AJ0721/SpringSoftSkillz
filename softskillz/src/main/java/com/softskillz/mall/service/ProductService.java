package com.softskillz.mall.service;

import com.softskillz.mall.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

/**
 * 商品服務接口，定義商品相關的業務邏輯方法。
 * 提供基礎的 CRUD 操作以及動態查詢功能。
 */
public interface ProductService {

    /**
     * 查詢全部商品。
     * @return 所有商品的列表。
     */
    List<Product> findAllProducts();

    /**
     * 根據商品ID查詢單一商品。
     * @param productId 商品的唯一標識符。
     * @return 包含商品的 Optional 實例。
     */
    Optional<Product> findProductById(Integer productId);

    /**
     * 新增商品。
     * @param product 要儲存的商品實體。
     * @return 儲存後的商品。
     */
    Product createProduct(Product product);

    /**
     * 更新現有商品的資訊。
     * @param productId 要更新的商品ID。
     * @param product 更新後的商品實體。
     * @return 更新後的商品。
     */
    Product updateProduct(Integer productId, Product product);

    /**
     * 根據商品ID刪除商品。
     * @param productId 要刪除的商品的ID。
     */
    void deleteProduct(Integer productId);

    /**
     * 基於規格(specification)和分頁設定進行商品查詢。
     * @param spec 查詢條件的規格描述。
     * @param pageable 分頁和排序參數。
     * @return 滿足條件的商品分頁數據。
     */
    Page<Product> findProducts(Specification<Product> spec, Pageable pageable);
}
