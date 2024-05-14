package com.softskillz.mall.service.impl;

import com.softskillz.mall.model.ProductType;
import com.softskillz.mall.repos.ProductTypeRepository;
import com.softskillz.mall.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * 實現商品類型相關的業務邏輯。
 * 提供商品類型的查詢和管理功能。
 */
@Service
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    private ProductTypeRepository productTypeRepository;

    /**
     * 獲取所有商品類型。
     * @return 返回一個包含所有商品類型的列表。
     */
    @Override
    public List<ProductType> findAllProductTypes() {
        return productTypeRepository.findAll();
    }

    /**
     * 根據商品類型ID查詢具體的商品類型。
     * @param id 產品類型的ID
     * @return 返回一個Optional，如果找到則包含產品類型，否則為空。
     */
    @Override
    public ProductType findProductTypeById(Integer id) {
        return productTypeRepository.findById(id).orElse(null);
    }

}
