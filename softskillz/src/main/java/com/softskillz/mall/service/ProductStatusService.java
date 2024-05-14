package com.softskillz.mall.service;

import com.softskillz.mall.model.ProductStatus;

import java.util.List;

/**
 * 商品狀態服務介面，定義與商品狀態相關的業務邏輯操作。
 */
public interface ProductStatusService {

    /**
     * 獲取所有可用的商品狀態列表。
     * 這個方法主要用於提供給前端顯示，讓用戶能選擇商品的狀態。
     *
     * @return 所有商品狀態的列表，每個商品狀態包含狀態的ID和描述。
     */
    List<ProductStatus> findAllProductStatuses();
}
