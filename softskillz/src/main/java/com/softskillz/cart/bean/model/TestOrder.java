package com.softskillz.cart.bean.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.StudentBean;
import com.softskillz.cart.enums.OrderStatusEnum;
import com.softskillz.cart.enums.PaymentEnum;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Component
@Entity
@Table(name = "test_order")
public class TestOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id")
	private Long orderId;

	@Column(name = "order_subtotal")
	private BigDecimal orderSubtotal;

	@Column(name = "payment_method")
	private PaymentEnum paymentMethod = PaymentEnum.CASH_ON_DELIVERY;

	@Column(name = "shipping_address")
	private String shippingAddress;

	@Column(name = "order_status")
	private OrderStatusEnum orderStatus = OrderStatusEnum.TO_BE_PAID;

	@Column(name = "invoice")
	private String invoice;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@Column(name = "create_at", updatable = false)
	private LocalDateTime createAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@Column(name = "update_at", insertable = false, updatable = false)
	private LocalDateTime updateAt;

	@ManyToOne(optional = false)
	@Column(name = "student_id", insertable = true, updatable = false, nullable = false)
	private StudentBean studentBean;

	@OneToOne(optional = true)
	@Column(name = "voucher_id", updatable = false)
	private Voucher voucher;

	//insert
	public TestOrder(PaymentEnum paymentMethod, String shippingAddress, StudentBean studentBean, Voucher voucher) {
		this.paymentMethod = paymentMethod;
		this.shippingAddress = shippingAddress;
		this.studentBean = studentBean;
		this.voucher = voucher;
	}

	public void setOrderStatus(OrderStatusEnum newStatus) {
		this.orderStatus=newStatus;
		
	}
	

	
}
