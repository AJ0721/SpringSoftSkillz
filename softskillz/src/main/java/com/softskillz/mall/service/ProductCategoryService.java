package com.softskillz.mall.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.mall.model.ProductCategory;
import com.softskillz.mall.repos.ProductCategoryRepository;

@Service
public class ProductCategoryService {

    @Autowired
    private ProductCategoryRepository productCategoryRepository;

    // 查詢所有商品類別
    public List<ProductCategory> getAllProductCategories() {
        return productCategoryRepository.findAll();
    }
}