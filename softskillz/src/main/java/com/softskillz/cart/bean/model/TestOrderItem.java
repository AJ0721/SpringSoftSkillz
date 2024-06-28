package com.softskillz.cart.bean.model;

import java.math.BigDecimal;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@Component
@Entity
@Table(name = "order_item")
public class TestOrderItem {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_item_id")	
	private Long orderItemId;

	@Column(name = "price")
	private BigDecimal orderPrice;

	@Column(name = "quantity")
	private Integer orderQuantity;

	@Column(name = "item_subtotal", insertable = false, updatable = false)
	private BigDecimal orderSubtotal = BigDecimal.ZERO ;

	@ManyToOne(optional = false)
	@JoinColumn(name = "product_id", referencedColumnName = "product_id")
	private TestProduct testProduct;

	@ManyToOne(optional = false)
	@JoinColumn(name = "order_id", referencedColumnName = "order_id")
	private TestOrder testOrder;

	
	//insert
	public TestOrderItem(BigDecimal orderPrice, Integer orderQuantity, Integer orderSubtotal, TestProduct testProduct,
			TestOrder testOrder) {
		this.orderPrice = orderPrice;
		this.orderQuantity = orderQuantity;
		this.testProduct = testProduct;
		this.testOrder = testOrder;
	}
	
	

}
