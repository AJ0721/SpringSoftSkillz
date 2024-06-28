package com.softskillz.cart.bean.dto;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class VoucherDto {

    private Long voucherId;
    private String voucherName;
    private BigDecimal voucherValue;

    public VoucherDto(Long voucherId, String voucherName, BigDecimal voucherValue) {
        this.voucherId = voucherId;
        this.voucherName = voucherName;
        this.voucherValue = voucherValue;
    }
}
