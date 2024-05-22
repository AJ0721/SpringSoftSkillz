package com.softskillz.mall.service;

import com.softskillz.mall.dto.ProductQueryParams;
import com.softskillz.mall.dto.ProductRequest;
import com.softskillz.mall.model.Product;

import java.util.List;

public interface ProductService {

    Integer countProduct(ProductQueryParams productQueryParams);

    List<Product> findProducts(ProductQueryParams productQueryParams);

    Product findProductById(Integer productId);

    Integer createProduct(ProductRequest productRequest);

    void updateProduct(Integer productId, ProductRequest productRequest);

    void deleteProductById(Integer productId);
}
