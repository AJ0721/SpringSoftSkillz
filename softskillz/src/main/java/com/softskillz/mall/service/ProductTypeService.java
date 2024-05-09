package com.softskillz.mall.service;

import java.util.List;

import com.softskillz.mall.model.ProductType;

/**
 * 產品類型服務介面
 * 這個介面定義了所有與產品類型相關的業務邏輯方法
 */
public interface ProductTypeService {

    /**
     * 獲取所有產品類型
     *
     * @return 一個包含所有產品類型的列表
     */
    List<ProductType> getAllProductTypes();

    /**
     * 根據ID獲取產品類型
     *
     * @param id 產品類型的ID
     * @return 與ID匹配的產品類型，如果找不到則返回null
     */
    ProductType getProductTypeById(Integer id);

}
