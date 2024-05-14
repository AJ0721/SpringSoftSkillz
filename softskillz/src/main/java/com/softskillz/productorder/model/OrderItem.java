package com.softskillz.productorder.model;

import jakarta.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
@Entity
@Table(name = "orderitem")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer order_item_id;
    private Integer order_id;
    private Integer product_id;
    private Integer quantity;
    private Integer product_price;
    private Integer sub_total;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", referencedColumnName = "order_id", insertable = false, updatable = false)
    private Order order;

	public Integer getOrder_item_id() {
		return order_item_id;
	}

	public void setOrder_item_id(Integer order_item_id) {
		this.order_item_id = order_item_id;
	}

	public Integer getOrder_id() {
		return order_id;
	}

	public void setOrder_id(Integer order_id) {
		this.order_id = order_id;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getProduct_price() {
		return product_price;
	}

	public void setProduct_price(Integer product_price) {
		this.product_price = product_price;
	}

	public Integer getSub_total() {
		return sub_total;
	}

	public void setSub_total(Integer sub_total) {
		this.sub_total = sub_total;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

}
