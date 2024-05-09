package com.softskillz.mall.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.softskillz.mall.model.ProductStatus;
import com.softskillz.mall.service.ProductStatusService;

/**
 * 商品狀態控制器
 */
@RestController
@RequestMapping("/product-statuses")
public class ProductStatusController {

    private final ProductStatusService productStatusService;

    @Autowired
    public ProductStatusController(ProductStatusService productStatusService) {
        this.productStatusService = productStatusService;
    }

    /**
     * 獲取所有商品狀態
     *
     * @return 所有商品狀態列表
     */
    @GetMapping
    public ResponseEntity<List<ProductStatus>> getAllProductStatuses() {
        List<ProductStatus> statuses = productStatusService.getAllProductStatuses();
        return ResponseEntity.ok(statuses);
    }
}
