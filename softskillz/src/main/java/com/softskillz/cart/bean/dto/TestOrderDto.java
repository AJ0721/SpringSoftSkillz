package com.softskillz.cart.bean.dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.softskillz.cart.enums.OrderStatusEnum;
import com.softskillz.cart.enums.PaymentEnum;
import com.softskillz.forum.model.dto.StudentDto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TestOrderDto {

    private Long orderId;
    private BigDecimal orderSubtotal;
    private PaymentEnum paymentMethod;
    private String shippingAddress;
    private OrderStatusEnum orderStatus;
    private String invoice;
    private LocalDateTime createAt;
    private LocalDateTime updateAt;
    private StudentDto studentDto;
    private VoucherDto voucher;
    private List<TestOrderItemDto> orderItems;

    public TestOrderDto(Long orderId, BigDecimal orderSubtotal, PaymentEnum paymentMethod, String shippingAddress,
                        OrderStatusEnum orderStatus, String invoice, LocalDateTime createAt, LocalDateTime updateAt,
                        StudentDto studentDto, VoucherDto voucher, List<TestOrderItemDto> orderItems) {
        this.orderId = orderId;
        this.orderSubtotal = orderSubtotal;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.orderStatus = orderStatus;
        this.invoice = invoice;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.studentDto = studentDto;
        this.voucher = voucher;
        this.orderItems = orderItems;
    }
}
