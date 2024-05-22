package com.softskillz.mall.dao;

import com.softskillz.mall.dto.ProductQueryParams;
import com.softskillz.mall.dto.ProductRequest;
import com.softskillz.mall.model.Product;

import java.util.List;

public interface ProductDao {

    Integer countProduct(ProductQueryParams productQueryParams);

    List<Product> findProducts(ProductQueryParams productQueryParams);

    Product findProductById(Integer productId);

    Integer createProduct(ProductRequest productRequest);

    void updateProduct(Integer productId, ProductRequest productRequest);

    // 訂單完成後更新商品庫存
    //void updateStock(Integer productId, Integer stock);

    void deleteProductById(Integer productId);
}
