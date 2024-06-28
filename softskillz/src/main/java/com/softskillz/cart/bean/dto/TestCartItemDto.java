package com.softskillz.cart.bean.dto;

import com.softskillz.forum.model.dto.StudentDto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestCartItemDto {

    private Long cartItemId;
    private Integer quantity;
    private TestProductDto testProduct;
    private StudentDto studentBean;

    public TestCartItemDto(Long cartItemId, Integer quantity, TestProductDto testProduct, StudentDto studentBean) {
        this.cartItemId = cartItemId;
        this.quantity = quantity;
        this.testProduct = testProduct;
        this.studentBean = studentBean;
    }
}
