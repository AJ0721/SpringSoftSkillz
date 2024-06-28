package com.softskillz.cart.bean.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.softskillz.cart.enums.ProductStatusEnum;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestProductDto {

    private Long productId;
    private String productName;
    private BigDecimal productPrice;
    private String productDescription;
    private Integer productStock;
    private ProductStatusEnum productStatus;
    private LocalDateTime createAt;
    private LocalDateTime updatedAt;
    private List<ProductImageDto> productImgs;
    private ProductCategoryDto productCategory;

    public TestProductDto(Long productId, String productName, BigDecimal productPrice, String productDescription,
                          Integer productStock, ProductStatusEnum productStatus, LocalDateTime createAt,
                          LocalDateTime updatedAt, List<ProductImageDto> productImgs, ProductCategoryDto productCategory) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productDescription = productDescription;
        this.productStock = productStock;
        this.productStatus = productStatus;
        this.createAt = createAt;
        this.updatedAt = updatedAt;
        this.productImgs = productImgs;
        this.productCategory = productCategory;
    }
}
