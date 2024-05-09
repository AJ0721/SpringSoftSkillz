package com.softskillz.mall.service.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softskillz.mall.model.ProductType;
import com.softskillz.mall.repos.ProductTypeRepository;
import com.softskillz.mall.service.ProductTypeService;

@Service
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    private ProductTypeRepository productTypeRepository;

    // 獲取所有產品類型的方法
    @Override
    public List<ProductType> getAllProductTypes() {
        return productTypeRepository.findAll();
    }

    // 根據ID獲取產品類型的方法
    @Override
    public ProductType getProductTypeById(Integer id) {
        Optional<ProductType> optionalProductType = productTypeRepository.findById(id);
        return optionalProductType.orElse(null);
    }

}
