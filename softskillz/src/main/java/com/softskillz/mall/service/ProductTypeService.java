package com.softskillz.mall.service;

import com.softskillz.mall.model.ProductType;

import java.util.List;

/**
 * 商品類型服務介面，定義所有與商品類型相關的業務操作。
 * 這個介面提供方法來獲取所有商品類型和根據ID查詢特定的商品類型。
 */
public interface ProductTypeService {

    /**
     * 獲取所有商品類型。
     * 這個方法返回所有現有的商品類型，可用於商品分類選擇界面。
     *
     * @return 包含所有商品類型的列表，每個商品類型包括其ID和描述。
     */
    List<ProductType> findAllProductTypes();

    /**
     * 根據商品類型ID獲取具體的商品類型。
     * 這個方法用於當需要根據用戶選擇的類型ID來獲取詳細信息時。
     *
     * @param id 商品類型的唯一標識符
     * @return 與提供的ID對應的商品類型，若無匹配則返回null。
     */
    ProductType findProductTypeById(Integer id);

}
