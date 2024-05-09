package com.softskillz.mall.service;

import java.math.BigDecimal;
import java.util.List;

import com.softskillz.mall.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

/**
 * 商品服務介面
 */
public interface ProductService {

    /**
     * 儲存商品
     *
     * @param product 商品實體
     * @return 儲存後的商品實體
     */
    Product saveProduct(Product product);

    /**
     * 根據商品ID刪除商品
     *
     * @param productId 商品ID
     */
    void deleteProduct(Integer productId);

    /**
     * 更新商品資訊
     *
     * @param product 商品實體
     * @return 更新後的商品實體
     */
    Product updateProduct(Product product);

    /**
     * 根據商品ID獲取商品資訊
     *
     * @param productId 商品ID
     * @return 商品實體,若不存在則返回null
     */
    Product getProductById(Integer productId);

    /**
     * 獲取所有商品列表
     *
     * @return 所有商品列表
     */
    List<Product> getAllProducts();

    /**
     * 根據商品狀態ID獲取商品列表
     *
     * @param statusId 商品狀態ID
     * @return 指定狀態的商品列表
     */
    List<Product> getProductsByStatusId(Integer statusId);

    /**
     * 根據價格範圍獲取商品列表
     *
     * @param minPrice 最低價格
     * @param maxPrice 最高價格
     * @return 指定價格範圍內的商品列表
     */
    List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);

    /**
     * 根據過濾條件和分頁信息查詢商品
     *
     * @param spec 過濾條件
     * @param pageable 分頁和排序參數
     * @return 商品分頁數據
     */
    Page<Product> findProducts(Pageable pageable);

}
