package com.softskillz.cart.bean.model;

import org.springframework.stereotype.Component;

import com.softskillz.account.model.bean.StudentBean;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "cart_item")
public class TestCartItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cart_item_id")
	private Long cartItemId;

	@Column(name = "quantity")
	private Integer quantity;

	@ManyToOne(optional = false)
	@Column(name = "product_id", insertable = true, updatable = false, nullable = false)
	private TestProduct testProduct;

	@ManyToOne(optional = false)
	@Column(name = "student_id", insertable = true, updatable = false, nullable = false)
	private StudentBean studentBean;

	// insert
	public TestCartItem(Long cartItemId, Integer quantity, TestProduct testProduct, StudentBean studentBean) {
		this.quantity = quantity;
		this.testProduct = testProduct;
		this.studentBean = studentBean;
	}

	// update
	public TestCartItem(Long cartItemId, Integer quantity) {
		this.cartItemId = cartItemId;
		this.quantity = quantity;
	}


}
