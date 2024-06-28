package com.softskillz.cart.bean.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ProductImageDto {

    private Long imgUrlId;
    private String imgUrl;
    private TestProductDto testProduct;

    public ProductImageDto(Long imgUrlId, String imgUrl, TestProductDto testProduct) {
        this.imgUrlId = imgUrlId;
        this.imgUrl = imgUrl;
        this.testProduct = testProduct;
    }
}
