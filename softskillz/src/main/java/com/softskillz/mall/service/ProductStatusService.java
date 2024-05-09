package com.softskillz.mall.service;

import java.util.List;

import com.softskillz.mall.model.ProductStatus;

/**
 * 商品狀態服務介面
 */
public interface ProductStatusService {

    /**
     * 獲取所有商品狀態
     *
     * @return 所有商品狀態列表
     */
    List<ProductStatus> getAllProductStatuses();
}
