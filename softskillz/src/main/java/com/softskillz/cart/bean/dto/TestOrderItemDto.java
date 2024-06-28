package com.softskillz.cart.bean.dto;


import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestOrderItemDto {

    private Long orderItemId;
    private BigDecimal orderPrice;
    private Integer orderQuantity;
    private BigDecimal orderSubtotal;
    private TestProductDto testProduct;
    private TestOrderDto testOrder;

    public TestOrderItemDto(Long orderItemId, BigDecimal orderPrice, Integer orderQuantity, BigDecimal orderSubtotal,
    		TestProductDto testProduct, TestOrderDto testOrder) {
        this.orderItemId = orderItemId;
        this.orderPrice = orderPrice;
        this.orderQuantity = orderQuantity;
        this.orderSubtotal = orderSubtotal;
        this.testProduct = testProduct;
        this.testOrder = testOrder;
    }
}

