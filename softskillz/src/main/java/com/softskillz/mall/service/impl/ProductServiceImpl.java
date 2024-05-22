package com.softskillz.mall.service.impl;

import com.softskillz.mall.dao.ProductDao;
import com.softskillz.mall.dto.ProductQueryParams;
import com.softskillz.mall.dto.ProductRequest;
import com.softskillz.mall.model.Product;
import com.softskillz.mall.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ProductServiceImpl implements ProductService {

    private final ProductDao productDao;

    @Autowired
    public ProductServiceImpl(ProductDao productDao) {
        this.productDao = productDao;
    }

    @Override
    public Integer countProduct(ProductQueryParams productQueryParams) {
        return productDao.countProduct(productQueryParams);
    }

    @Override
    public List<Product> findProducts(ProductQueryParams productQueryParams) {
        return productDao.findProducts(productQueryParams);
    }

    @Override
    public Product findProductById(Integer productId) {
        return productDao.findProductById(productId);
    }

    @Override
    public Integer createProduct(ProductRequest productRequest) {
        return productDao.createProduct(productRequest);
    }

    @Override
    public void updateProduct(Integer productId, ProductRequest productRequest) {
        productDao.updateProduct(productId, productRequest);
    }

    @Override
    public void deleteProductById(Integer productId) {
        productDao.deleteProductById(productId);
    }
}
