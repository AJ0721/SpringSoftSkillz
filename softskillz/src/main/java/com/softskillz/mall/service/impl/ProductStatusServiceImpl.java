package com.softskillz.mall.service.impl;

import com.softskillz.mall.model.ProductStatus;
import com.softskillz.mall.repos.ProductStatusRepository;
import com.softskillz.mall.service.ProductStatusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 實現商品狀態相關的業務邏輯。
 * 提供商品狀態的查詢功能。
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class ProductStatusServiceImpl implements ProductStatusService {

    private final ProductStatusRepository productStatusRepository;

    @Autowired
    public ProductStatusServiceImpl(ProductStatusRepository productStatusRepository) {
        this.productStatusRepository = productStatusRepository;
    }

    /**
     * 獲取所有商品狀態列表。
     * @return 返回一個包含所有商品狀態的列表，這有助於在用戶界面上進行狀態管理或顯示。
     */
    @Override
    public List<ProductStatus> findAllProductStatuses() {
        return productStatusRepository.findAll();
    }
}
