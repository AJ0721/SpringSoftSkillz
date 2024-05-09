package com.softskillz.mall.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.softskillz.mall.model.ProductStatus;
import com.softskillz.mall.repos.ProductStatusRepository;
import com.softskillz.mall.service.ProductStatusService;

/**
 * 商品狀態服務實現類
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
     * 獲取所有商品狀態的方法
     * @return 返回所有商品狀態的列表
     */
    @Override
    public List<ProductStatus> getAllProductStatuses() {
        return productStatusRepository.findAll();
    }
}
